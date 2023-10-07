// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      postId: json['postId'] as int,
      userId: json['id'] as int,
      name: json['name'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'id': instance.userId,
      'name': instance.name,
      'body': instance.body,
    };
