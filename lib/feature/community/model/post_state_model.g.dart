// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostStateModel _$PostStateModelFromJson(Map<String, dynamic> json) =>
    PostStateModel(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isLoading: json['isLoading'] as bool,
      isError: json['isError'] as bool,
    );

Map<String, dynamic> _$PostStateModelToJson(PostStateModel instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'isLoading': instance.isLoading,
      'isError': instance.isError,
    };
