import '../entities/auth_token_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';

class SignUpParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class SignUpUseCase extends UseCase<(UserEntity, AuthTokenEntity), SignUpParams> {
  final AuthRepository _repository;
  SignUpUseCase(this._repository);

  @override
  Future<Either<Failure, (UserEntity, AuthTokenEntity)>> call(SignUpParams params) {
    if (params.name.trim().isEmpty) {
      return Future.value(const Left(ValidationFailure('Name is required.')));
    }
    if (!params.email.contains('@')) {
      return Future.value(const Left(ValidationFailure('Enter a valid email address.')));
    }
    if (params.password.length < 8) {
      return Future.value(const Left(ValidationFailure('Password must be at least 8 characters.')));
    }
    if (params.password != params.confirmPassword) {
      return Future.value(const Left(ValidationFailure('Passwords do not match.')));
    }
    return _repository.signUp(
      name: params.name.trim(),
      email: params.email.trim(),
      password: params.password,
    );
  }
}
