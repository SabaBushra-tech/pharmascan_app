import 'package:flutter/material.dart';
import 'package:pharmascan_app/core/models/medicine.dart';
import 'package:pharmascan_app/features/medicine/medicine_service.dart';
import 'package:pharmascan_app/features/medicine/medicine_form_page.dart';

class MedicineDetailPage extends StatelessWidget {
  final Medicine medicine;
  const MedicineDetailPage({super.key, required this.medicine});

  Future<void> _deleteMedicine(BuildContext context) async {
    try {
      await MedicineService().deleteMedicine(medicine.id!);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicine deleted')),
      );
      Navigator.pop(context, true); // go back & refresh
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _editMedicine(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MedicineFormPage(medicine: medicine),
      ),
    );
    if (result == true) {
      Navigator.pop(context, true); // refresh after editing
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
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteMedicine(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildInfo('Brand Name (EN)', medicine.brandNameEn),
            _buildInfo('Generic Name (EN)', medicine.genericNameEn),
            _buildInfo('Brand Name (BN)', medicine.brandNameBn),
            _buildInfo('Generic Name (BN)', medicine.genericNameBn),
            _buildInfo('Barcode', medicine.barcode),
            _buildInfo('Strength', medicine.strength),
            _buildInfo(
              'Alternatives',
              medicine.alternatives.isNotEmpty
                  ? medicine.alternatives.join(', ')
                  : 'N/A',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
