import 'package:dio/dio.dart';

class GatewayClient {
  late Dio _dio;
  final String baseUrl;
  final String apiKey;

  GatewayClient({required this.baseUrl, required this.apiKey}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(minutes: 5),
    ));
  }

  // --- 咏唱 (Chanting/Generate) ---
  Future<Response> chant({
    required String spells,
    int count = 1,
    String size = 'auto',
    String quality = 'auto',
  }) async {
    return _dio.post('/v1/images/generations', data: {
      'prompt': spells,
      'n': count,
      'size': size,
      'quality': quality,
      'response_format': 'url',
    });
  }

  // --- 死亡回归 (Return by Death/Edit) ---
  Future<Response> returnByDeath({
    required String spells,
    required String imageBase64,
    int count = 1,
    String size = 'auto',
  }) async {
    // 兼容网关的 /v1/改图 接口
    return _dio.post('/v1/改图', data: {
      'prompt': spells,
      'image_base64': imageBase64,
      'n': count,
      'size': size,
      'response_format': 'url',
    });
  }

  // --- 玛那校验 (Mana/Quota Check) ---
  // 移动端通常通过 /api/auth/me 获取额度，这里调用 web 侧接口（需 Cookie 或特殊认证）
  // 针对外部 API Key 场景，通常由网关自动控制。
}
