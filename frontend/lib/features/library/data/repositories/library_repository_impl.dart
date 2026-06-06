import '../../domain/entities/book_entity.dart';
import '../../domain/entities/collection_entity.dart';
import '../../domain/repositories/library_repository.dart';
import '../datasources/library_remote_datasource.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/failure.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource _remote;
  LibraryRepositoryImpl(this._remote);

  Future<Either<Failure, T>> _safeCall<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } on ApiException catch (e) {
      return Left(e.isUnauthorized
          ? const UnauthorizedFailure()
          : ServerFailure(e.message));
    } catch (_) {
      return const Left(NetworkFailure('Could not load data. Check your connection.'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getRecentBooks() =>
      _safeCall(() => _remote.getRecentBooks());

  @override
  Future<Either<Failure, List<BookEntity>>> getUnopenedBooks() =>
      _safeCall(() => _remote.getUnopenedBooks());

  @override
  Future<Either<Failure, List<BookEntity>>> getAllBooks() =>
      _safeCall(() => _remote.getAllBooks());

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollections() =>
      _safeCall(() => _remote.getCollections());
}
