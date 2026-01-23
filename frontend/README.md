# 🚀 FAST Reports (Flutter Automated Safety & Tracking Reports)

![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-blue)
![PHP](https://img.shields.io/badge/Backend-PHP%20Native-purple)
![MySQL](https://img.shields.io/badge/Database-MySQL-orange)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Linux%20Desktop-lightgrey)

**FAST Reports** adalah aplikasi pelaporan insiden multi-platform (Mobile & Desktop) yang dirancang untuk kecepatan dan ketepatan data. Aplikasi ini memungkinkan pengguna melaporkan kejadian darurat (Kecelakaan, Kriminal, Judol, Narkoba) dengan bukti visual realtime dan formulir yang adaptif.

---

## ✨ Fitur Unggulan

### 📱 1. User Side (Pelapor)

- **Dynamic Form System:** Formulir input berubah otomatis sesuai kategori laporan.
  - _Contoh:_ Kategori "Kecelakaan" meminta data kendaraan, sedangkan "Judol" meminta link situs/rekening.
- **Hybrid Camera Engine:**
  - 📸 **Android:** Menggunakan Native Camera API.
  - 💻 **Linux Desktop:** Mengintegrasikan `fswebcam` driver untuk dukungan webcam laptop/eksternal.
- **Real-time Status Tracking:** Memantau status laporan (Pending ➝ Diproses ➝ Selesai) secara langsung.
- **Export Evidence:** Fitur cetak bukti laporan ke format `.txt` untuk arsip fisik.
- **Offline Capability:** Login session tersimpan (Auto-login).

### 🛡️ 2. Admin Panel (Pengelola)

- **Integrated Dashboard:** Panel admin menyatu dalam satu aplikasi (Role-Based Access).
- **Status Management:** Admin dapat mengubah status laporan (`Diproses`, `Ditindak Lanjuti`, `Selesai`, `Ditolak`) dan user akan melihat perubahannya seketika.
- **Quick Review:** Melihat detail laporan lengkap dengan foto bukti dan metadata lokasi.

---

## 🛠️ Teknologi yang Digunakan

- **Frontend:** Flutter (Dart) dengan Clean Architecture (Presentation, Domain, Data layers).
- **Backend:** PHP Native (REST API).
- **Database:** MySQL / MariaDB.
- **State Management:** Provider.
- **Tools:** Android Studio, VS Code, XAMPP (Windows) / Apache (Linux).

---

## ⚙️ Instalasi & Pengaturan

### 1. Persiapan Backend (Server)

1.  Pastikan **XAMPP** (Windows) atau **Apache/Nginx** (Linux) sudah terinstall.
2.  Buat database baru di PHPMyAdmin bernama `fast_reports`.
3.  Import file SQL yang disertakan (`fast_reports.sql`) ke database tersebut.
4.  Pindahkan folder `backend/fast_api` ke folder `htdocs` (Windows) atau `/var/www/html` (Linux).

### 2. Konfigurasi Aplikasi (Flutter)

Buka file `lib/core/constants/api_constants.dart` dan sesuaikan IP Address:

**Untuk Android Emulator:**

````dart
static const String serverIp = "10.0.2.2"; // Akses ke localhost Windows
````

**Untuk HP Fisik / Linux Desktop:**

```dart
static const String serverIp = "192.168.x.x"; // Sesuaikan IP LAN Laptop Anda
// atau
static const String serverIp = "localhost"; // Jika run di Desktop Linux
```

# Menjalankan Aplikasi :

```bash
# Install dependencies
flutter pub get

# Run di Android Emulator
flutter run

# Run di Linux Desktop (Pastikan install fswebcam: sudo apt install fswebcam)
flutter run -d linux
```

🔐 Akun Demo

| Role | Username | Password |
| :--- | :--- | :--- |
| **User** | *(Register manual di aplikasi)* | *(Sesuai register)* |
| **Admin** | `admin` | `admin123` |


📂 Struktur Proyek

```text
lib/
├── core/            # Konstanta API, Konstanta Warna, & Utils (Camera Helper, Printer)
├── data/            # Data Layer: Models (JSON Parsing) & Remote Datasource (HTTP)
├── domain/          # Domain Layer: Entities (Objek Murni) & Repository Interfaces
└── presentation/    # Presentation Layer: Halaman UI, Widget, & State Management (Provider)
```

👨‍💻 Author

Dikembangkan oleh Andri Darmawan (3012310004) sebagai Proyek Akhir Mata Kuliah Pemrograman Aplikasi Mobile.

## 📸 Screenshots cuplikan Aplikasi:

## Login & Register:

<img width="405" height="699" alt="image" src="https://github.com/user-attachments/assets/d2425f87-0e71-438d-a172-ad57fe4c13f4" />

<img width="406" height="700" alt="image-1" src="https://github.com/user-attachments/assets/b3dde441-232b-4745-ba95-42d8e5e3fffd" />

<img width="406" height="700" alt="image-2" src="https://github.com/user-attachments/assets/8eb8fd7d-a0fd-467c-8e15-0c705adf87e7" />


## Dashboard Apps :

<img width="407" height="697" alt="image-3" src="https://github.com/user-attachments/assets/fad7d3b9-d4e3-4384-bee1-dbd190850946" />

<img width="407" height="697" alt="image-5" src="https://github.com/user-attachments/assets/e679c7e2-40a4-4a8f-a81d-f6a3412650af" />

<img width="406" height="706" alt="image-6" src="https://github.com/user-attachments/assets/562231be-c869-4706-98f8-e40a05631eec" />

<img width="404" height="697" alt="image-9" src="https://github.com/user-attachments/assets/27148fda-7b07-42ed-a177-cf7238e53073" />

<img width="407" height="701" alt="image-10" src="https://github.com/user-attachments/assets/02399e6d-3bdf-4378-8d76-2742d9ee5ca1" />

## Riwayat & Detail Laporan:

<img width="405" height="701" alt="image-7" src="https://github.com/user-attachments/assets/f63ad924-b84c-4f20-a6d2-938a3ce8dbd5" />

<img width="407" height="700" alt="image-8" src="https://github.com/user-attachments/assets/db5aab2a-5833-4c8e-ac13-a6fc6aefe1f5" />
