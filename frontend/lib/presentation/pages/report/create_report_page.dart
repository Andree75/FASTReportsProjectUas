import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/report_provider.dart';
import '../../../core/constants/linux_camera_helper.dart';
import 'report_dynamic_fields.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({Key? key}) : super(key: key);

  @override
  _CreateReportPageState createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final Map<String, TextEditingController> _dynamicControllers = {};
  File? _imageFile;
  bool _isTakingLinuxPhoto = false;
  String _selectedCategory = 'Lainnya';
  String _selectedUrgency = 'Biasa';

  final List<String> _categories = [
    'Kekerasan Fisik',
    'Pelecehan',
    'Pencurian',
    'Narkoba',
    'Kecelakaan',
    'Judol',
    'Lainnya',
  ];

  final List<String> _urgencyLevels = ['Biasa', 'Sedang', 'Tinggi', 'DARURAT'];
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is String && _categories.contains(args)) {
        _selectedCategory = args;
      }
      _isInit = false;
    }
  }

  void _onCategoryChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        _selectedCategory = newValue;
        _dynamicControllers.clear();
      });
    }
  }

  Future<void> _onCameraPressed() async {
    if (Platform.isLinux) {
      await _handleLinuxCamera();
    } else {
      await _pickImage(ImageSource.camera);
    }
  }

  Future<void> _handleLinuxCamera() async {
    setState(() => _isTakingLinuxPhoto = true);
    try {
      final file = await LinuxCameraHelper.capturePhoto();

      setState(() {
        _imageFile = file;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Foto berhasil diambil."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isTakingLinuxPhoto = false);
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: source, imageQuality: 75);
      if (picked != null) {
        setState(() => _imageFile = File(picked.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal mengambil gambar: $e")));
    }
  }

  void _submitReport() async {
    if (!_formKey.currentState!.validate()) return;
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Foto wajib ada!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    Map<String, dynamic> metadataMap = {};
    _dynamicControllers.forEach((key, ctrl) => metadataMap[key] = ctrl.text);

    final success = await Provider.of<ReportProvider>(context, listen: false)
        .createReport(
          userId: userId ?? 1,
          title: _titleController.text,
          description: _descController.text,
          category: _selectedCategory,
          imageFile: _imageFile!,
          metadata: jsonEncode(metadataMap),
          urgency: _selectedUrgency,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Laporan Terkirim!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal mengirim."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Laporan"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Jenis Laporan:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: _categories
                        .map(
                          (val) =>
                              DropdownMenuItem(value: val, child: Text(val)),
                        )
                        .toList(),
                    onChanged: _onCategoryChanged,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Seberapa Mendesak?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _urgencyLevels.map((level) {
                    final isSelected = _selectedUrgency == level;
                    Color color = Colors.grey;
                    if (level == 'DARURAT')
                      color = Colors.red;
                    else if (level == 'Tinggi')
                      color = Colors.orange;
                    else if (level == 'Sedang')
                      color = Colors.blue;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(level),
                        selected: isSelected,
                        selectedColor: color.withOpacity(0.2),
                        onSelected: (selected) {
                          if (selected)
                            setState(() => _selectedUrgency = level);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  image: _imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _isTakingLinuxPhoto
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        ),
                      )
                    : (_imageFile == null
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    "Belum ada foto",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          : null),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _onCameraPressed,
                      icon: const Icon(Icons.camera_alt),
                      label: Text(Platform.isLinux ? "Foto Cepat" : "Kamera"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text("Unggah Foto"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              ReportDynamicFields(
                category: _selectedCategory,
                controllers: _dynamicControllers,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Judul Laporan",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Kronologi Lengkap",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "KIRIM LAPORAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
