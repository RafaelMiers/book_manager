import '../../domain/entities/book_entity.dart';
import '../../domain/entities/collection_entity.dart';
import 'library_event.dart';

sealed class LibraryState {
  const LibraryState();
}

class LibraryInitial extends LibraryState {
  const LibraryInitial();
}

class LibraryLoading extends LibraryState {
  const LibraryLoading();
}

class LibraryLoaded extends LibraryState {
  final List<BookEntity> displayedBooks;   // top shelf (filtered)
  final List<CollectionEntity> collections;
  final LibraryFilter activeFilter;

  const LibraryLoaded({
    required this.displayedBooks,
    required this.collections,
    required this.activeFilter,
  });

  LibraryLoaded copyWith({
    List<BookEntity>? displayedBooks,
    List<CollectionEntity>? collections,
    LibraryFilter? activeFilter,
  }) =>
      LibraryLoaded(
        displayedBooks: displayedBooks ?? this.displayedBooks,
        collections: collections ?? this.collections,
        activeFilter: activeFilter ?? this.activeFilter,
      );
}

class LibraryFailure extends LibraryState {
  final String message;
  const LibraryFailure(this.message);
}
