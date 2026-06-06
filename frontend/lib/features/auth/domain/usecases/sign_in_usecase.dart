import '../entities/auth_token_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';

class SignInParams {
  final String email;
  final String password;
  const SignInParams({required this.email, required this.password});
}

class SignInUseCase extends UseCase<(UserEntity, AuthTokenEntity), SignInParams> {
  final AuthRepository _repository;
  SignInUseCase(this._repository);

  @override
  Future<Either<Failure, (UserEntity, AuthTokenEntity)>> call(SignInParams params) {
    if (params.email.trim().isEmpty || params.password.isEmpty) {
      return Future.value(const Left(ValidationFailure('Email and password are required.')));
    }
    return _repository.signIn(email: params.email.trim(), password: params.password);
  }
}
