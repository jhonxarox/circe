import 'package:circe/core/constants.dart';

class BookQueryParams {
  int? authorYearStart;
  int? authorYearEnd;
  List<bool>? copyright;
  List<int>? ids;
  List<String>? languages;
  String? mimeType;
  String? search;
  String? sort;
  String? topic;

  BookQueryParams({
    this.authorYearStart,
    this.authorYearEnd,
    this.copyright,
    this.ids,
    this.languages,
    this.mimeType,
    this.search,
    this.sort,
    this.topic,
  });

  Map<String, dynamic> toMap() {
    return {
      if (authorYearStart != null)
        ApiConstants.authorYearStartParameter: authorYearStart,
      if (authorYearEnd != null)
        ApiConstants.authorYearEndParameter: authorYearEnd,
      if (copyright != null) ApiConstants.copyrightParameter: copyright,
      if (ids != null) ApiConstants.idsParameter: ids,
      if (languages != null) ApiConstants.languagesParameter: languages,
      if (mimeType != null) ApiConstants.mimeTypeParameter: mimeType,
      if (search != null) ApiConstants.searchParameter: search,
      if (sort != null) ApiConstants.sortingParameter: sort,
      if (topic != null) ApiConstants.topicParameter: topic,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookQueryParams &&
        other.authorYearStart == authorYearStart &&
        other.authorYearEnd == authorYearEnd &&
        _listEquals(other.copyright, copyright) &&
        _listEquals(other.ids, ids) &&
        _listEquals(other.languages, languages) &&
        other.mimeType == mimeType &&
        other.search == search &&
        other.sort == sort &&
        other.topic == topic;
  }

  @override
  int get hashCode {
    return Object.hash(
      authorYearStart,
      authorYearEnd,
      _listHash(copyright),
      _listHash(ids),
      _listHash(languages),
      mimeType,
      search,
      sort,
      topic,
    );
  }
}

// Utility for deep list equality
bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null && b == null) return true;
  if (a == null || b == null || a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

// Utility for list hash code generation
int _listHash<T>(List<T>? list) {
  if (list == null) return 0;
  return list.fold(0, (hash, item) => hash ^ item.hashCode);
}
