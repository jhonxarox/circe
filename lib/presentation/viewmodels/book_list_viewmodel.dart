import 'package:circe/data/datasources/book_api_service.dart';
import 'package:circe/data/models/book_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<BookListViewModel, AsyncValue<List<BookModel>>>
    bookListProvider =
    StateNotifierProvider<BookListViewModel, AsyncValue<List<BookModel>>>(
  (ref) => BookListViewModel(),
);

class BookListViewModel extends StateNotifier<AsyncValue<List<BookModel>>> {
  BookListViewModel() : super(const AsyncLoading()) {
    fetchBooks();
  }

  final BookApiService _service = BookApiService();

  Future<void> fetchBooks({String? query}) async {
    try {
      state = const AsyncLoading();
      final List<BookModel> books = await _service.fetchBooks(query: query);
      state = AsyncData(books);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
// This ViewModel uses Riverpod's StateNotifier to manage the state of the book list.
// It initializes with a loading state and fetches books from the API.
// The `fetchBooks` method can be called with an optional search query to filter results.
// The state is updated to either `AsyncData` with the list of books or `AsyncError` if an error occurs.
