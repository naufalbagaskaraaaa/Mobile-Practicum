import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/models/dosen_model.dart';
import '../../data/repositories/dosen_repository.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final dosenRepositoryProvider = Provider<DosenRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DosenRepository(dioClient: dioClient);
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final savedUsersProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);
  return await storage.getSavedUsers();
});

final savedUserProvider = FutureProvider<Map<String, String?>>((ref) async {
  final storage = ref.watch(localStorageServiceProvider);
  final userId = await storage.getUserId();
  final username = await storage.getUsername();
  final token = await storage.getToken();
  return {'userId': userId, 'username': username, 'token': token};
});

class DosenNotifier extends StateNotifier<AsyncValue<List<DosenModel>>> {
  final DosenRepository _repository;
  final LocalStorageService _storage;

  DosenNotifier(this._repository, this._storage) : super(const AsyncValue.loading()) {
    loadDosenList();
  }

  Future<void> loadDosenList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDosenList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadDosenList();
  }

  Future<void> saveSelectedDosen(DosenModel dosen) async {
    await _storage.addUserToSavedList(
      userId: dosen.id.toString(),
      username: dosen.username,
    );
  }

  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedUser(userId);
  }

  Future<void> clearSavedUsers() async {
    await _storage.clearSavedUsers();
  }
}

final dosenNotifierProvider = StateNotifierProvider.autoDispose<DosenNotifier, AsyncValue<List<DosenModel>>>((ref) {
  final repository = ref.watch(dosenRepositoryProvider);
  final storage = ref.watch(localStorageServiceProvider);
  return DosenNotifier(repository, storage);
});