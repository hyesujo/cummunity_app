import 'package:danbi_task/common/const/const.dart';
import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final double width;
  final Color backgroundColor;
  final Color textColor;

  const BasicButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ).copyWith(
          overlayColor: MaterialStateProperty.all(
            primaryColor.withOpacity(0.5),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
