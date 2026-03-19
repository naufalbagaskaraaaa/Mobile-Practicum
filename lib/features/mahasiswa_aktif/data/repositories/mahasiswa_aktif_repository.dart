import '../models/mahasiswa_aktif_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaAktifModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaAktifModel(
        nama: 'Naufal Bagaskara',
        nim: '434241106',
        status: 'aktif',
        jurusan: 'D4 Teknik Informatika'
      ),
      MahasiswaAktifModel(
        nama: 'Alya Rahma',
        nim: '152410101022',
        status: 'aktif',
        jurusan: 'D4 K3'
      ),
      MahasiswaAktifModel(
        nama: ' Pak Anang',
        nim: '152410101045',
        status: 'aktif',
        jurusan: 'D4 Teknik Informatika'
      ),
    ];
  }
}