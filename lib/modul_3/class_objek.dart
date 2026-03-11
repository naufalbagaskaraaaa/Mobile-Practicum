import 'dart:io';

mixin AksesPerpustakaan {
  void aksesPerpustakaan() {
    print("Anda dapat mengakses perpustakaan");
  }
}

mixin AksesLaboratorium {
  void aksesLaboratorium(String namaLaboratorium) {
    print("Anda dapat mengakses laboratorium $namaLaboratorium.");
  }
}

mixin AksesGithubEducation {
  void aksesGithubEducation() {
    print("Anda dapat mengakses GitHub Education.");
  }
}

class Mahasiswa with AksesPerpustakaan, AksesLaboratorium, AksesGithubEducation {
  String? nama;
  int? nim;
  String? jurusan;

  void tampilkanData() {
    print("nama: ${nama ?? 'Belum diisi'}");
    print("nim: ${nim ?? 'Belum diisi'}");
    print("jurusan: ${jurusan ?? 'Belum diisi'}");
  }
}

class Dosen with AksesPerpustakaan, AksesLaboratorium {
  String? namaDosen;
  int? nip;
  void tampilkanData() {
    print("nama dosen: ${namaDosen ?? 'Belum diisi'}");
    print("nip: ${nip ?? 'Belum diisi'}");
  }
}

class Fakultas with AksesPerpustakaan {
  String? namaFakultas;
  String? dekan;
  void tampilkanData() {
    print("nama fakultas: ${namaFakultas ?? 'Belum diisi'}");
    print("dekan: ${dekan ?? 'Belum diisi'}");
  }
}

class MahasiswaAktif extends Mahasiswa {
  int? semester;

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("semester: ${semester ?? 'Belum diisi'}");
  }
}

class MahasiswaAlumni extends Mahasiswa {
  int? tahunLulus;

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("tahun lulus: ${tahunLulus ?? 'Belum diisi'}");
  }
}

void main() {
  Mahasiswa mahasiswa = Mahasiswa();
  print("Masukkan nama mahasiswa:");
  mahasiswa.nama = stdin.readLineSync();
  print("Masukkan NIM mahasiswa:");
  mahasiswa.nim = int.tryParse(stdin.readLineSync() ?? '');
  print("Masukkan jurusan mahasiswa:");
  mahasiswa.jurusan = stdin.readLineSync();
  print("\nData Mahasiswa:");
  mahasiswa.tampilkanData();
  print("\nPrevillage yang yang anda dapatkan:");
  print("Akses Perpustakaan:");
  mahasiswa.aksesPerpustakaan();
  print("Akses Laboratorium:");
  mahasiswa.aksesLaboratorium("Laboratorium Data Science");
  print("Akses GitHub Education:");
  mahasiswa.aksesGithubEducation();

  print("\nSection Mahasiswa Aktif\n");
  MahasiswaAktif mahasiswaAktif = MahasiswaAktif();
  print("Masukkan nama mahasiswa aktif:");
  mahasiswaAktif.nama = stdin.readLineSync();
  print("Masukkan NIM mahasiswa aktif:");
  mahasiswaAktif.nim = int.tryParse(stdin.readLineSync() ?? '');
  print("Masukkan jurusan mahasiswa aktif:");
  mahasiswaAktif.jurusan = stdin.readLineSync();
  print("Masukkan semester mahasiswa aktif tersebut:");
  mahasiswaAktif.semester = int.tryParse(stdin.readLineSync() ?? '');
  print("\nData Mahasiswa Aktif:");
  mahasiswaAktif.tampilkanData();

  print("\nSection Mahasiswa Alumni\n");
  MahasiswaAlumni mahasiswaAlumni = MahasiswaAlumni();
  print("Masukkan nama mahasiswa alumni:");
  mahasiswaAlumni.nama = stdin.readLineSync();
  print("Masukkan NIM mahasiswa alumni:");
  mahasiswaAlumni.nim = int.tryParse(stdin.readLineSync() ?? '');
  print("Masukkan jurusan mahasiswa alumni:");
  mahasiswaAlumni.jurusan = stdin.readLineSync();
  print("Masukkan tahun lulus alumni tersebut:");
  mahasiswaAlumni.tahunLulus = int.tryParse(stdin.readLineSync() ?? '');
  print("\nData Mahasiswa Alumni:");
  mahasiswaAlumni.tampilkanData();

  print("\nSection Dosen");
  Dosen dosen = Dosen();
  print("Masukkan nama dosen:");
  dosen.namaDosen = stdin.readLineSync();
  print("Masukkan NIP dosen:");
  dosen.nip = int.tryParse(stdin.readLineSync() ?? '');
  print("\nData Dosen:");
  dosen.tampilkanData();
  print("\nPrevillage yang yang anda dapatkan:");
  print("Akses Perpustakaan:");
  dosen.aksesPerpustakaan();
  print("Akses Laboratorium:");
  dosen.aksesLaboratorium("Laboratorium Komputer");

  print("\nSection Fakultas");
  Fakultas fakultas = Fakultas();
  print("Masukkan nama fakultas:");
  fakultas.namaFakultas = stdin.readLineSync();
  print("Masukkan nama dekan:");
  fakultas.dekan = stdin.readLineSync();
  print("\nData Fakultas:");
  fakultas.tampilkanData();
  print("\nPrevillage yang yang anda dapatkan:");
  print("Akses Perpustakaan:");
  fakultas.aksesPerpustakaan();
}