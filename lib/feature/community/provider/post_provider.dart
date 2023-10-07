import 'dart:async';

import 'package:danbi_task/feature/community/model/comment_model.dart';
import 'package:danbi_task/feature/community/model/post_model.dart';
import 'package:danbi_task/feature/community/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postStateProvider =
    StateNotifierProvider<PostProviderNotifier, List<PostModel>>((ref) {
  final repository = ref.watch(postProvider);
  final notifier = PostProviderNotifier(postRepository: repository);
  return notifier;
});

class PostProviderNotifier extends StateNotifier<List<PostModel>> {
  final PostRepository postRepository;

  PostProviderNotifier({required this.postRepository}) : super([]) {
    posts();
  }

  void posts() async {
    try {
      final posts = await postRepository.getPosts();

      state = posts;
      for (final post in posts) {
        final comments = await getComments(post.postId!);
        state = state.map((e) {
          if (e.postId == post.postId) {
            return e.copyWith(
              comments: comments,
            );
          }
          return e;
        }).toList();
      }
    } catch (e) {
      SnackBar(
        content: Text(
          e.toString(),
        ),
      );
      state = [];
    }
  }

  Future<List<CommentModel>> getComments(final int postId) async {
    final result = await postRepository.getComments(postId: postId);
    return result;
  }
}
