import 'book_entity.dart';

class CollectionEntity {
  final String id;
  final String name;
  final String accentColor; // hex
  final List<BookEntity> books;
  final DateTime createdAt;

  const CollectionEntity({
    required this.id,
    required this.name,
    required this.accentColor,
    required this.books,
    required this.createdAt,
  });
}
