import 'dart:convert';
import '../../domain/entities/auth_token_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorage _secureStorage;
  final ApiClient _apiClient;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required SecureStorage secureStorage,
    required ApiClient apiClient,
  })  : _remoteDataSource = remoteDataSource,
        _secureStorage = secureStorage,
        _apiClient = apiClient;

  @override
  Future<Either<Failure, (UserEntity, AuthTokenEntity)>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.signIn(email: email, password: password);
      await _secureStorage.saveToken(response.token.accessToken);
      await _secureStorage.saveUser(jsonEncode(response.user.toJson()));
      _apiClient.setAuthToken(response.token.accessToken);
      return Right((response.user, response.token));
    } on ApiException catch (e) {
      return Left(e.isUnauthorized
          ? const ValidationFailure('Invalid email or password.')
          : ServerFailure(e.message));
    } catch (_) {
      return const Left(NetworkFailure('Could not reach the server. Check your connection.'));
    }
  }

  @override
  Future<Either<Failure, (UserEntity, AuthTokenEntity)>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.signUp(name: name, email: email, password: password);
      await _secureStorage.saveToken(response.token.accessToken);
      await _secureStorage.saveUser(jsonEncode(response.user.toJson()));
      _apiClient.setAuthToken(response.token.accessToken);
      return Right((response.user, response.token));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(NetworkFailure('Could not reach the server. Check your connection.'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();
    } catch (_) {
      // Best-effort — always clear local state
    }
    await _secureStorage.clear();
    _apiClient.clearAuthToken();
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userJson = await _secureStorage.getUser();
      if (userJson == null) return const Left(UnauthorizedFailure());
      final user = UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      return Right(user);
    } catch (_) {
      return const Left(CacheFailure('Failed to load user from storage.'));
    }
  }

  @override
  Future<Either<Failure, AuthTokenEntity>> refreshToken(String refreshToken) async {
    try {
      final data = await _apiClient.post('/auth/refresh', {'refresh_token': refreshToken});
      final token = AuthTokenEntity(
        accessToken: data['access_token'] as String,
        refreshToken: data['refresh_token'] as String?,
        expiresAt: DateTime.parse(data['expires_at'] as String),
      );
      await _secureStorage.saveToken(token.accessToken);
      _apiClient.setAuthToken(token.accessToken);
      return Right(token);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(NetworkFailure('Token refresh failed.'));
    }
  }
}
