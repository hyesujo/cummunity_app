import 'package:danbi_task/common/const/const.dart';
import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:danbi_task/feature/community/component/post_card.dart';
import 'package:danbi_task/feature/community/detail/page.dart';
import 'package:danbi_task/feature/community/model/post_model.dart';
import 'package:danbi_task/feature/community/provider/post_provider.dart';
import 'package:danbi_task/feature/community/writing/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CummunityPage extends ConsumerWidget {
  const CummunityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(postStateProvider);

    return DefaultScaffold(
      title: '커뮤니티',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: data.isEmpty
            ? const Text(
                '데이터가 없어요',
              )
            : Stack(children: [
                _PostList(
                  context: context,
                  posts: data,
                ),
                _writeButton(context),
              ]),
      ),
    );
  }

  Positioned _writeButton(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 0,
      child: SizedBox(
        height: 50.0,
        width: MediaQuery.of(context).size.width * 0.3,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const WritingPage(),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            backgroundColor: bodyTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ).copyWith(
            overlayColor: MaterialStateProperty.all(
              primaryColor.withOpacity(0.5),
            ),
          ),
          child: const Text(
            '글쓰기',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PostDetailPage(
                    post: posts[index],
                  ),
                ),
              );
            },
            behavior: HitTestBehavior.opaque,
            child: PostCard.fromModel(
              model: posts[index],
            ),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 10,
          );
        });
  }
}
