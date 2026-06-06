class BookEntity {
  final String id;
  final String title;
  final String author;
  final String? genre;
  final String? coverColor;   // hex — used when no cover image
  final String? coverUrl;
  final double? rating;
  final String? review;
  final int? totalChapters;
  final int? currentChapter;
  final bool isOpened;
  final DateTime addedAt;
  final DateTime? lastOpenedAt;

  const BookEntity({
    required this.id,
    required this.title,
    required this.author,
    this.genre,
    this.coverColor,
    this.coverUrl,
    this.rating,
    this.review,
    this.totalChapters,
    this.currentChapter,
    this.isOpened = false,
    required this.addedAt,
    this.lastOpenedAt,
  });

  double get readProgress {
    if (totalChapters == null || totalChapters == 0) return 0;
    return (currentChapter ?? 0) / totalChapters!;
  }

  bool get isFinished => readProgress >= 1.0;
}
