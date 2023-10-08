import 'package:danbi_task/common/component/loading_page.dart';
import 'package:danbi_task/common/const/data.dart';
import 'package:danbi_task/common/sequre_storage/secure_sotrage.dart';
import 'package:danbi_task/feature/community/page.dart';
import 'package:danbi_task/feature/login/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();

    checkEmail();
  }

  void checkEmail() async {
    final storage = ref.read(sequreStorageProvider);

    final hasEmail = await storage.read(key: emailKey);

    if (hasEmail != null) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const CummunityPage(),
            ),
            (route) => false);
      }
    } else {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const LoginPage(),
            ),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingPage();
  }
}
