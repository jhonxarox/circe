import 'package:circe/data/datasources/book_api_service.dart';
import 'package:circe/data/models/book_model.dart';
import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/data/models/book_response_model.dart';
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
  String? _nextPageUrl;
  String? _prevPageUrl;
  bool _isFetching = false;
  bool _isFetchingMore = false;
  List<BookModel> _books = [];
  BookQueryParams? _currentQuery;

  bool get isFetchingMore => _isFetchingMore;
  String? get nextPageUrl => _nextPageUrl;
  String? get previousPageUrl => _prevPageUrl;

  void setQuery({
    BookQueryParams? query,
  }) {
    if (_currentQuery != query) {
      _currentQuery = query;
      fetchBooks(isRefresh: true);
    }
  }

  Future<void> fetchBooks({bool isRefresh = false}) async {
    if (_isFetching) return;

    _isFetching = true;
    _isFetchingMore = false;

    if (!isRefresh && _books.isNotEmpty) _isFetchingMore = true;

    if (isRefresh) {
      _books = [];
      _nextPageUrl = null;
      _prevPageUrl = null;
      state = const AsyncLoading();
    } else if (_books.isNotEmpty) {
      _isFetchingMore = true;
      state = AsyncData([..._books]);
    }

    try {
      final BookResponseModel bookResponseModel =
          await _service.fetchBooks(query: _currentQuery);
      _nextPageUrl = bookResponseModel.next;
      _prevPageUrl = bookResponseModel.previous;

      final List<BookModel> newBooks = bookResponseModel.results;

      if (newBooks.isEmpty) {
        _books = [...newBooks];
      } else {
        _books.addAll(newBooks);
      }

      state = AsyncData([..._books]);
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isFetching = false;
      _isFetchingMore = false;
    }
  }

  Future<void> fetchNextPage() async {
    if (_isFetching || _nextPageUrl == null) return;

    _isFetching = true;
    _isFetchingMore = true;
    state = AsyncData([..._books]);

    try {
      final BookResponseModel response =
          await _service.fetchBooksByUrl(_nextPageUrl!);

      _nextPageUrl = response.next;
      _prevPageUrl = response.previous;

      _books.addAll(response.results);
      state = AsyncData([..._books]);
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _isFetching = false;
      _isFetchingMore = false;
    }
  }
}
