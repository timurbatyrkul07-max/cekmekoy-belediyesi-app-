import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_response.dart';

class MayorMessageRepository {
  final ApiClient _client;
  MayorMessageRepository(this._client);

  Future<bool> send({
    required String name,
    required String surname,
    required String phone,
    String? email,
    required String title,
    required String content,
  }) async {
    final raw = await _client.post('/api/public/mayor-messages', body: {
      'name': name,
      'surname': surname,
      'phone': phone,
      if (email != null && email.isNotEmpty) 'email': email,
      'title': title,
      'content': content,
    });
    final res = ApiResponse.fromJson(raw, (_) => null);
    return res.isSuccess;
  }
}

final mayorMessageRepositoryProvider = Provider<MayorMessageRepository>(
    (ref) => MayorMessageRepository(ref.read(apiClientProvider)));
