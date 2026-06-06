import '../entities/auth_token_entity.dart';
import '../entities/user_entity.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, (UserEntity, AuthTokenEntity)>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, (UserEntity, AuthTokenEntity)>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, AuthTokenEntity>> refreshToken(String refreshToken);
}
