import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/mahasiswa_model.dart';
import '../providers/mahasiswa_providers.dart';

class MahasiswaPage extends ConsumerWidget {
  const MahasiswaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mhsState = ref.watch(mahasiswaNotifierProvider);
    final savedUsers = ref.watch(savedMahasiswaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Mahasiswa'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(mahasiswaNotifierProvider),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SavedMahasiswaSection(savedUsers: savedUsers),
          
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text('Daftar Mahasiswa', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          
          Expanded(
            child: mhsState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error:\n$error', style: const TextStyle(color: Colors.red))),
              data: (list) => MahasiswaListWithSave(
                list: list,
                onRefresh: () => ref.invalidate(mahasiswaNotifierProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SavedMahasiswaSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  const SavedMahasiswaSection({super.key, required this.savedUsers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text('Tersimpan di Local Storage', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Spacer(),
              savedUsers.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton.icon(
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).clearSavedMahasiswa();
                          ref.invalidate(savedMahasiswaProvider);
                        },
                        icon: const Icon(Icons.delete_sweep_outlined, size: 14, color: Colors.red),
                        label: const Text('Hapus Semua', style: TextStyle(fontSize: 12, color: Colors.red)),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          savedUsers.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, __) => const Text('Gagal memuat', style: TextStyle(color: Colors.red)),
            data: (users) {
              if (users.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Belum ada data. Tap ikon Save di bawah.', style: TextStyle(fontSize: 12)),
                );
              }
              return Container(
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(radius: 14, child: Text('${index + 1}', style: const TextStyle(fontSize: 11))),
                      title: Text(user['username'] ?? '-', maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 16, color: Colors.red),
                        onPressed: () async {
                          await ref.read(mahasiswaNotifierProvider.notifier).removeSavedMahasiswa(user['user_id'] ?? '');
                          ref.invalidate(savedMahasiswaProvider);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MahasiswaListWithSave extends ConsumerWidget {
  final List<MahasiswaModel> list;
  final VoidCallback onRefresh;
  const MahasiswaListWithSave({super.key, required this.list, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final mhs = list[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text('${mhs.id}')),
              title: Text(mhs.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text('${mhs.email}\n"${mhs.body.replaceAll('\n', ' ')}"'),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save, color: Colors.blue),
                onPressed: () async {
                  await ref.read(mahasiswaNotifierProvider.notifier).saveSelectedMahasiswa(mhs);
                  ref.invalidate(savedMahasiswaProvider);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Disimpan!')));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}