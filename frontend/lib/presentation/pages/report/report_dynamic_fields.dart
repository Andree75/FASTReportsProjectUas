import 'package:flutter/material.dart';

class ReportDynamicFields extends StatelessWidget {
  final String category;
  final Map<String, TextEditingController> controllers;

  const ReportDynamicFields({
    Key? key,
    required this.category,
    required this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (category) {
      case 'Kekerasan Fisik':
        return Column(
          children: [
            _buildTextField("nama_korban", "Nama Korban", Icon(Icons.person)),
            _buildTextField(
              "jenis luka : ",
              "Jenis Luka",
              Icon(Icons.local_hospital),
            ),
          ],
        );
      case 'Pencurian':
        return Column(
          children: [
            _buildTextField(
              "barang hilang : ",
              "Barang Hilang",
              Icon(Icons.wallet),
            ),
            _buildTextField(
              "kerugian : ",
              "Estimasi Kerugian (Rp)",
              Icon(Icons.money),
              isNumber: true,
            ),
          ],
        );
      case 'Kecelakaan':
        return Column(
          children: [
            _buildTextField(
              "kendaraan : ",
              "Jenis Kendaraan",
              Icon(Icons.car_crash),
            ),
            _buildTextField(
              "korban jiwa : ",
              "Jumlah Korban",
              Icon(Icons.numbers),
              isNumber: true,
            ),
          ],
        );
      case 'Narkoba':
        return Column(
          children: [
            _buildTextField(
              "jenis obat : ",
              "Dugaan Jenis Obat",
              Icon(Icons.science),
            ),
            _buildTextField(
              "lokasi transaksi : ",
              "Lokasi Transaksi",
              Icon(Icons.pin_drop),
            ),
          ],
        );
      case 'Pelecehan':
        return Column(
          children: [
            _buildTextField(
              "ciri pelaku : ",
              "Ciri-ciri Pelaku",
              Icon(Icons.face),
            ),
            _buildTextField("saksi", "Adakah Saksi?", Icon(Icons.people)),
          ],
        );
      case 'Judol':
        return Column(
          children: [
            _buildTextField(
              "link situs : ",
              "Link Website / Nama Aplikasi",
              Icon(Icons.link),
            ),
            _buildTextField(
              "rekening bandar : ",
              "Rekening/E-Wallet Bandar (Jika tahu)",
              Icon(Icons.account_balance_wallet),
            ),
            _buildTextField(
              "platform : ",
              "Platform (FB/IG/WA/Situs)",
              Icon(Icons.public),
            ),
          ],
        );
      case 'Lainnya':
      default:
        return Column(
          children: [
            _buildTextField(
              "jenis bahaya",
              "Jenis Bahaya / Kejadian",
              Icon(Icons.dangerous_outlined),
            ),
            _buildTextField(
              "lokasi patokan",
              "Lokasi & Patokan Jelas",
              Icon(Icons.add_location_alt),
            ),
            _buildTextField(
              "bantuan diperlukan",
              "Bantuan yg Dibutuhkan (Medis/Polisi/Warga)",
              Icon(Icons.health_and_safety),
            ),
          ],
        );
    }
  }

  Widget _buildTextField(
    String key,
    String label,
    Icon icon, {
    bool isNumber = false,
  }) {
    if (!controllers.containsKey(key)) {
      controllers[key] = TextEditingController();
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controllers[key],
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        validator: (val) => val!.isEmpty ? "Wajib diisi" : null,
      ),
    );
  }
}
