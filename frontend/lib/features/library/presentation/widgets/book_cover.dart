import 'package:flutter/material.dart';
import '../../domain/entities/book_entity.dart';

/// Full-size cover used inside the hero shelf cards.
/// Falls back to a gradient tile when no [BookEntity.coverUrl] is provided.
class BookCover extends StatelessWidget {
  final BookEntity book;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const BookCover({
    super.key,
    required this.book,
    this.width = 110,
    this.height = 158,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  Color _parsedColor(BuildContext context) {
    if (book.coverColor == null) {
      return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
    try {
      return Color(int.parse(book.coverColor!.replaceAll('#', '0xFF')));
    } catch (_) {
      return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = book.readProgress; // uses readProgress from BookEntity

    return Stack(
      children: [
        // Cover image or colour fallback
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: _parsedColor(context),
            image: book.coverUrl != null
                ? DecorationImage(
                    image: NetworkImage(book.coverUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: book.coverUrl == null
              ? ClipRRect(
                  borderRadius: borderRadius,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          _parsedColor(context),
                          _parsedColor(context).withValues(alpha: 0.7),
                        ],
                      ),
                    ),
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
                  ),
                )
              : null,
        ),

        // Progress badge — shown only when in progress
        if (book.isOpened && progress > 0 && !book.isFinished)
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

        // Bottom progress bar overlay
        if (book.isOpened)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: borderRadius.bottomLeft,
                bottomRight: borderRadius.bottomRight,
              ),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 3,
                backgroundColor: Colors.black26,
                color: book.isFinished
                    ? theme.colorScheme.secondary   // green when done
                    : theme.colorScheme.primary,    // purple when in progress
              ),
            ),
          ),
      ],
    );
  }
}
