import 'package:flutter/material.dart';
import '../../domain/entities/book_entity.dart';

/// Small thumbnail used inside collection rows.
class BookThumbnail extends StatelessWidget {
  final BookEntity book;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const BookThumbnail({
    super.key,
    required this.book,
    this.width = 72,
    this.height = 104,
    this.onTap,
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

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: _parsedColor(context),
                image: book.coverUrl != null
                    ? DecorationImage(
                        image: NetworkImage(book.coverUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              book.title,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
