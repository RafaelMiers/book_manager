import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    super.genre,
    super.coverColor,
    super.coverUrl,
    super.rating,
    super.review,
    super.totalChapters,
    super.currentChapter,
    super.isOpened,
    required super.addedAt,
    super.lastOpenedAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'] as String,
        title: json['title'] as String,
        author: json['author'] as String,
        genre: json['genre'] as String?,
        coverColor: json['cover_color'] as String?,
        coverUrl: json['cover_url'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        review: json['review'] as String?,
        totalChapters: json['total_chapters'] as int?,
        currentChapter: json['current_chapter'] as int?,
        isOpened: json['is_opened'] as bool? ?? false,
        addedAt: DateTime.parse(json['added_at'] as String),
        lastOpenedAt: json['last_opened_at'] != null
            ? DateTime.parse(json['last_opened_at'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'genre': genre,
        'cover_color': coverColor,
        'cover_url': coverUrl,
        'rating': rating,
        'review': review,
        'total_chapters': totalChapters,
        'current_chapter': currentChapter,
        'is_opened': isOpened,
        'added_at': addedAt.toIso8601String(),
        'last_opened_at': lastOpenedAt?.toIso8601String(),
      };
}
