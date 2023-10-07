import 'package:danbi_task/feature/community/model/comment_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'id')
  final int? postId;
  @JsonKey(name: 'userId')
  final int? userId;
  @JsonKey(name: 'body')
  final String body;
  final List<CommentModel>? comments;

  PostModel({
    required this.title,
    this.userId,
    required this.body,
    this.postId,
    this.comments,
  });

  PostModel copyWith({
    String? title,
    int? postId,
    int? userId,
    String? body,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      title: title ?? this.title,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      body: body ?? this.body,
      comments: comments ?? this.comments,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
