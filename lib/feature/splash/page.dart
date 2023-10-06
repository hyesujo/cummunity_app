import 'package:danbi_task/common/const/data.dart';
import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:danbi_task/common/sequre_storage/secure_sotrage.dart';
import 'package:danbi_task/feature/login/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              builder: (_) => const DefaultScaffold(
                child: Text('로그인 되었습니다.'),
              ),
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
    return DefaultScaffold(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/loading.svg',
              width: 160,
              height: 160,
            ),
            const SizedBox(
              height: 16,
            ),
            const CircularProgressIndicator(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
