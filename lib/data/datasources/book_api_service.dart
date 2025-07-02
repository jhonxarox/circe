import 'package:circe/core/constants.dart';
import 'package:circe/data/models/book_query_params.dart';
import 'package:circe/data/models/book_response_model.dart';
import 'package:dio/dio.dart';

class BookApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<BookResponseModel> fetchBooks({
    BookQueryParams? query,
  }) async {
    final Response<dynamic> response = await _dio.get(
      ApiConstants.booksEndpoint,
      queryParameters: {
        if (query?.authorYearStart != null &&
            query?.authorYearStart?.isNaN == false)
          ApiConstants.authorYearStartParameter: query?.authorYearStart,
        if (query?.authorYearEnd != null &&
            query?.authorYearEnd?.isNaN == false)
          ApiConstants.authorYearEndParameter: query?.authorYearEnd,
        if (query?.copyright != null && query!.copyright!.isNotEmpty)
          ApiConstants.copyrightParameter:
              query.copyright?.map((e) => e.toString()).toList(),
        if (query?.ids != null && query!.ids!.isNotEmpty)
          ApiConstants.idsParameter: query.ids?.join(','),
        if (query?.languages != null && query!.languages!.isNotEmpty)
          ApiConstants.languagesParameter: query.languages?.join(','),
        if (query?.mimeType != null && query!.mimeType!.isNotEmpty)
          ApiConstants.mimeTypeParameter: query.mimeType,
        if (query?.search != null && query!.search!.isNotEmpty)
          ApiConstants.searchParameter: query.search,
        if (query?.sort != null && query!.sort!.isNotEmpty)
          ApiConstants.sortingParameter: query.sort,
        if (query?.topic != null && query!.topic!.isNotEmpty)
          ApiConstants.topicParameter: query.topic,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load books');
    }

    return BookResponseModel.fromJson(response.data);
  }

  Future<BookResponseModel> fetchBooksByUrl(String url) async {
    final Response<dynamic> response = await _dio.getUri(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load books by URL');
    }
    return BookResponseModel.fromJson(response.data);
  }
}
