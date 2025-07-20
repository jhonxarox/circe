import 'package:circe/data/datasources/book_api_service.dart';
import 'package:circe/data/models/book_model.dart';
import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/data/models/book_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksByTopicViewmodel extends StateNotifier<AsyncValue<List<BookModel>>> {
  final BookApiService _service = BookApiService();

  BooksByTopicViewmodel(String topic) : super(const AsyncLoading()) {
    _fetchBooksByTopic(topic);
  }

  Future<void> _fetchBooksByTopic(String topic) async {
    try {
      final BookResponseModel books = await _service.fetchBooks(
        query: BookQueryParams(
          topic: topic,
        ),
      );
      state = AsyncData(books.results);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
