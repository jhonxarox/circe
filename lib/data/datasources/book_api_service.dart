import 'package:circe/data/models/book_model.dart';
import 'package:dio/dio.dart';

class BookApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://gutendex.com'));

  Future<List<BookModel>> fetchBooks({
    int page = 1,
    String? query,
  }) async {
    final Response<dynamic> response = await _dio.get(
      '/books',
      queryParameters: {
        'page': page,
        if (query != null && query.isNotEmpty) 'search': query,
      },
    );

    final List<dynamic> data = response.data['results'] as List;
    return data.map((json) => BookModel.fromJson(json)).toList();
  }
}
