import 'package:danbi_task/common/layout/default_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/loading.svg',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
