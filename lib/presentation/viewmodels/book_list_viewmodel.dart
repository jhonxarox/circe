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
  bool _isFetchingMore = false;
  List<BookModel> _books = [];
  String? _currentQuery;

  bool get isFetchingMore => _isFetchingMore;

  void setQuery(String? query) {
    if (_currentQuery != query) {
      _currentQuery = query;
      fetchBooks(isRefresh: true);
    }
  }

  Future<void> fetchBooks({bool isRefresh = false}) async {
    if (_isFetching || (!_hasNextPage && !isRefresh)) return;

    _isFetching = true;
    _isFetchingMore = false;

    if (!isRefresh && _books.isNotEmpty) _isFetchingMore = true;
    if (isRefresh) {
      _currentPage = 1;
      _hasNextPage = true;
      _books = [];
      state = const AsyncLoading();
    } else if (_books.isNotEmpty) {
      _isFetchingMore = true;
      state = AsyncData([..._books]);
    }

    try {
      if (isRefresh) {
        _currentPage = 1;
        _hasNextPage = true;
        _books = [];
      }

      final List<BookModel> newBooks = await _service.fetchBooks(
        page: _currentPage,
        query: _currentQuery,
      );

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
      _isFetchingMore = false;
    }
  }
}
