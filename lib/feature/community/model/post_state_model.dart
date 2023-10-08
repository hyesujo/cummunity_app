import 'package:danbi_task/feature/community/model/post_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_state_model.g.dart';

@JsonSerializable()
class PostStateModel {
  final List<PostModel> posts;
  final bool isLoading;
  final bool isError;

  PostStateModel({
    required this.posts,
    required this.isLoading,
    required this.isError,
  });

  PostStateModel copyWith({
    List<PostModel>? posts,
    bool? isLoading,
    bool? isError,
  }) {
    return PostStateModel(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  factory PostStateModel.initial() {
    return PostStateModel(
      posts: [],
      isLoading: false,
      isError: false,
    );
  }

  factory PostStateModel.fromJson(Map<String, dynamic> json) =>
      _$PostStateModelFromJson(json);
}
