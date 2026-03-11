import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/dashboard_model.dart';
import '../../data/repositories/dashboard_repository.dart';

/// Provider untuk DashboardRepository (Dependency Injection)
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});

/// Menggunakan FutureProvider untuk async data (Contoh dasar)
final dashboardDataProvider = FutureProvider<DashboardData>((ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.getDashboardData();
});

/// StateNotifier untuk mengelola state dashboard yang lebih kompleks
class DashboardNotifier extends StateNotifier<AsyncValue<DashboardData>> {
  final DashboardRepository _repository;

  DashboardNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadDashboard();
  }

  /// Load dashboard data
  Future<void> loadDashboard() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getDashboardData();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh dashboard
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.refreshDashboard();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update user name (contoh untuk state management parsial)
  void updateUserName(String newName) {
    state.whenData((data) {
      state = AsyncValue.data(data.copyWith(userName: newName));
    });
  }
}

/// Provider utama untuk DashboardNotifier
final dashboardNotifierProvider = 
    StateNotifierProvider<DashboardNotifier, AsyncValue<DashboardData>>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository);
});

/// Provider untuk stat yang dipilih (contoh state sederhana)
final selectedStatIndexProvider = StateProvider<int>((ref) => 0);

/// Provider untuk dark/light mode
final themeModeProvider = StateProvider<bool>((ref) => false);