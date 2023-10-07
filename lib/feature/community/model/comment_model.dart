import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: "postId")
  final int postId;
  @JsonKey(name: "id")
  final int userId;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "body")
  final String body;

  CommentModel({
    required this.postId,
    required this.userId,
    required this.name,
    required this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
