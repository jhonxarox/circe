import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    required int id,
    required String title,
    @Default([]) List<Author> authors,
    @Default([]) List<String> summaries,
    @Default([]) List<String> subjects,
    @Default([]) List<String> languages,
    required Map<String, dynamic> formats,
    @JsonKey(name: 'download_count') required int downloadCount,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

@freezed
class Author with _$Author {
  const factory Author({
    required String name,
    @JsonKey(name: 'birth_year') int? birthYear,
    @JsonKey(name: 'death_year') int? deathYear,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}

extension BookModelX on BookModel {
  /// Get first summary if available
  String? get summary => summaries.isNotEmpty ? summaries.first : null;

  /// Extract author names
  List<String> get authorNames => authors.map((a) => a.name).toList();

  /// Get book cover image URL
  String? get imageUrl => formats['image/jpeg'] as String?;

  /// Get All author names as a single string
  String get authorNamesString {
    return authors.map((a) => a.name).join(', ');
  }
}

// This model represents a book with its details, including authors and formats.
// The `BookModel` class is annotated with `@freezed` to generate immutable data
// classes and JSON serialization methods.
