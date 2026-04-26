import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/providers.dart';
import '../../core/re0_theme.dart';

class LoopScreen extends ConsumerStatefulWidget {
  const LoopScreen({super.key});

  @override
  ConsumerState<LoopScreen> createState() => _LoopScreenState();
}

class _LoopScreenState extends ConsumerState<LoopScreen> {
  final TextEditingController _spellController = TextEditingController();
  File? _imageFile;
  int _count = 1;
  String _size = '1024x1024';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mana = ref.watch(manaProvider);
    final editQuota = mana['edit'];
    final remain = editQuota['is_unlimited'] == true ? '无限' : '${editQuota['remaining']} / ${editQuota['total']}';
    final chantingState = ref.watch(chantingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('死亡回归 - 改图')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildManaStatus(remain),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: Re0Theme.witchLavender.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Re0Theme.crystalBlue.withOpacity(0.5)),
                ),
                child: _imageFile == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 48, color: Re0Theme.crystalBlue),
                          SizedBox(height: 8),
                          Text('点击选择需要回归的原图'),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(_imageFile!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('修正咒文 (Edit Prompt)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              controller: _spellController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: '描述你想要如何改变这张图...'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: chantingState.isLoading || _imageFile == null ? null : () {
                  ref.read(chantingProvider.notifier).returnByDeath(
                    _spellController.text, _imageFile!.path, _count, _size
                  );
                },
                child: chantingState.isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('开始死亡回归', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 24),
            chantingState.when(
              data: (items) {
                if (items.isEmpty) return const SizedBox();
                return Column(
                  children: items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(item['url']),
                    ),
                  )).toList(),
                );
              },
              error: (err, _) => Text('回归失败: $err', style: const TextStyle(color: Re0Theme.errorRed)),
              loading: () => const Center(child: Text('时间回溯中...')),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildManaStatus(String remain) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Re0Theme.witchLavender.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.history_toggle_off, color: Re0Theme.manaGlow),
          const SizedBox(width: 12),
          Text('改图玛那: $remain', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
