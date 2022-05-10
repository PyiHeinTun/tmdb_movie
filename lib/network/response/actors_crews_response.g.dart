// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actors_crews_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActorsCrewsResponse _$ActorsCrewsResponseFromJson(Map<String, dynamic> json) =>
    ActorsCrewsResponse(
      actors: (json['cast'] as List<dynamic>?)
          ?.map((e) => PersonVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      crews: (json['crew'] as List<dynamic>?)
          ?.map((e) => PersonVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActorsCrewsResponseToJson(
        ActorsCrewsResponse instance) =>
    <String, dynamic>{
      'cast': instance.actors,
      'crew': instance.crews,
    };
