import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:danbi_task/feature/community/component/debounce_call.dart';
import 'package:danbi_task/feature/community/provider/post_provider.dart';
import 'package:danbi_task/feature/community/writing/component/post_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WritingPage extends ConsumerStatefulWidget {
  const WritingPage({super.key});

  @override
  ConsumerState<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends ConsumerState<WritingPage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: '글쓰기',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0,
        ),
        child: Column(
          children: [
            PostTextFiled(
              controller: _titleController,
              labelText: '제목',
              hintText: '제목을 입력해주세요',
              maxLength: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            PostTextFiled(
              controller: _bodyController,
              labelText: '내용',
              hintText: '내용을 입력해주세요',
              maxLength: 15,
            ),
            TextButton(
              onPressed: () => DebouncedCall.processSync(
                  () => ref.read(postStateProvider.notifier).createPost(
                        _titleController.text,
                        _bodyController.text,
                        context,
                      ),
                  hashCode),
              child: const Text('글쓰기'),
            )
          ],
        ),
      ),
    );
  }
}
