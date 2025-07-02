import 'package:circe/data/models/book_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_response_model.freezed.dart';
part 'book_response_model.g.dart';

@freezed
class BookResponseModel with _$BookResponseModel {
  const factory BookResponseModel({
    required int count,
    String? next,
    String? previous,
    required List<BookModel> results,
  }) = _BookResponseModel;

  factory BookResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BookResponseModelFromJson(json);
}
