# 🚨 Fast Reports App

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![PHP](https://img.shields.io/badge/Backend-Native%20PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)
![MariaDB](https://img.shields.io/badge/Database-MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![Status](https://img.shields.io/badge/Status-In%20Development-yellow?style=for-the-badge)

> **Platform Pelaporan Warga Tercepat & Terstruktur.**
> Aplikasi mobile berbasis Flutter untuk melaporkan insiden darurat dengan formulir dinamis dan bukti lapor digital.

## ✨ Fitur Utama (Key Features)

Aplikasi ini dirancang untuk kecepatan dan akurasi data:

### 1. 🎨 Modern Dashboard UI
- **Grid Menu 4 Kolom:** Tampilan ikon proporsional dan rapi.
- **Visual Style:** Tombol kategori berbentuk *Squircle* dengan *Gradient Background* dan *Colored Shadow* (Glow Effect).
- **Iconography:** Menggunakan ikon visual yang relevan (misal: `smartphone_rounded` untuk Judol).

### 2. 📝 Dynamic Form Engine
Formulir input berubah otomatis berdasarkan kategori yang dipilih:
- **Judol:** Input Link Situs, Rekening Bandar.
- **Fisik/Kecelakaan:** Input Jumlah Korban, Jenis Luka.
- **Pencurian:** Input Barang Hilang, Estimasi Kerugian.
- **Lainnya:** Input Jenis Bahaya, Patokan Lokasi.

### 3. 🚨 Urgency Selector
Sistem penandaan prioritas menggunakan **Choice Chips** berwarna:
- 🟢 Biasa
- 🔵 Sedang
- 🟠 Tinggi
- 🔴 **DARURAT**

### 4. 🖨️ Offline Receipt Printing
- Fitur unik untuk mencetak bukti laporan mandiri.
- Menghasilkan file **.txt (Plain Text)** dengan format struk (*Receipt Style*).
- File tersimpan otomatis di folder `Downloads` perangkat.

### 5. 📱 Smart Layout Detail
- Header gambar dengan gaya **Rounded Bottom**.
- Tata letak teks metadata yang cerdas (Teks panjang otomatis turun baris/wrap).

---

## 🛠️ Tech Stack

### Client (Mobile)
- **Framework:** Flutter (Dart)
- **State Management:** Provider
- **Networking:** HTTP Package
- **Local Storage:** Shared Preferences
- **File IO:** Path Provider (untuk unduh struk)

### Server (Backend)
- **OS:** Linux Ubuntu Server
- **Web Server:** Apache2
- **Language:** Native PHP (No Framework)
- **Database:** MariaDB

---

## 🚀 Cara Instalasi (Getting Started)

### Persyaratan
- Flutter SDK
- Web Server (XAMPP / Apache di Linux)
- MySQL / MariaDB

### 1. Setup Backend
1. Buat database baru bernama `fast_reports_db`.
2. Import file SQL (tabel `users` dan `reports`).
3. Upload folder `api/` ke root server Anda (`/var/www/html/` atau `htdocs`).
4. Pastikan folder `uploads/` memiliki permission write (`chmod 777`).

### 2. Setup Frontend (Flutter)
1. Clone repository ini:
   ```bash
   git clone [https://github.com/username/fast-reports.git](https://github.com/username/fast-reports.git)
