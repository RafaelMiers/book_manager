import '../entities/book_entity.dart';
import '../entities/collection_entity.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';

abstract class LibraryRepository {
  Future<Either<Failure, List<BookEntity>>> getRecentBooks();
  Future<Either<Failure, List<BookEntity>>> getUnopenedBooks();
  Future<Either<Failure, List<BookEntity>>> getAllBooks();
  Future<Either<Failure, List<CollectionEntity>>> getCollections();
}
