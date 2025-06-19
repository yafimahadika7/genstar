<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .sidebar {
            height: 100vh;
            width: 220px;
            position: fixed;
            left: 0;
            top: 0;
            background-color: #343a40;
            color: white;
            padding-top: 1rem;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar.hide {
            left: -220px;
        }

        .sidebar a,
        .sidebar form button {
            color: white;
            padding: 10px 20px;
            display: block;
            text-decoration: none;
            background: none;
            border: none;
            text-align: left;
            width: 100%;
        }

        .sidebar a:hover,
        .sidebar form button:hover {
            background-color: #495057;
        }

        .topbar {
            height: 60px;
            background-color: #f8f9fa;
            padding: 0 1rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-left: 220px;
            transition: margin-left 0.3s ease;
        }

        .topbar.collapsed {
            margin-left: 0;
        }

        .content {
            margin-left: 220px;
            padding: 2rem;
            transition: margin-left 0.3s ease;
        }

        .content.collapsed {
            margin-left: 0;
        }

        .toggle-btn {
            font-size: 24px;
            background: none;
            border: none;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .sidebar {
                left: -220px;
            }

            .sidebar.show {
                left: 0;
            }

            .topbar,
            .content {
                margin-left: 0 !important;
            }
        }
    </style>
</head>

<body>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="text-center mb-3">
            <strong>{{ Auth::user()->name }}</strong><br>
            <small class="text-warning">{{ ucfirst(Auth::user()->role) }}</small>
        </div>

        <a href="{{ route('admin.dashboard') }}">📊 Dashboard</a>
        <a href="{{ route('admin.transaksi.index') }}">💳 Transaksi</a>
        <a href="{{ route('admin.vendors.index') }}">🏢 Vendor</a>
        <a href="{{ route('admin.users.index') }}">👤 User</a>

        <form method="POST" action="{{ route('logout') }}">
            @csrf
            <button type="submit">🚪 Logout</button>
        </form>
    </div>

    <!-- Topbar -->
    <div class="topbar" id="topbar">
        <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
        <span>Selamat Datang, {{ Auth::user()->name }}</span>
    </div>

    <!-- Content -->
    <div class="content" id="main-content">
        <h2 class="mb-4">Daftar Semua Transaksi Unit</h2>

        <!-- Filter dan Pencarian -->
        <div class="d-flex flex-wrap gap-2 mb-3 align-items-end">
            <form method="GET" action="{{ route('admin.transaksi.index') }}">
                <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                    <option value="">-- Semua Status --</option>
                    <option value="in_progress" {{ request('status') === 'in_progress' ? 'selected' : '' }}>In Progress</option>
                    <option value="done" {{ request('status') === 'done' ? 'selected' : '' }}>Done</option>
                </select>
            </form>

            <form method="GET" action="{{ route('admin.transaksi.index') }}" class="d-flex gap-2">
                <input type="text" name="search" class="form-control form-control-sm"
                    placeholder="Cari vendor / unit..." value="{{ request('search') }}">
                <button type="submit" class="btn btn-sm btn-outline-secondary">🔍</button>
            </form>
        </div>

        <!-- Tabel Transaksi -->
        <table class="table table-bordered table-striped text-center align-middle">
            <thead class="table-dark">
                <tr>
                    <th>No</th>
                    <th>Vendor</th>
                    <th>Unit</th>
                    <th>Kategori</th>
                    <th>Items</th>
                    <th>Status</th>
                    <th>Tanggal</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($transaksis as $index => $transaksi)
                    <tr>
                        <td class="align-middle">{{ $index + 1 }}</td>
                        <td class="align-middle">{{ $transaksi->vendor->nama_vendor ?? '-' }}</td>
                        <td class="align-middle">{{ $transaksi->user->unit_name ?? '-' }}</td>
                        <td class="align-middle">{{ $transaksi->kategori->nama_kategori ?? '-' }}</td>

                        <td class="align-middle text-start">
                            @php
                                $items = is_string($transaksi->items) ? json_decode($transaksi->items, true) : $transaksi->items;
                            @endphp

                            <ul class="mb-0 ps-3">
                                @foreach ($items as $item)
                                    <li>
                                        @foreach ($item as $key => $val)
                                            @if ($key === 'upload_gambar')
                                                <strong>{{ ucwords(str_replace('_', ' ', $key)) }}:</strong>
                                                <ul class="mb-0">
                                                    @foreach ((array) $val as $img)
                                                        <li><a href="{{ asset('storage/' . $img) }}" target="_blank">{{ $img }}</a></li>
                                                    @endforeach
                                                </ul>
                                            @else
                                                <strong>{{ ucwords(str_replace('_', ' ', $key)) }}:</strong> {{ $val }}<br>
                                            @endif
                                        @endforeach
                                    </li>
                                @endforeach
                            </ul>
                        </td>
                        <td class="align-middle">
                            <form action="{{ route('admin.transaksi.updateStatus', $transaksi->id) }}" method="POST">
                                @csrf
                                @method('PUT')
                                <select name="status" class="form-select form-select-sm" onchange="this.form.submit()">
                                    <option value="in_progress" {{ $transaksi->status === 'in_progress' ? 'selected' : '' }}>In Progress</option>
                                    <option value="done" {{ $transaksi->status === 'done' ? 'selected' : '' }}>Done</option>
                                </select>
                            </form>
                        </td>
                        <td class="align-middle">{{ \Carbon\Carbon::parse($transaksi->created_at)->format('d-m-Y H:i') }}
                        </td>
                        <td class="align-middle">
                            <div class="d-flex justify-content-center align-items-center gap-2">
                                @php

                                    $vendor = $transaksi->vendor;
                                    $user = $transaksi->user;
                                    $items = $transaksi->items;

                                    // Format nomor WA
                                    $rawWa = preg_replace('/[^0-9]/', '', $vendor->kontak_whatsapp ?? '');
                                    if (Str::startsWith($rawWa, '0')) {
                                        $wa = '62' . substr($rawWa, 1);
                                    } elseif (Str::startsWith($rawWa, '8')) {
                                        $wa = '62' . $rawWa;
                                    } elseif (Str::startsWith($rawWa, '62')) {
                                        $wa = $rawWa;
                                    } else {
                                        $wa = null;
                                    }

                                    // Format isi pesan
                                    $pesan = "Dear Bapak/Ibu PT {$vendor->nama_vendor},\n";
                                    $pesan .= "Saya {$user->name} dari unit {$user->unit_name}, ingin melakukan pemesanan barang dengan rincian sebagai berikut:\n\n";

                                    foreach ($items as $i => $item) {
                                        $pesan .= "===== ITEM " . ($i + 1) . " =====\n";
                                        foreach ($item as $key => $value) {
                                            if (is_array($value)) continue;
                                            $pesan .= "- " . Str::title(str_replace('_', ' ', $key)) . ": {$value}\n";
                                        }
                                        $pesan .= "===============\n\n";
                                    }

                                    $pesan .= "Demikian informasi pemesanan ini kami sampaikan.\n";
                                    $pesan .= "Atas perhatian dan kerja samanya, kami ucapkan terima kasih.\n\n";
                                    $pesan .= "Hormat saya,\n{$user->name}\n{$user->unit_name}";
                                @endphp

                                @if($wa)
                                    <a href="https://wa.me/{{ $wa }}?text={{ urlencode($pesan) }}"
                                        class="btn btn-sm btn-success d-flex align-items-center justify-content-center"
                                        style="width: 32px; height: 32px;" target="_blank" title="Kirim WhatsApp">
                                        <i class="bi bi-whatsapp"></i>
                                    </a>
                                @else
                                    <button class="btn btn-sm btn-secondary" disabled title="Nomor tidak valid">
                                        <i class="bi bi-whatsapp"></i>
                                    </button>
                                @endif

                                <a href="mailto:{{ $user->email ?? '' }}"
                                class="btn btn-sm btn-primary d-flex align-items-center justify-content-center"
                                style="width: 32px; height: 32px;" title="Kirim Email">
                                <i class="bi bi-envelope-fill"></i>
                                </a>

                                <button type="button"
                                class="btn btn-sm btn-warning d-flex align-items-center justify-content-center"
                                style="width: 32px; height: 32px;" data-bs-toggle="modal"
                                data-bs-target="#modalEditPemesanan{{ $transaksi->id }}" title="Edit Transaksi">
                                <i class="bi bi-pencil-square"></i>
                                </button>
                            </div>
                        </td>
                    </tr>

                    <!-- Modal Edit Pemesanan -->
                    <div class="modal fade" id="modalEditPemesanan{{ $transaksi->id }}" tabindex="-1"
                        aria-labelledby="modalLabelEdit{{ $transaksi->id }}" aria-hidden="true" data-bs-backdrop="static"
                        data-bs-keyboard="false">
                        <div class="modal-dialog modal-lg">
                            <form action="{{ route('admin.transaksi.update', $transaksi->id) }}" method="POST" enctype="multipart/form-data">
                                @csrf
                                @method('PUT')
                                <input type="hidden" name="transaksi_id" value="{{ $transaksi->id }}">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Edit Pemesanan</h5>
                                        </h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Tutup"></button>
                                    </div>

                                    <div class="modal-body">
                                        @php
                                            $fields = json_decode($transaksi->kategori->input_fields ?? '[]', true);
                                            $items = is_string($transaksi->items) ? json_decode($transaksi->items, true) : $transaksi->items;
                                        @endphp

                                        <div class="mb-3">
                                            <label for="vendor_id" class="form-label">Pilih Vendor</label>
                                            <select name="vendor_id" id="vendor_id" class="form-select" required>
                                                <option value="">-- Pilih Vendor --</option>
                                                @foreach ($vendors as $vendor)
                                                    <option value="{{ $vendor->id }}" {{ $transaksi->vendor_id == $vendor->id ? 'selected' : '' }}>
                                                        {{ $vendor->nama_vendor }} - ({{ $vendor->kategori->nama_kategori ?? 'Tanpa Kategori' }})
                                                    </option>
                                                @endforeach
                                            </select>
                                        </div>

                                        @if(is_array($fields))
                                            <div id="items-container-edit-{{ $transaksi->id }}">
                                                @foreach($items as $i => $item)
                                                    <div class="item-group border rounded p-3 mb-3">
                                                        @foreach($fields as $field)
                                                            @if ($field === 'upload_gambar')
                                                                <div class="mb-2">
                                                                    <label class="form-label">Upload Gambar</label>
                                                                    <input type="file" name="items[{{ $i }}][upload_gambar][]"
                                                                        class="form-control" multiple>
                                                                    @if (!empty($item['upload_gambar']))
                                                                        <small class="text-muted d-block">File sebelumnya: </small>
                                                                        <ul>
                                                                            @foreach ((array) $item['upload_gambar'] as $img)
                                                                                <li><a href="{{ asset('storage/' . $img) }}" target="_blank">{{ $img }}</a></li>
                                                                            @endforeach
                                                                        </ul>
                                                                    @endif
                                                                </div>
                                                            @elseif ($field === 'jumlah')
                                                                <div class="mb-2">
                                                                    <label class="form-label">Jumlah</label>
                                                                    <input type="number" name="items[{{ $i }}][jumlah]" class="form-control"
                                                                        value="{{ $item['jumlah'] ?? '' }}" required>
                                                                </div>
                                                            @elseif ($field === 'metode_pengadaan')
                                                                <div class="mb-2">
                                                                    <label class="form-label">Metode Pengadaan</label>
                                                                    <select name="items[{{ $i }}][metode_pengadaan]" class="form-select"
                                                                        required>
                                                                        <option value="">-- Pilih --</option>
                                                                        <option value="sewa" {{ ($item['metode_pengadaan'] ?? '') == 'sewa' ? 'selected' : '' }}>Sewa</option>
                                                                        <option value="beli" {{ ($item['metode_pengadaan'] ?? '') == 'beli' ? 'selected' : '' }}>Beli</option>
                                                                    </select>
                                                                </div>
                                                            @else
                                                                <div class="mb-2">
                                                                    <label
                                                                        class="form-label">{{ ucfirst(str_replace('_', ' ', $field)) }}</label>
                                                                    <input type="text" name="items[{{ $i }}][{{ $field }}]"
                                                                        class="form-control" value="{{ $item[$field] ?? '' }}" required>
                                                                </div>
                                                            @endif
                                                        @endforeach
                                                    </div>
                                                @endforeach
                                            </div>
                                            <button type="button" class="btn btn-sm btn-secondary mb-3"
                                                onclick="tambahItemEdit({{ $transaksi->id }})">
                                                + Tambah Item
                                            </button>
                                        @else
                                            <div class="alert alert-warning">Input form untuk transaksi ini belum dikonfigurasi
                                                dengan benar.</div>
                                        @endif
                                    </div>

                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Batal</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                @empty
                    <tr>
                        <td colspan="8" class="text-center text-muted">Belum ada transaksi.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- JavaScript -->
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const content = document.getElementById('main-content');
            const topbar = document.getElementById('topbar');

            sidebar.classList.toggle('hide');
            content.classList.toggle('collapsed');
            topbar.classList.toggle('collapsed');
        }
    </script>

    <script>
        function tambahItemEdit(id) {
            const container = document.getElementById('items-container-edit-' + id);
            const itemGroups = container.querySelectorAll('.item-group');
            const newIndex = itemGroups.length;

            const firstGroup = itemGroups[0];
            const clone = firstGroup.cloneNode(true);

            clone.querySelectorAll('input, select').forEach(el => {
                el.name = el.name.replace(/\[\d+\]/, `[${newIndex}]`);
                if (el.type === 'file') {
                    el.value = null;
                } else if (el.tagName.toLowerCase() === 'select') {
                    el.selectedIndex = 0;
                } else {
                    el.value = '';
                }
            });

            container.appendChild(clone);
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>