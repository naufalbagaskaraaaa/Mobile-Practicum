import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/models/mahasiswa_model.dart';
import '../../data/repositories/mahasiswa_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MahasiswaRepository(dioClient: dioClient);
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) => LocalStorageService());

final savedMahasiswaProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);
  return await storage.getSavedUsers(); 
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }

  Future<void> saveSelectedMahasiswa(MahasiswaModel mhs) async {
    await _storage.addUserToSavedList(
      userId: mhs.id.toString(),
      username: mhs.name,
    );
  }

  Future<void> removeSavedMahasiswa(String id) async {
    await _storage.removeSavedUser(id);
  }

  Future<void> clearSavedMahasiswa() async {
    await _storage.clearSavedUsers();
  }
}

final mahasiswaNotifierProvider = StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return MahasiswaNotifier(repository, storage);
});