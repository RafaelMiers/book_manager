import '../entities/book_entity.dart';
import '../entities/collection_entity.dart';
import '../repositories/library_repository.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';
import '../../../../core/utils/use_case.dart';

class GetRecentBooksUseCase extends UseCase<List<BookEntity>, NoParams> {
  final LibraryRepository _repository;
  GetRecentBooksUseCase(this._repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) =>
      _repository.getRecentBooks();
}

class GetUnopenedBooksUseCase extends UseCase<List<BookEntity>, NoParams> {
  final LibraryRepository _repository;
  GetUnopenedBooksUseCase(this._repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) =>
      _repository.getUnopenedBooks();
}

class GetAllBooksUseCase extends UseCase<List<BookEntity>, NoParams> {
  final LibraryRepository _repository;
  GetAllBooksUseCase(this._repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) =>
      _repository.getAllBooks();
}

class GetCollectionsUseCase extends UseCase<List<CollectionEntity>, NoParams> {
  final LibraryRepository _repository;
  GetCollectionsUseCase(this._repository);

  @override
  Future<Either<Failure, List<CollectionEntity>>> call(NoParams params) =>
      _repository.getCollections();
}
