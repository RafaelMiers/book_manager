import 'package:flutter/material.dart';
import '../../domain/entities/book_entity.dart';

class BookHeroCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback? onTap;

  const BookHeroCard({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = book.readProgress;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover
            Stack(
              children: [
                Container(
                  width: 110,
                  height: 158,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: book.coverColor != null
                        ? Color(int.parse(book.coverColor!.replaceAll('#', '0xFF')))
                        : theme.colorScheme.surfaceContainerHighest,
                    image: book.coverUrl != null
                        ? DecorationImage(
                            image: NetworkImage(book.coverUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: book.coverUrl == null
                      ? Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (book.genre != null)
                                Text(
                                  book.genre!.toUpperCase(),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: Colors.white70,
                                    letterSpacing: 0.05,
                                  ),
                                ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: theme.textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    book.author,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : null,
                ),

                // Progress badge
                if (progress > 0 && !book.isFinished)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${(progress * 100).round()}%',
                        style: theme.textTheme.labelSmall?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 4),

            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: theme.colorScheme.outlineVariant,
              color: book.isFinished
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary,
              minHeight: 2,
              borderRadius: BorderRadius.circular(1),
            ),
            const SizedBox(height: 4),

            // Stars or "not started"
            if (book.rating != null)
              _StarRow(rating: book.rating!)
            else if (!book.isOpened)
              Text('Not started', style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  final double rating;
  const _StarRow({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return Icon(
          i < rating.floor() ? Icons.star : Icons.star_border,
          size: 12,
          color: const Color(0xFFF59E0B),
        );
      }),
    );
  }
}
