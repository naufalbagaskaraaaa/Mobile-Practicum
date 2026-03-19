import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../providers/mahasiswa_providers.dart';
import '../widgets/mahasiswa_widgets.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Semua Mahasiswa'), elevation: 0),
      body: state.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: error.toString(),
          onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
        ),
        data: (list) {
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mahasiswaNotifierProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ModernMahasiswaCard(
                  mahasiswa: list[index],
                  gradientColors: AppConstants.dashboardGradients[index % AppConstants.dashboardGradients.length],
                );
              },
            ),
          );
        },
      ),
    );
  }
}