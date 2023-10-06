import 'package:danbi_task/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textColorProvider = StateNotifierProvider<ColorProvider, Color>((ref) {
  return ColorProvider();
});

final buttonColorProvider =
    StateNotifierProvider<ButtonColorProvider, Color>((ref) {
  return ButtonColorProvider();
});

class ColorProvider extends StateNotifier<Color> {
  ColorProvider() : super(Colors.grey[300]!);

  void changeButtonColor(GlobalKey<FormState> formKey, String email) {
    formKey.currentState == null ||
            !formKey.currentState!.validate() ||
            email == ''
        ? state = Colors.grey[300]!
        : state = Colors.black;
  }
}

class ButtonColorProvider extends StateNotifier<Color> {
  ButtonColorProvider() : super(Colors.grey[400]!);

  void changeButtonColor2(GlobalKey<FormState> formKey, String email) {
    formKey.currentState == null ||
            !formKey.currentState!.validate() ||
            email == ''
        ? state = Colors.grey[400]!
        : state = primaryColor;
  }
}
