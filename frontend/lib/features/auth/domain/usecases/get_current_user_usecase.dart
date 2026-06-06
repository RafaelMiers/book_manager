import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';

class GetCurrentUserUseCase extends UseCase<UserEntity, NoParams> {
  final AuthRepository _repository;
  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) =>
      _repository.getCurrentUser();
}
