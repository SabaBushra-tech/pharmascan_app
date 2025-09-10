import 'package:flutter/material.dart';
import '../../core/models/medicine.dart';
import '../../core/repository/medicine_repository.dart';

class MedicineFormPage extends StatefulWidget {
  final Medicine? medicine;

  const MedicineFormPage({super.key, this.medicine});

  @override
  State<MedicineFormPage> createState() => _MedicineFormPageState();
}

class _MedicineFormPageState extends State<MedicineFormPage> {
  final _formKey = GlobalKey<FormState>();
  final MedicineRepository _repo = MedicineRepository();

  late TextEditingController _brandNameEnController;
  late TextEditingController _genericNameEnController;
  late TextEditingController _brandNameBnController;
  late TextEditingController _genericNameBnController;
  late TextEditingController _barcodeController;
  late TextEditingController _strengthController;
  late TextEditingController _alternativesController;

  @override
  void initState() {
    super.initState();
    _brandNameEnController =
        TextEditingController(text: widget.medicine?.brandNameEn ?? '');
    _genericNameEnController =
        TextEditingController(text: widget.medicine?.genericNameEn ?? '');
    _brandNameBnController =
        TextEditingController(text: widget.medicine?.brandNameBn ?? '');
    _genericNameBnController =
        TextEditingController(text: widget.medicine?.genericNameBn ?? '');
    _barcodeController =
        TextEditingController(text: widget.medicine?.barcode ?? '');
    _strengthController =
        TextEditingController(text: widget.medicine?.strength ?? '');
    _alternativesController = TextEditingController(
        text: widget.medicine?.alternatives.join(', ') ?? '');
  }

  @override
  void dispose() {
    _brandNameEnController.dispose();
    _genericNameEnController.dispose();
    _brandNameBnController.dispose();
    _genericNameBnController.dispose();
    _barcodeController.dispose();
    _strengthController.dispose();
    _alternativesController.dispose();
    super.dispose();
  }

  Future<void> _saveMedicine() async {
    if (_formKey.currentState!.validate()) {
      final med = Medicine(
        id: widget.medicine?.id ?? DateTime.now().millisecondsSinceEpoch,
        brandNameEn: _brandNameEnController.text,
        genericNameEn: _genericNameEnController.text,
        brandNameBn: _brandNameBnController.text,
        genericNameBn: _genericNameBnController.text,
        barcode: _barcodeController.text,
        strength: _strengthController.text,
        alternatives: _alternativesController.text
            .split(',')
            .map((e) => e.trim())
            .toList(),
      );

      try {
        if (widget.medicine == null) {
          await _repo.addMedicine(med);
        } else {
          await _repo.updateMedicine(med);
        }

        if (!mounted) return;
        Navigator.pop(context, true);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medicine == null ? 'Add Medicine' : 'Edit Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _brandNameEnController,
                decoration: const InputDecoration(labelText: 'Brand Name (EN)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _genericNameEnController,
                decoration:
                    const InputDecoration(labelText: 'Generic Name (EN)'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _brandNameBnController,
                decoration: const InputDecoration(labelText: 'Brand Name (BN)'),
              ),
              TextFormField(
                controller: _genericNameBnController,
                decoration:
                    const InputDecoration(labelText: 'Generic Name (BN)'),
              ),
              TextFormField(
                controller: _barcodeController,
                decoration: const InputDecoration(labelText: 'Barcode'),
              ),
              TextFormField(
                controller: _strengthController,
                decoration: const InputDecoration(labelText: 'Strength'),
              ),
              TextFormField(
                controller: _alternativesController,
                decoration: const InputDecoration(
                    labelText: 'Alternatives (comma separated)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMedicine,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
