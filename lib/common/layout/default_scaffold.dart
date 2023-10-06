import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;
  const DefaultScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: _buildAppBar(context),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.black,
            ),
      ),
      centerTitle: true,
    );
  }
}
