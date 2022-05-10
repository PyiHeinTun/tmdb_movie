// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genere_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenereResponse _$GenereResponseFromJson(Map<String, dynamic> json) =>
    GenereResponse(
      genereList: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenereVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GenereResponseToJson(GenereResponse instance) =>
    <String, dynamic>{
      'genres': instance.genereList,
    };
