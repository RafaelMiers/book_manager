import 'package:flutter/material.dart';
import '../../domain/entities/book_entity.dart';

class BookThumbCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback? onTap;

  const BookThumbCard({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 104,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
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
            ),
            const SizedBox(height: 5),
            Text(
              book.title,
              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
