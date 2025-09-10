import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pharmascan_app/core/models/medicine.dart';

class MedicineService {
  final _client = Supabase.instance.client;

  /// Fetch all medicines
  Future<List<Medicine>> fetchMedicines() async {
    final response = await _client.from('medicines').select();
    final data = response as List<dynamic>;
    return data
        .map((e) => Medicine.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Insert a new medicine
  Future<Medicine?> addMedicine(Medicine medicine) async {
    final response = await _client
        .from('medicines')
        .insert(medicine.toJson())
        .select()
        .single();
    return Medicine.fromJson(response);
  }

  /// Update existing medicine
  Future<void> updateMedicine(Medicine medicine) async {
    if (medicine.id == null) return;
    await _client
        .from('medicines')
        .update(medicine.toJson())
        .eq('id', medicine.id!);
  }

  /// Delete medicine
  Future<void> deleteMedicine(int id) async {
    await _client.from('medicines').delete().eq('id', id);
  }

  /// Get all medicines (wrapper for fetchMedicines)
  Future<List<Medicine>> getAllMedicines() async {
    return await fetchMedicines();
  }
}
