import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/re0_theme.dart';
import '../../core/providers.dart';

class ChantingScreen extends ConsumerStatefulWidget {
  const ChantingScreen({super.key});

  @override
  ConsumerState<ChantingScreen> createState() => _ChantingScreenState();
}

class _ChantingScreenState extends ConsumerState<ChantingScreen> {
  final TextEditingController _spellController = TextEditingController();
  int _count = 1;
  String _selectedSize = '1024x1024';

  @override
  Widget build(BuildContext context) {
    final mana = ref.watch(manaProvider);
    final chantingState = ref.watch(chantingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('魔法终端 - 咏唱'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_fix_high, color: Re0Theme.crystalBlue),
            onPressed: () {}, // 自动优化咒文
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildManaStatus(mana),
            const SizedBox(height: 24),
            _buildSpellInput(),
            const SizedBox(height: 24),
            _buildMagicalParameters(),
            const SizedBox(height: 24),
            if (chantingState.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: LinearProgressIndicator(
                  color: Re0Theme.witchLavender,
                  backgroundColor: Colors.white24,
                ),
              ),
            const SizedBox(height: 16),
            _buildChantButton(chantingState.isLoading),
            const SizedBox(height: 40),
            _buildResults(chantingState),
          ],
        ),
      ),
    );
  }

  Widget _buildManaStatus(int mana) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Re0Theme.witchLavender.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Re0Theme.crystalBlue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Re0Theme.manaGlow),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('当前玛那储备', style: TextStyle(color: Re0Theme.deepMidnight.withOpacity(0.7), fontSize: 12)),
              Text('$mana / 5,000', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Re0Theme.crystalBlue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpellInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('编写咒文 (Spells)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        TextField(
          controller: _spellController,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: '描述你想要具现化的景象...',
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }

  Widget _buildMagicalParameters() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildParamRow('咏唱次数', Icons.filter_none, 
              DropdownButton<int>(
                value: _count,
                onChanged: (v) => setState(() => _count = v!),
                items: [1, 2, 4, 6].map((e) => DropdownMenuItem(value: e, child: Text('$e 次'))).toList(),
              )
            ),
            const Divider(),
            _buildParamRow('具现尺寸', Icons.aspect_ratio, 
              DropdownButton<String>(
                value: _selectedSize,
                onChanged: (v) => setState(() => _selectedSize = v!),
                items: ['1024x1024', '1536x1024', '1024x1536', '3840x2160'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParamRow(String label, IconData icon, Widget trailing) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Re0Theme.deepMidnight.withOpacity(0.5)),
        const SizedBox(width: 12),
        Text(label),
        const Spacer(),
        trailing,
      ],
    );
  }

  Widget _buildChantButton(bool isLoading) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : () {
          if (_spellController.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('请输入咒文')),
            );
            return;
          }
          ref.read(chantingProvider.notifier).chant(
            _spellController.text.trim(),
            _count,
            _selectedSize,
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: Re0Theme.crystalBlue,
        ),
        child: Text(isLoading ? '咏唱中...' : '开始咏唱', style: const TextStyle(fontSize: 18, letterSpacing: 2)),
      ),
    );
  }

  Widget _buildResults(AsyncValue<List<String>> state) {
    return state.when(
      data: (urls) {
        if (urls.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('具现成果', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: urls.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    urls[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image)),
                  ),
                );
              },
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(), // Handled by progress bar
      error: (err, stack) => Center(
        child: Text('错误: $err', style: const TextStyle(color: Colors.red)),
      ),
    );
  }
}
