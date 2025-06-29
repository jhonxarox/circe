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
  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isFetching = false;
  List<BookModel> _books = [];

  Future<void> fetchBooks({bool isRefresh = false}) async {
    if (_isFetching || !_hasNextPage) return;
    _isFetching = true;

    try {
      if (isRefresh) {
        _currentPage = 1;
        _hasNextPage = true;
        _books = [];
      }

      final newBooks = await _service.fetchBooks(page: _currentPage);
      if (newBooks.isEmpty) {
        _hasNextPage = false;
      } else {
        _books.addAll(newBooks);
        _currentPage++;
      }

      state = AsyncData([..._books]);
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isFetching = false;
    }
  }
}
