import 'dart:async';

import 'package:danbi_task/common/exception/exception.dart';
import 'package:danbi_task/feature/community/model/comment_model.dart';
import 'package:danbi_task/feature/community/model/post_state_model.dart';
import 'package:danbi_task/feature/community/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postStateProvider =
    StateNotifierProvider<PostProviderNotifier, PostStateModel>((ref) {
  final repository = ref.watch(postProvider);
  final notifier = PostProviderNotifier(
    postRepository: repository,
  );
  return notifier;
});

class PostProviderNotifier extends StateNotifier<PostStateModel> {
  final PostRepository postRepository;

  PostProviderNotifier({
    required this.postRepository,
  }) : super(PostStateModel.initial()) {
    posts();
  }

  void posts() async {
    try {
      state = state.copyWith(isLoading: true);
      final posts = await postRepository.getPosts();
      state = state.copyWith(
        posts: posts,
        isLoading: false,
      );

      for (final post in posts) {
        final comments = await getComments(post.postId!);
        state = state.copyWith(
          posts: state.posts.map((e) {
            if (e.postId == post.postId) {
              return e.copyWith(
                comments: comments,
              );
            }
            return e;
          }).toList(),
        );
      }
    } on NoResponse {
      throw '서버 에러 발생';
    } catch (e) {
      SnackBar(
        content: Text(
          e.toString(),
        ),
      );
    }
  }

  void createPost({
    required String title,
    required String body,
    required BuildContext context,
  }) async {
    try {
      Map<String, dynamic> requestBody = {
        'title': title,
        'body': body,
      };
      final result = await postRepository.createPost(requestBody);

      state = state.copyWith(
        posts: [result, ...state.posts],
      );
      if (!mounted) return;
      Navigator.pop(context);
    } on NoResponse {
      throw '서버 에러 발생';
    } catch (e) {
      SnackBar(
        content: Text(
          e.toString(),
        ),
      );
    }
  }

  void deletePost(int id, BuildContext context) async {
    try {
      await postRepository.deletePost(postId: id);
      state = state.copyWith(
        posts: state.posts.where((element) => element.postId != id).toList(),
      );

      if (!mounted) return;
      Navigator.pop(context);
    } on NoResponse {
      throw '서버 에러 발생';
    } catch (e) {
      SnackBar(
        content: Text(
          e.toString(),
        ),
      );
    }
  }

  Future<List<CommentModel>> getComments(final int postId) async {
    try {
      final result = await postRepository.getComments(postId: postId);
      return result;
    } on NoResponse {
      throw '서버 에러 발생';
    } catch (e) {
      SnackBar(
        content: Text(
          e.toString(),
        ),
      );
      return [];
    }
  }
}
