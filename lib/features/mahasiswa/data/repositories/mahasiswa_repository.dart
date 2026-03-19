import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Alfin Dhanur',
        nim: '434241098',
        email: 'alfin.dhanur@example',
        semester: 4,
        ipk: 3.85,
      ),
      MahasiswaModel(
        nama: 'Alya Rahma',
        nim: '152410101022',
        email: 'alya.rahma@example',
        semester: 4,
        ipk: 3.90,
      ),
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '152410101045',
        email: 'budi.santoso@vexampled',
        semester: 2,
        ipk: 3.50,
      ),
    ];
  }
}