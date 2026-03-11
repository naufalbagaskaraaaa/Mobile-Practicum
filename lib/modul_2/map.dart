import 'dart:io';

void main() {
  Map<String, String> data = {};
  List<Map<String, String>> dataMahasiswaMultiple = [];

  print('=== INPUT DATA MAHASISWA ===');
  stdout.write('Masukkan NIM: ');
  String? nim = stdin.readLineSync();
  stdout.write('Masukkan Nama: ');
  String? nama = stdin.readLineSync();
  stdout.write('Masukkan Jurusan: ');
  String? jurusan = stdin.readLineSync();
  stdout.write('Masukkan IPK: ');
  String? ipk = stdin.readLineSync();

  data["nim"] = nim ?? "";
  data["nama"] = nama ?? "";
  data["jurusan"] = jurusan ?? "";
  data["ipk"] = ipk ?? "";

  print('Data Mahasiswa: $data');

  print('\n=== INPUT MULTIPLE MAHASISWA ===');
  int jumlahMahasiswa = 0;

  while (jumlahMahasiswa <= 0) {
    stdout.write('Masukkan jumlah mahasiswa: ');
    String? input = stdin.readLineSync();
    try {
      jumlahMahasiswa = int.parse(input!);
      if (jumlahMahasiswa <= 0) {
        print('Masukkan angka lebih dari 0!');
      }
    } catch (e) {
      print('Input tidak valid!');
    }
  }

  for (int i = 1; i <= jumlahMahasiswa; i++) {
    print('--- Mahasiswa ke-$i ---');
    stdout.write('Masukkan NIM: ');
    String? nimBaru = stdin.readLineSync();
    stdout.write('Masukkan Nama: ');
    String? namaBaru = stdin.readLineSync();
    stdout.write('Masukkan Jurusan: ');
    String? jurusanBaru = stdin.readLineSync();
    stdout.write('Masukkan IPK: ');
    String? ipkBaru = stdin.readLineSync();

    Map<String, String> mahasiswa = {
      "nim": nimBaru ?? "",
      "nama": namaBaru ?? "",
      "jurusan": jurusanBaru ?? "",
      "ipk": ipkBaru ?? ""
    };

    dataMahasiswaMultiple.add(mahasiswa);
  }

  print('\nTotal Mahasiswa: ${dataMahasiswaMultiple.length}');
  print('Data Multiple:');
  for (int i = 0; i < dataMahasiswaMultiple.length; i++) {
    print('Mahasiswa ${i + 1}: ${dataMahasiswaMultiple[i]}');
  }

  print('\n=== MENU OPERASI ===');

  // UPDATE DATA
  stdout.write('\nApakah anda ingin mengupdate data? (yes/no): ');
  String? pilihanUpdate = stdin.readLineSync();

  if (pilihanUpdate == 'yes') {
    stdout.write('Ingin ubah apa? (nim/nama/jurusan/ipk): ');
    String? fieldUpdate = stdin.readLineSync();

    if (fieldUpdate != null && data.containsKey(fieldUpdate)) {
      stdout.write('Masukkan nilai baru untuk "$fieldUpdate": ');
      String? nilaiBaru = stdin.readLineSync();
      data[fieldUpdate] = nilaiBaru ?? "";
      print('Data "$fieldUpdate" berhasil diupdate!');
    } else {
      print('Field tidak valid!');
    }
  }

  // HAPUS DATA
  stdout.write('\nApakah anda ingin menghapus data? (yes/no): ');
  String? pilihanHapus = stdin.readLineSync();

  if (pilihanHapus == 'yes') {
    stdout.write('Ingin hapus apa? (nim/nama/jurusan/ipk): ');
    String? fieldHapus = stdin.readLineSync();

    if (fieldHapus != null && data.containsKey(fieldHapus)) {
      data.remove(fieldHapus);
      print('Data "$fieldHapus" berhasil dihapus!');
    } else {
      print('Field tidak valid!');
    }
  }

  // CEK DATA
  stdout.write('\nApakah anda ingin cek data? (yes/no): ');
  String? pilihanCek = stdin.readLineSync();

  if (pilihanCek == 'yes') {
    print('Data Mahasiswa Single: $data');
  }

  // HITUNG JUMLAH DATA
  stdout.write('\nApakah anda ingin hitung jumlah data? (yes/no): ');
  String? pilihanHitung = stdin.readLineSync();

  if (pilihanHitung == 'yes') {
    print('Jumlah data single: ${data.length}');
    print('Jumlah data multiple: ${dataMahasiswaMultiple.length}');
  }

  // TAMPILKAN SEMUA KEY
  stdout.write('\nApakah anda ingin tampilkan semua key? (yes/no): ');
  String? pilihanKey = stdin.readLineSync();

  if (pilihanKey == 'yes') {
    print('Semua key:');
    for (String kunci in data.keys) {
      print('  - $kunci');
    }
  }

  // TAMPILKAN SEMUA VALUE
  stdout.write('\nApakah anda ingin tampilkan semua value? (yes/no): ');
  String? pilihanValue = stdin.readLineSync();

  if (pilihanValue == 'yes') {
    print('Semua value:');
    for (String nilai in data.values) {
      print('  - $nilai');
    }
  }
}
