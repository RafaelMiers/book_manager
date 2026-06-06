import '../models/auth_response_model.dart';
import '../../../../core/network/api_client.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signIn({required String email, required String password});
  Future<AuthResponseModel> signUp({required String name, required String email, required String password});
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    final data = await _apiClient.post('/auth/sign-in', {
      'email': email,
      'password': password,
    });
    return AuthResponseModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final data = await _apiClient.post('/auth/sign-up', {
      'name': name,
      'email': email,
      'password': password,
    });
    return AuthResponseModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<void> signOut() => _apiClient.post('/auth/sign-out', {});
}
