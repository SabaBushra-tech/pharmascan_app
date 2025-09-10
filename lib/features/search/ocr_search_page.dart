import 'package:flutter/material.dart';
import 'package:pharmascan_app/core/models/medicine.dart';
import 'package:pharmascan_app/features/medicine/medicine_service.dart';
import 'package:pharmascan_app/features/medicine/medicine_detail_page.dart';

class OcrSearchPage extends StatefulWidget {
  const OcrSearchPage({super.key});

  @override
  State<OcrSearchPage> createState() => _OcrSearchPageState();
}

class _OcrSearchPageState extends State<OcrSearchPage> {
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    final meds = await MedicineService().fetchMedicines();
    setState(() {
      medicines = meds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Search')),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          final med = medicines[index];
          return ListTile(
            title: Text(med.brandNameEn),
            subtitle: Text(med.genericNameEn),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MedicineDetailPage(medicine: med),
              ),
            ),
          );
        },
      ),
    );
  }
}
