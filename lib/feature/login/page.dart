import 'package:danbi_task/common/component/text_form_field.dart';
import 'package:danbi_task/common/const/data.dart';
import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:danbi_task/common/sequre_storage/secure_sotrage.dart';
import 'package:danbi_task/feature/community/page.dart';
import 'package:danbi_task/feature/login/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String userEmail = '';

    return DefaultScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    return CustomTextFormField(
                      formKey: formKey,
                      hintText: '이메일을 입력해주세요',
                      onChanged: onChanged(ref, userEmail, formKey),
                    );
                  },
                ),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final textColor = ref.watch(textColorProvider);
                  final buttonColor = ref.watch(buttonColorProvider);
                  return ElevatedButton(
                    onPressed: () =>
                        onButtonTab(formKey, ref, userEmail, context),
                    style: TextButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void Function(String) onChanged(
      WidgetRef ref, String userEmail, GlobalKey<FormState> formKey) {
    return (value) {
      userEmail = value;
      ref.read(textColorProvider.notifier).changeButtonColor(formKey, value);
      ref.read(buttonColorProvider.notifier).changeButtonColor2(formKey, value);
    };
  }

  void onButtonTab(GlobalKey<FormState> formKey, WidgetRef ref,
      String userEmail, BuildContext context) async {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }
    final storage = ref.watch(sequreStorageProvider);
    await storage.write(
      key: emailKey,
      value: userEmail,
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const CummunityPage(),
      ),
      (route) => false,
    );
  }
}
