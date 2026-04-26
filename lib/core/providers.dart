import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'gateway_client.dart';
import 'dart:async';

final gatewayClientProvider = Provider<GatewayClient>((ref) {
  // In a real app, these would come from environment variables or a config service
  return GatewayClient(
    baseUrl: 'https://api.re0-studio.io', 
    apiKey: 'sk-re0-dummy-key',
  );
});

final manaProvider = StateProvider<int>((ref) => 5000);

class ChantingNotifier extends AsyncNotifier<List<String>> {
  @override
  FutureOr<List<String>> build() {
    return [];
  }

  Future<void> chant(String spells, int count, String size) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final client = ref.read(gatewayClientProvider);
      final response = await client.chant(
        spells: spells,
        count: count,
        size: size,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final urls = data.map((e) => e['url'] as String).toList();
        
        // Decrement mana: 100 per image
        final totalCost = count * 100;
        ref.read(manaProvider.notifier).update((state) => state - totalCost);
        
        return [...state.value ?? [], ...urls];
      } else {
        throw Exception('咏唱失败: ${response.statusMessage}');
      }
    });
  }
}

final chantingProvider = AsyncNotifierProvider<ChantingNotifier, List<String>>(() {
  return ChantingNotifier();
});
