import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/collection_entity.dart';
import '../../domain/usecases/get_library_usecase.dart';
import '../../../../core/utils/use_case.dart';
import 'library_event.dart';
import 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final GetRecentBooksUseCase _getRecent;
  final GetUnopenedBooksUseCase _getUnopened;
  final GetAllBooksUseCase _getAll;
  final GetCollectionsUseCase _getCollections;

  List<BookEntity> _recentBooks = [];
  List<BookEntity> _unopenedBooks = [];
  List<BookEntity> _allBooks = [];

  LibraryBloc({
    required GetRecentBooksUseCase getRecent,
    required GetUnopenedBooksUseCase getUnopened,
    required GetAllBooksUseCase getAll,
    required GetCollectionsUseCase getCollections,
  })  : _getRecent = getRecent,
        _getUnopened = getUnopened,
        _getAll = getAll,
        _getCollections = getCollections,
        super(const LibraryInitial()) {
    on<LibraryLoadRequested>(_onLoadRequested);
    on<LibraryFilterChanged>(_onFilterChanged);
  }

  Future<void> _onLoadRequested(
    LibraryLoadRequested event,
    Emitter<LibraryState> emit,
  ) async {
    emit(const LibraryLoading());

    // Call each use case individually to preserve generic types —
    // Future.wait<Object> erases them and causes List<Object> assignment errors.
    final recentResult     = await _getRecent(const NoParams());
    final unopenedResult   = await _getUnopened(const NoParams());
    final allResult        = await _getAll(const NoParams());
    final collectionsResult = await _getCollections(const NoParams());

    if (recentResult.isLeft) {
      emit(LibraryFailure(recentResult.left.message));
      return;
    }

    _recentBooks   = recentResult.isRight   ? recentResult.right   : [];
    _unopenedBooks = unopenedResult.isRight  ? unopenedResult.right  : [];
    _allBooks      = allResult.isRight       ? allResult.right       : [];

    final collections = collectionsResult.isRight
        ? collectionsResult.right
        : <CollectionEntity>[];

    emit(LibraryLoaded(
      displayedBooks: _recentBooks,
      collections: collections,
      activeFilter: LibraryFilter.recents,
    ));
  }

  void _onFilterChanged(
    LibraryFilterChanged event,
    Emitter<LibraryState> emit,
  ) {
    final current = state;
    if (current is! LibraryLoaded) return;

    final books = switch (event.filter) {
      LibraryFilter.recents   => _recentBooks,
      LibraryFilter.notOpened => _unopenedBooks,
      LibraryFilter.all       => _allBooks,
    };

    emit(current.copyWith(displayedBooks: books, activeFilter: event.filter));
  }
}
