import 'package:flutter/material.dart';
import '../../core/models/medicine.dart';
import '../../core/repository/medicine_repository.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MedicineRepository _repo = MedicineRepository();
  List<Medicine> medicines = [];
  List<Medicine> filteredMedicines = [];

  @override
  void initState() {
    super.initState();
    loadMedicines();
  }

  Future<void> loadMedicines() async {
    medicines = await _repo.fetchAllMedicines();
    setState(() {
      filteredMedicines = medicines;
    });
  }

  void filterMedicines(String query) {
    final filtered = medicines.where((med) {
      final nameLower = med.brandNameEn.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredMedicines = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Medicines')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterMedicines,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMedicines.length,
              itemBuilder: (context, index) {
                final med = filteredMedicines[index];
                return ListTile(
                  title: Text(med.brandNameEn),
                  subtitle: Text(med.genericNameEn),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
