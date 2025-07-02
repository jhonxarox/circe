import 'package:circe/data/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedBooksProvider extends StateNotifier<Set<BookModel>> {
  SavedBooksProvider() : super({});

  bool isSaved(BookModel book) => state.any((b) => b.id == book.id);

  void toggle(BookModel book) {
    final BookModel existing = state.firstWhere(
      (b) => b.id == book.id,
      orElse: () => BookModel(
        id: -1,
        title: '',
        authors: [],
        summaries: [],
        formats: {},
        downloadCount: 0,
      ),
    );

    if (existing.id != -1) {
      state = {...state}..remove(existing);
    } else {
      state = {...state}..add(book);
    }
  }
}

final StateNotifierProvider<SavedBooksProvider, Set<BookModel>>
    savedBooksProvider =
    StateNotifierProvider<SavedBooksProvider, Set<BookModel>>(
  (ref) => SavedBooksProvider(),
);
