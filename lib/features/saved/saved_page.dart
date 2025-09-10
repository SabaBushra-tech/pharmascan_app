import 'package:flutter/material.dart';
import 'package:pharmascan_app/features/medicine/medicine_service.dart';
import 'package:pharmascan_app/core/models/medicine.dart';
import 'package:pharmascan_app/features/medicine/medicine_detail_page.dart';
import 'package:pharmascan_app/features/medicine/medicine_form_page.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late Future<List<Medicine>> _medicines;

  @override
  void initState() {
    super.initState();
    _medicines = MedicineService().getAllMedicines();
  }

  Future<void> _refresh() async {
    setState(() {
      _medicines = MedicineService().getAllMedicines();
    });
  }

  Future<void> _addMedicine() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MedicineFormPage()),
    );
    if (result == true) _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Medicines'),
        actions: [
          IconButton(onPressed: _addMedicine, icon: const Icon(Icons.add)),
        ],
      ),
      body: FutureBuilder<List<Medicine>>(
        future: _medicines,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError)
            return Center(child: Text(snapshot.error.toString()));
          final meds = snapshot.data ?? [];
          return ListView.builder(
            itemCount: meds.length,
            itemBuilder: (context, index) {
              final med = meds[index];
              return ListTile(
                title: Text(med.brandNameEn),
                subtitle: Text(med.genericNameEn),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MedicineDetailPage(medicine: med)),
                  );
                  if (result == true) _refresh();
                },
              );
            },
          );
        },
      ),
    );
  }
}
