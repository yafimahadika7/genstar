<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Models\Transaksi;
use App\Models\Kategori;
use App\Models\Vendor;

class TransaksiController extends Controller
{
    public function index(Request $request)
    {
        $query = Transaksi::with(['vendor', 'kategori', 'user']);

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->whereHas('vendor', function ($sub) use ($search) {
                    $sub->where('nama_vendor', 'like', '%' . $search . '%');
                })->orWhereHas('kategori', function ($sub) use ($search) {
                    $sub->where('nama_kategori', 'like', '%' . $search . '%');
                })->orWhereHas('user', function ($sub) use ($search) {
                    $sub->where('unit_name', 'like', '%' . $search . '%')
                        ->orWhere('name', 'like', '%' . $search . '%');
                })->orWhere('items', 'like', '%' . $search . '%');
            });
        }

        if ($request->filled('kategori_id')) {
            $query->where('kategori_id', $request->kategori_id);
        }

        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        $transaksis = $query->latest()->get();
        $kategoris = Kategori::all();
        $vendors = Vendor::all();

        return view('admin.transaksi.index', compact('transaksis', 'kategoris', 'vendors'));
    }

    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:pending,in_progress,done',
        ]);

        $transaksi = Transaksi::findOrFail($id);
        $transaksi->status = $request->status;
        $transaksi->save();

        return back()->with('success', 'Status berhasil diperbarui.');
    }

    public function update(Request $request, $id)
    {
        $transaksi = Transaksi::findOrFail($id);

        // Validasi data dasar
        $request->validate([
            'vendor_id' => 'required|exists:vendors,id',
            'items' => 'required|array',
        ]);

        // Update vendor_id
        $transaksi->vendor_id = $request->vendor_id;

        $itemsInput = $request->input('items', []);
        $itemsOutput = [];

        foreach ($itemsInput as $index => $item) {
            $itemData = $item;

            // Tangani file upload
            if (isset($item['upload_gambar'])) {
                $files = $request->file("items.$index.upload_gambar");
                $paths = [];

                if (is_array($files)) {
                    foreach ($files as $file) {
                        if ($file && $file->isValid()) {
                            $paths[] = $file->store('uploads', 'public');
                        }
                    }
                }

                // Gabungkan dengan file lama jika ada
                $existing = $transaksi->items[$index]['upload_gambar'] ?? [];
                $itemData['upload_gambar'] = array_merge((array) $existing, $paths);
            } else {
                // Jika tidak upload ulang, pertahankan gambar lama
                $itemData['upload_gambar'] = $transaksi->items[$index]['upload_gambar'] ?? [];
            }

            $itemsOutput[] = $itemData;
        }

        $transaksi->items = $itemsOutput;

        $transaksi->save();

        return redirect()->back()->with('success', 'Transaksi berhasil diperbarui.');
    }

}