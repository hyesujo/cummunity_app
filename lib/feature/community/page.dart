import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:danbi_task/feature/community/model/post_model.dart';
import 'package:danbi_task/feature/community/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CummunityPage extends ConsumerWidget {
  const CummunityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(postStateProvider);

    if (data.isEmpty) {
      return const DefaultScaffold(
        child: Text(
          '데이터가 없어요',
        ),
      );
    }
    return DefaultScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: _PostList(
          context: context,
          posts: data,
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  final BuildContext context;
  final List<PostModel> posts;
  const _PostList({
    super.key,
    required this.context,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: posts.length,
        itemBuilder: (_, index) {
          return Column(
            children: [
              Text(
                posts[index].title,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('댓글 수'),
                  Text(
                    posts[index].comments == null
                        ? 0.toString()
                        : posts[index].comments!.length.toString(),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (_, index) {
          return const Divider();
        });
  }
}
