import 'package:flutter/material.dart';
import '../../domain/entities/collection_entity.dart';
import 'book_thumb_card.dart';

class CollectionRow extends StatelessWidget {
  final CollectionEntity collection;
  final VoidCallback? onSeeAll;

  const CollectionRow({super.key, required this.collection, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = Color(int.parse(collection.accentColor.replaceAll('#', '0xFF')));

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.folder, size: 16, color: accentColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(collection.name, style: theme.textTheme.titleMedium),
                ),
                TextButton(
                  onPressed: onSeeAll,
                  child: const Text('See all'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: collection.books.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) => BookThumbCard(book: collection.books[i]),
            ),
          ),
        ],
      ),
    );
  }
}
