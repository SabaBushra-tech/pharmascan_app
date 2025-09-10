import 'package:flutter/material.dart';
import '../../core/models/medicine.dart';
import '../../core/repository/medicine_repository.dart';
import 'medicine_form_page.dart';

class MedicineDetailPage extends StatelessWidget {
  final Medicine medicine;
  final MedicineRepository _repo = MedicineRepository();

  MedicineDetailPage({super.key, required this.medicine});

  void _deleteMedicine(BuildContext context) async {
    try {
      await _repo.deleteMedicine(medicine.id);
      if (!context.mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _editMedicine(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedicineFormPage(medicine: medicine),
      ),
    );

    if (result == true && context.mounted) {
      Navigator.pop(context, true); // Go back to list and refresh
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.brandNameEn),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editMedicine(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteMedicine(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Brand Name (EN): ${medicine.brandNameEn}'),
            Text('Generic Name (EN): ${medicine.genericNameEn}'),
            Text('Brand Name (BN): ${medicine.brandNameBn}'),
            Text('Generic Name (BN): ${medicine.genericNameBn}'),
            Text('Barcode: ${medicine.barcode}'),
            Text('Strength: ${medicine.strength}'),
            Text('Alternatives: ${medicine.alternatives.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
