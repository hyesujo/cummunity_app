import 'package:danbi_task/common/const/data.dart';
import 'package:danbi_task/feature/community/model/comment_model.dart';
import 'package:danbi_task/feature/community/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart' as retorfit;

part 'post_repository.g.dart';

final postProvider = Provider((ref) {
  final dio = Dio();
  final repository = PostRepository(dio, baseUrl: 'https://$url/posts');
  return repository;
});

@retorfit.RestApi()
abstract class PostRepository {
  factory PostRepository(Dio dio, {String baseUrl}) = _PostRepository;

  @retorfit.GET('/')
  Future<List<PostModel>> getPosts();

  @retorfit.GET('/{id}/comments')
  Future<List<CommentModel>> getComments({@Path('id') required int postId});

  @retorfit.POST('/')
  Future<PostModel> createPost(@Body() Map<String, dynamic> body);

  @retorfit.DELETE('/{id}')
  Future<void> deletePost({@Path('id') required int postId});
}
