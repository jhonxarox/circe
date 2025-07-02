// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookResponseModel _$BookResponseModelFromJson(Map<String, dynamic> json) {
  return _BookResponseModel.fromJson(json);
}

/// @nodoc
mixin _$BookResponseModel {
  int get count => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  String? get previous => throw _privateConstructorUsedError;
  List<BookModel> get results => throw _privateConstructorUsedError;

  /// Serializes this BookResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookResponseModelCopyWith<BookResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookResponseModelCopyWith<$Res> {
  factory $BookResponseModelCopyWith(
          BookResponseModel value, $Res Function(BookResponseModel) then) =
      _$BookResponseModelCopyWithImpl<$Res, BookResponseModel>;
  @useResult
  $Res call(
      {int count, String? next, String? previous, List<BookModel> results});
}

/// @nodoc
class _$BookResponseModelCopyWithImpl<$Res, $Val extends BookResponseModel>
    implements $BookResponseModelCopyWith<$Res> {
  _$BookResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookResponseModelImplCopyWith<$Res>
    implements $BookResponseModelCopyWith<$Res> {
  factory _$$BookResponseModelImplCopyWith(_$BookResponseModelImpl value,
          $Res Function(_$BookResponseModelImpl) then) =
      __$$BookResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int count, String? next, String? previous, List<BookModel> results});
}

/// @nodoc
class __$$BookResponseModelImplCopyWithImpl<$Res>
    extends _$BookResponseModelCopyWithImpl<$Res, _$BookResponseModelImpl>
    implements _$$BookResponseModelImplCopyWith<$Res> {
  __$$BookResponseModelImplCopyWithImpl(_$BookResponseModelImpl _value,
      $Res Function(_$BookResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? next = freezed,
    Object? previous = freezed,
    Object? results = null,
  }) {
    return _then(_$BookResponseModelImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      previous: freezed == previous
          ? _value.previous
          : previous // ignore: cast_nullable_to_non_nullable
              as String?,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<BookModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookResponseModelImpl implements _BookResponseModel {
  const _$BookResponseModelImpl(
      {required this.count,
      this.next,
      this.previous,
      required final List<BookModel> results})
      : _results = results;

  factory _$BookResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookResponseModelImplFromJson(json);

  @override
  final int count;
  @override
  final String? next;
  @override
  final String? previous;
  final List<BookModel> _results;
  @override
  List<BookModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'BookResponseModel(count: $count, next: $next, previous: $previous, results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookResponseModelImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.previous, previous) ||
                other.previous == previous) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, count, next, previous,
      const DeepCollectionEquality().hash(_results));

  /// Create a copy of BookResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookResponseModelImplCopyWith<_$BookResponseModelImpl> get copyWith =>
      __$$BookResponseModelImplCopyWithImpl<_$BookResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookResponseModelImplToJson(
      this,
    );
  }
}

abstract class _BookResponseModel implements BookResponseModel {
  const factory _BookResponseModel(
      {required final int count,
      final String? next,
      final String? previous,
      required final List<BookModel> results}) = _$BookResponseModelImpl;

  factory _BookResponseModel.fromJson(Map<String, dynamic> json) =
      _$BookResponseModelImpl.fromJson;

  @override
  int get count;
  @override
  String? get next;
  @override
  String? get previous;
  @override
  List<BookModel> get results;

  /// Create a copy of BookResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookResponseModelImplCopyWith<_$BookResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
