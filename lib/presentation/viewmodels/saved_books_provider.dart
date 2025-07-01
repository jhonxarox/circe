import 'package:circe/data/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedBooksProvider extends StateNotifier<Set<int>> {
  SavedBooksProvider() : super({});

  bool isLiked(int bookId) => state.contains(bookId);

  void toggle(BookModel book) {
    if (state.contains(book.id)) {
      state = {...state}..remove(book.id);
    } else {
      state = {...state}..add(book.id);
    }
  }
}

final likedBooksProvider = StateNotifierProvider<SavedBooksProvider, Set<int>>(
  (ref) => SavedBooksProvider(),
);
