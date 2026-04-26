import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers.dart';
import '../../core/re0_theme.dart';

class ChantingScreen extends ConsumerStatefulWidget {
  const ChantingScreen({super.key});

  @override
  ConsumerState<ChantingScreen> createState() => _ChantingScreenState();
}

class _ChantingScreenState extends ConsumerState<ChantingScreen> {
  final TextEditingController _spellController = TextEditingController();
  int _count = 1;
  String _size = '1024x1024';
  String _quality = 'high';
  String _background = 'auto';

  @override
  Widget build(BuildContext context) {
    final mana = ref.watch(manaProvider);
    final generateQuota = mana['generate'];
    final remain = generateQuota['is_unlimited'] == true ? '无限' : '${generateQuota['remaining']} / ${generateQuota['total']}';

    final chantingState = ref.watch(chantingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('魔法终端 - 咏唱'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildManaStatus(remain),
            const SizedBox(height: 24),
            const Text('编写咒文 (Spells)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            TextField(
              controller: _spellController,
              maxLines: 4,
              decoration: const InputDecoration(hintText: '描述你想要具现化的景象...'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: DropdownButtonFormField<int>(
                  value: _count,
                  decoration: const InputDecoration(labelText: '数量'),
                  items: [1,2,3,4].map((e) => DropdownMenuItem(value: e, child: Text('$e张'))).toList(),
                  onChanged: (v) => setState(() => _count = v!),
                )),
                const SizedBox(width: 16),
                Expanded(child: DropdownButtonFormField<String>(
                  value: _size,
                  decoration: const InputDecoration(labelText: '尺寸'),
                  items: ['1024x1024', '1024x1536', '1536x1024'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => _size = v!),
                )),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: chantingState.isLoading ? null : () {
                  ref.read(chantingProvider.notifier).chant(
                    _spellController.text, _count, _size, _quality, _background
                  );
                },
                child: chantingState.isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('开始咏唱', style: TextStyle(fontSize: 18)),
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
              error: (err, _) => Text('咏唱失败: $err', style: const TextStyle(color: Re0Theme.errorRed)),
              loading: () => const Center(child: Text('正在与世界根源沟通...')),
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
          const Icon(Icons.bolt, color: Re0Theme.manaGlow),
          const SizedBox(width: 12),
          Text('生图玛那: $remain', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
