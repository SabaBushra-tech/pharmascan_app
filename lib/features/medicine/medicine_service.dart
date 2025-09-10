import 'package:postgrest/postgrest.dart';
import '../../core/models/medicine.dart';

class MedicineService {
  // Replace with your Supabase URL & anon key
  final String supabaseUrl = 'YOUR_SUPABASE_URL';
  final String supabaseKey = 'YOUR_SUPABASE_ANON_KEY';

  late final PostgrestClient _client;

  MedicineService() {
    _client = PostgrestClient(supabaseUrl, headers: {
      'apikey': supabaseKey,
      'Authorization': 'Bearer $supabaseKey',
      'Content-Type': 'application/json',
    });
  }

  // Get all medicines
  Future<List<Medicine>> getAllMedicines() async {
    final List<dynamic> response = await _client.from('medicines').select();
    return response.map((json) => Medicine.fromJson(json)).toList();
  }

  // Add medicine
  Future<void> addMedicine(Medicine med) async {
    await _client.from('medicines').insert([med.toMap()]);
  }

  // Update medicine
  Future<void> updateMedicine(Medicine med) async {
    await _client.from('medicines').update(med.toMap()).eq('id', med.id);
  }

  // Delete medicine
  Future<void> deleteMedicine(int id) async {
    await _client.from('medicines').delete().eq('id', id);
  }
}
