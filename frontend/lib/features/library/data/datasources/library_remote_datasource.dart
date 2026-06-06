import '../models/book_model.dart';
import '../models/collection_model.dart';
import '../../../../core/network/api_client.dart';

abstract class LibraryRemoteDataSource {
  Future<List<BookModel>> getRecentBooks();
  Future<List<BookModel>> getUnopenedBooks();
  Future<List<BookModel>> getAllBooks();
  Future<List<CollectionModel>> getCollections();
}

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final ApiClient _apiClient;
  LibraryRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<BookModel>> getRecentBooks() async {
    final data = await _apiClient.get('/library/books?sort=recent&limit=20');
    return (data as List).map((b) => BookModel.fromJson(b as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<BookModel>> getUnopenedBooks() async {
    final data = await _apiClient.get('/library/books?filter=unopened');
    return (data as List).map((b) => BookModel.fromJson(b as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<BookModel>> getAllBooks() async {
    final data = await _apiClient.get('/library/books');
    return (data as List).map((b) => BookModel.fromJson(b as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<CollectionModel>> getCollections() async {
    final data = await _apiClient.get('/library/collections?include_books=true');
    return (data as List)
        .map((c) => CollectionModel.fromJson(c as Map<String, dynamic>))
        .toList();
  }
}
