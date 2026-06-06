import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/library_bloc.dart';
import '../bloc/library_event.dart';
import '../bloc/library_state.dart';
import '../widgets/book_hero_card.dart';
import '../widgets/collection_row.dart';
import '../../../auth/domain/entities/user_entity.dart';

class LibraryPage extends StatefulWidget {
  final UserEntity user;
  const LibraryPage({super.key, required this.user});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(const LibraryLoadRequested());
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('stacks', style: theme.textTheme.titleLarge),
                          Text(
                            '${_greeting()}, ${widget.user.name.split(' ').first}',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      onPressed: () {},
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: theme.colorScheme.primaryContainer,
                      backgroundImage: widget.user.avatarUrl != null
                          ? NetworkImage(widget.user.avatarUrl!)
                          : null,
                      child: widget.user.avatarUrl == null
                          ? Text(
                              widget.user.name[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),

            // Body
            BlocBuilder<LibraryBloc, LibraryState>(
              builder: (context, state) {
                if (state is LibraryLoading || state is LibraryInitial) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is LibraryFailure) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off, size: 40, color: theme.colorScheme.onSurfaceVariant),
                          const SizedBox(height: 12),
                          Text(state.message, style: theme.textTheme.bodySmall),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => context.read<LibraryBloc>().add(const LibraryLoadRequested()),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final loaded = state as LibraryLoaded;

                return SliverList(
                  delegate: SliverChildListDelegate([
                    // Filter chips
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 14),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: LibraryFilter.values.map((filter) {
                            final label = switch (filter) {
                              LibraryFilter.recents => 'Recents',
                              LibraryFilter.notOpened => 'Not opened',
                              LibraryFilter.all => 'All',
                            };
                            final isActive = loaded.activeFilter == filter;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(label),
                                selected: isActive,
                                onSelected: (_) => context
                                    .read<LibraryBloc>()
                                    .add(LibraryFilterChanged(filter)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                    // Hero shelf (top filter row)
                    SizedBox(
                      height: 210,
                      child: loaded.displayedBooks.isEmpty
                          ? Center(
                              child: Text('No books here yet.', style: theme.textTheme.bodySmall),
                            )
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: loaded.displayedBooks.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 10),
                              itemBuilder: (_, i) =>
                                  BookHeroCard(book: loaded.displayedBooks[i]),
                            ),
                    ),

                    const SizedBox(height: 20),

                    // Collection rows
                    ...loaded.collections.map(
                      (c) => CollectionRow(collection: c, onSeeAll: () {}),
                    ),

                    const SizedBox(height: 16),
                  ]),
                );
              },
            ),
          ],
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.folder_open), label: 'Collections'),
          NavigationDestination(icon: Icon(Icons.upload_file), label: 'Add'),
          NavigationDestination(icon: Icon(Icons.star_border), label: 'Reviews'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
        onDestinationSelected: (_) {},
      ),
    );
  }
}
