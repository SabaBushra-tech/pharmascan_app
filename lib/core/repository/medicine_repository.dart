import '../models/medicine.dart';
import '../../features/medicine/medicine_service.dart';

class MedicineRepository {
  final MedicineService _service = MedicineService();

  Future<List<Medicine>> fetchAllMedicines() async {
    return await _service.getAllMedicines();
  }

  Future<void> addMedicine(Medicine med) async {
    await _service.addMedicine(med);
  }

  Future<void> updateMedicine(Medicine med) async {
    await _service.updateMedicine(med);
  }

  Future<void> deleteMedicine(int id) async {
    await _service.deleteMedicine(id);
  }
}
