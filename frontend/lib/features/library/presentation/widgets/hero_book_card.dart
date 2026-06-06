import 'package:flutter/material.dart';
import '../../domain/entities/book_entity.dart';
import 'book_cover.dart';

/// Hero-sized card used in the top filtered shelf on the Library screen.
class HeroBookCard extends StatelessWidget {
  final BookEntity book;
  final VoidCallback? onTap;

  const HeroBookCard({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookCover(book: book, width: 110, height: 158),
            const SizedBox(height: 4),
            if (book.rating != null)
              Row(
                children: List.generate(5, (i) => Icon(
                  i < book.rating!.floor() ? Icons.star : Icons.star_border,
                  size: 12,
                  color: const Color(0xFFF59E0B),
                )),
              )
            else if (!book.isOpened)
              Text('Not started', style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
