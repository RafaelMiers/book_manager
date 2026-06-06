sealed class LibraryEvent {
  const LibraryEvent();
}

class LibraryLoadRequested extends LibraryEvent {
  const LibraryLoadRequested();
}

class LibraryFilterChanged extends LibraryEvent {
  final LibraryFilter filter;
  const LibraryFilterChanged(this.filter);
}

enum LibraryFilter { recents, notOpened, all }
