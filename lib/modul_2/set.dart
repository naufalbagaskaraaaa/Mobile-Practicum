import 'dart:io';

void main() {
  Set<String> dataSet = {};

  int count = 0;
  while (count <= 0) {
    stdout.write('Masukkan jumlah set: ');
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

  print('== SEMUA DATA ==');
  
  for (int i=-0; i < count; i++) {
    stdout.write(' ${i+1}. ');
    String x = stdin.readLineSync()!;
    dataSet.add(x);
  }
  print('total data: ${dataSet.length}');

  stdout.write('masukan data baru: ');
  String? newData = stdin.readLineSync();
  if (newData != null && newData.isNotEmpty) {
    bool berhasil = dataSet.add(newData);
    if (berhasil) {
      print('data "$newData" berhasil ditambahkan');
    } else {
      print('data tidak bisa duplikat');
    }
  }

  stdout.write('masukan data yang ingin dihapus: ');
  String? newDataDelete = stdin.readLineSync();
  if (newDataDelete != null && newDataDelete.isNotEmpty) {
    dataSet.remove(newDataDelete);
  }
  print('data "$newDataDelete" berhasil dihapus');

  stdout.write('masukan data yang ingin ingin di cek: ');
  String? newDataCek = stdin.readLineSync();
  if (dataSet.contains(newDataCek)) {
    print('data "$newDataCek" ditemukan');
  } else {
    print('data "$newDataCek" tidak ditemukan');
  }
}