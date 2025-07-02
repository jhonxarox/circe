class ApiConstants {
  static const String baseUrl = 'https://gutendex.com';
  static const String booksEndpoint = '/books';
  static const String authorYearStartParameter = 'author_year_start';
  static const String authorYearEndParameter = 'author_year_end';
  static const String copyrightParameter = 'copyright';
  static const String idsParameter = 'ids';
  static const String languagesParameter = 'languages';
  static const String mimeTypeParameter = 'mime_type';
  static const String searchParameter = 'search';
  static const String sortingParameter = 'sort';
  static const String topicParameter = 'topic';
}

class SharedPreferencesKeys {
  static const String savedBookIds = 'saved_book_ids';
}
