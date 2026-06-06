import '../repositories/auth_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';

class SignOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository _repository;
  SignOutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) => _repository.signOut();
}
