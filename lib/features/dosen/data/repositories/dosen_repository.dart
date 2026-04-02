import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart'; 
import '../models/dosen_model.dart';

class DosenRepository {
  final DioClient _dioClient;

  DosenRepository({DioClient? dioClient}) 
      : _dioClient = dioClient ?? DioClient();

  Future<List<DosenModel>> getDosenList() async {
    try {
      final Response response = await _dioClient.dio.get('/users');
      
      final List<dynamic> data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
      
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 'Unknown';
      throw Exception('Gagal memuat data dosen: $statusCode - ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan sistem: $e');
    }
  }
}