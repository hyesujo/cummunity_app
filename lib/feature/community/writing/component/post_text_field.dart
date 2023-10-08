import 'package:danbi_task/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(String text)? onChanged;
  final String labelText;
  final String? hintText;
  final String? extraText;
  final int? maxLength;
  final bool autofocus;
  final Widget? suffixIcon;
  final TextSelectionControls? selectionControls;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool showClearButton;

  const PostTextFiled({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    required this.labelText,
    this.maxLength,
    this.hintText,
    this.extraText,
    this.autofocus = false,
    this.suffixIcon,
    this.selectionControls,
    this.keyboardType,
    this.inputFormatters,
    this.showClearButton = false,
  }) : assert(suffixIcon != null ? !showClearButton : true);

  @override
  State<PostTextFiled> createState() => _PostTextFiledState();
}

class _PostTextFiledState extends State<PostTextFiled> {
  TextStyle get textStyle => const TextStyle(fontSize: 16.0);
  Color get _disabledColor => const Color(0xff5a5a5a);

  late final ValueNotifier _isStringEmpty =
      ValueNotifier(widget.controller.text.isEmpty);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            height: 58.0,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.5),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(6.0),
              ),
            ),
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 10.0,
                  left: 12.0,
                  child: Text(
                    widget.labelText,
                    style: const TextStyle(color: primaryColor),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextField(
                            controller: widget.controller,
                            focusNode: widget.focusNode,
                            onChanged: _onChanged,
                            cursorWidth: 1.0,
                            cursorHeight: 18.0,
                            cursorColor: Colors.white,
                            style: textStyle.copyWith(
                              color: _disabledColor,
                            ),
                            expands: false,
                            maxLines: 1,
                            keyboardType: widget.keyboardType,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              hintText: widget.hintText,
                              hintStyle: textStyle.copyWith(
                                color: bodyTextColor.withOpacity(0.3),
                              ),
                            ),
                            inputFormatters: [
                              if (widget.inputFormatters != null)
                                ...widget.inputFormatters!,
                              if (widget.maxLength != null)
                                LengthLimitingTextInputFormatter(
                                  widget.maxLength,
                                ),
                            ],
                            autofocus: widget.autofocus,
                            enableSuggestions: false,
                            autocorrect: false,
                            selectionControls: widget.selectionControls ??
                                EmptyTextSelectionControls(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 1.0,
                    color: bodyTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  void Function(String)? get _onChanged => (text) {
        _isStringEmpty.value = text.isEmpty;
        widget.onChanged?.call(text);
      };
}
