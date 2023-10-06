import 'package:danbi_task/common/const/const.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final bool autocFocus;
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    super.key,
    required this.formKey,
    required this.onChanged,
    this.obscureText = false,
    this.autocFocus = false,
    this.hintText,
  });

  OutlineInputBorder get baseBorder => const OutlineInputBorder(
        borderSide: BorderSide(
          color: inputBorderColor,
          width: 1.0,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        validator: validateEmail,
        cursorColor: primaryColor,
        autofocus: autocFocus,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(
            20.0,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: bodyTextColor,
            fontSize: 14.0,
          ),
          filled: true,
          border: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? '이메일 형식으로 입력해주세요'
        : null;
  }
}
