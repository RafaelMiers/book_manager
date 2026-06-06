import '../../domain/entities/collection_entity.dart';
import 'book_model.dart';

class CollectionModel extends CollectionEntity {
  const CollectionModel({
    required super.id,
    required super.name,
    required super.accentColor,
    required super.books,
    required super.createdAt,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) => CollectionModel(
        id: json['id'] as String,
        name: json['name'] as String,
        accentColor: json['accent_color'] as String? ?? '#A78BFA',
        books: (json['books'] as List<dynamic>? ?? [])
            .map((b) => BookModel.fromJson(b as Map<String, dynamic>))
            .toList(),
        createdAt: DateTime.parse(json['created_at'] as String),
      );
}
