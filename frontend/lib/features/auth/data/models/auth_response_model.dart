import '../../domain/entities/auth_token_entity.dart';
import 'user_model.dart';

class AuthResponseModel {
  final UserModel user;
  final AuthTokenEntity token;

  const AuthResponseModel({required this.user, required this.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final tokenData = json['token'] as Map<String, dynamic>;
    return AuthResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: AuthTokenEntity(
        accessToken: tokenData['access_token'] as String,
        refreshToken: tokenData['refresh_token'] as String?,
        expiresAt: DateTime.parse(tokenData['expires_at'] as String),
      ),
    );
  }
}
