// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_person_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularPersonResponse _$PopularPersonResponseFromJson(
        Map<String, dynamic> json) =>
    PopularPersonResponse(
      personList: (json['results'] as List<dynamic>?)
          ?.map((e) => PersonVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PopularPersonResponseToJson(
        PopularPersonResponse instance) =>
    <String, dynamic>{
      'results': instance.personList,
    };
