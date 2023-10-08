import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:danbi_task/feature/community/component/basic_button.dart';
import 'package:danbi_task/feature/community/component/debounce_call.dart';
import 'package:danbi_task/feature/community/provider/post_provider.dart';
import 'package:danbi_task/feature/community/writing/component/post_text_field.dart';
import 'package:danbi_task/feature/community/writing/provider/post_button_provider.dart';
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
    final buttonColor = ref.watch(postButtonColorProvider);
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
                onChanged: (text) => DebouncedCall.processSync(
                      () => ref
                          .read(postButtonColorProvider.notifier)
                          .changeButtonColor(
                            _titleController.text,
                            _bodyController.text,
                          ),
                      hashCode,
                    )),
            const SizedBox(
              height: 10,
            ),
            PostTextFiled(
              controller: _bodyController,
              labelText: '내용',
              hintText: '내용을 입력해주세요',
              maxLength: 15,
              onChanged: (text) => DebouncedCall.processSync(
                () => ref
                    .read(postButtonColorProvider.notifier)
                    .changeButtonColor(
                      _titleController.text,
                      _bodyController.text,
                    ),
                hashCode,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: BasicButton(
                textColor: Colors.white,
                backgroundColor: buttonColor,
                text: '글쓰기',
                width: double.infinity,
                onPressed: _titleController.text.isEmpty ||
                        _bodyController.text.isEmpty
                    ? () {}
                    : () => DebouncedCall.processSync(
                          () => ref.read(postStateProvider.notifier).createPost(
                                title: _titleController.text,
                                body: _bodyController.text,
                                context: context,
                              ),
                          hashCode,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
