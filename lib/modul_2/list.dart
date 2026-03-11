import 'dart:io';

void main() {

  List<String> datalist = [];
  print('Data List kosong: $datalist');

  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah list: ');
    String? input = stdin.readLineSync();
    try {
      count = int.parse(input!);
      if (count <= 0) {
        print('Masukkan angka leboh dari 0!');
      }
    } catch (e) {
      print('Input tidak valid!');
    }
  }

  for (int i=-0; i < count; i++) {
    stdout.write('index $i: ');
    String x = stdin.readLineSync()!;
    datalist.add(x);
  }

  stdout.write('Apakah anda ingin melihat data? ');
  stdout.write('Jawab (yes/no): ');
  String? inputYesNo = stdin.readLineSync();
  if (inputYesNo == 'yes') {
    try {
      stdout.write('masukan index data yang ingin ditampilkan: ');
      String? input = stdin.readLineSync();
      if (input != null && int.tryParse(input) != null) {
        int index = int.parse(input);
        if (index >= 0 && index < datalist.length) {
          print('data tersebut berada pada index $index: (${datalist[index]})');
        } else {
          print('data tersebut tidak ada!');
        }
      } else {
        print('Input tidak valid!');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  stdout.write('Apakah anda mengupdate/mengubah data? ');
  stdout.write('Jawab (yes/no): ');
  String? inputYesNoUpdate = stdin.readLineSync();
  if (inputYesNoUpdate == 'yes') {
    try {
      stdout.write('masukan index data yang ingin diupdate: ');
      String? input = stdin.readLineSync();
      if (input != null && int.tryParse(input) != null) {
        int index = int.parse(input);
        if (index >= 0 && index < datalist.length) {
          stdout.write('masukan data baru: ');
          String? newData = stdin.readLineSync();
          if (newData != null && newData.isNotEmpty) {
            datalist[index] = newData;
            print('data berhasil diupdate!');
          } else {
            print('Input tidak valid!');
          }
        } else {
          print('data tersebut tidak ada!');
        }
      } else {
        print('Input tidak valid!');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  stdout.write('Apakah anda ingin menghapus data? ');
  stdout.write('Jawab (yes/no): ');
  String? inputYesNoDelete = stdin.readLineSync();
  if (inputYesNoDelete == 'yes') {
    try {
      stdout.write('masukan index data yang ingin dihapus: ');
      String? input = stdin.readLineSync();
      if (input != null && int.tryParse(input) != null) {
        int index = int.parse(input);
        if (index >= 0 && index < datalist.length) {
          datalist.removeAt(index);
          print('data berhasil dihapus!');
        } else {
          print('data tersebut tidak ada!');
        }
      } else {
        print('Input tidak valid!');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  print(' ');
  print('== SEMUA DATA ==');
  print(datalist);
  print(' ');
}