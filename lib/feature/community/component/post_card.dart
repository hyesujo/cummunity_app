import 'package:danbi_task/common/const/const.dart';
import 'package:danbi_task/feature/community/model/comment_model.dart';
import 'package:danbi_task/feature/community/model/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String body;
  final List<CommentModel> comments;
  const PostCard({
    super.key,
    required this.title,
    required this.body,
    required this.comments,
  });

  factory PostCard.fromModel({
    required PostModel model,
    bool isDetail = false,
  }) {
    return PostCard(
      title: model.title,
      body: model.body,
      comments: model.comments ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '제목',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('댓글 수'),
                Text(
                  comments.length.toString(),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
