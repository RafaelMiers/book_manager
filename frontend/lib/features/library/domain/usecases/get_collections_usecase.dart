import '../entities/collection_entity.dart';
import '../repositories/library_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';

class GetCollectionsUseCase extends UseCase<List<CollectionEntity>, NoParams> {
  final LibraryRepository _repository;
  GetCollectionsUseCase(this._repository);

  @override
  Future<Either<Failure, List<CollectionEntity>>> call(NoParams params) =>
      _repository.getCollections();
}
