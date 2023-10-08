import 'package:danbi_task/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postButtonColorProvider =
    StateNotifierProvider.autoDispose<PostButtonProvider, Color>((ref) {
  return PostButtonProvider();
});

class PostButtonProvider extends StateNotifier<Color> {
  PostButtonProvider() : super(Colors.grey[300]!);

  void changeButtonColor(final String title, final String body) {
    title.isEmpty || body.isEmpty
        ? state = Colors.grey[300]!
        : state = bodyTextColor;
  }
}
