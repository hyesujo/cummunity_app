import 'package:danbi_task/common/const/const.dart';
import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:danbi_task/feature/community/component/basic_button.dart';
import 'package:danbi_task/feature/community/component/debounce_call.dart';
import 'package:danbi_task/feature/community/model/post_model.dart';
import 'package:danbi_task/feature/community/provider/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailPage extends StatelessWidget {
  final PostModel post;
  const PostDetailPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: '게시글 상세',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _postTitle(),
              _userName(),
              const SizedBox(
                height: 30,
              ),
              _postBody(),
              const SizedBox(
                height: 30,
              ),
              _comments(),
              if (post.userId == null)
                Consumer(
                  builder: (context, ref, child) {
                    return BasicButton(
                      onPressed: () => DebouncedCall.processSync(
                          () => ref.read(postStateProvider.notifier).deletePost(
                                post.postId!,
                                context,
                              ),
                          hashCode),
                      text: '삭제하기',
                      width: double.infinity,
                      backgroundColor: bodyTextColor,
                      textColor: Colors.white,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _comments() {
    return post.comments != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '댓글 목록',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: post.comments!.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    right: 5,
                                  ),
                                  child: Text(
                                    '작성자 명',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    post.comments![index].name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            post.comments![index].body,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider();
                  })
            ],
          )
        : Container();
  }

  Widget _postTitle() {
    return Text(
      post.title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _userName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('작성자'),
        Padding(
          padding: const EdgeInsets.only(
            left: 5,
          ),
          child: post.userId == null
              ? const Text('나')
              : Text(
                  post.userId.toString(),
                ),
        ),
      ],
    );
  }

  Widget _postBody() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Text(
          post.body,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
