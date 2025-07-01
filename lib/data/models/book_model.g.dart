// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      summaries: (json['summaries'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      subjects: (json['subjects'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      formats: json['formats'] as Map<String, dynamic>,
      downloadCount: (json['download_count'] as num).toInt(),
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors,
      'summaries': instance.summaries,
      'subjects': instance.subjects,
      'languages': instance.languages,
      'formats': instance.formats,
      'download_count': instance.downloadCount,
    };

_$AuthorImpl _$$AuthorImplFromJson(Map<String, dynamic> json) => _$AuthorImpl(
      name: json['name'] as String,
      birthYear: (json['birth_year'] as num?)?.toInt(),
      deathYear: (json['death_year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AuthorImplToJson(_$AuthorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };
