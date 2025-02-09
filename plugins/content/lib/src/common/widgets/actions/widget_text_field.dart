import 'package:flutter/material.dart';

/// A general text input field display widget with input validation.
///
class GsaWidgetTextField extends StatefulWidget {
  // ignore: public_member_api_docs
  const GsaWidgetTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled,
    this.autofocus,
    this.obscureText,
    this.keyboardType,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.minLines = 1,
    this.maxLines = 1,
    this.onSubmitted,
    this.validator,
    this.padding,
    this.displayDeleteButton = true,
    this.onFocusChange,
    this.onControllerChanged,
    this.onControllerCleared,
    this.onTap,
    this.fontSize,
    this.highlightColor,
    this.backgroundColor,
    this.textInputAction,
    this.errorStyle,
    this.circularCorners = false,
  }) : assert(
          obscureText == null || obscureText && suffixIcon == null,
          prefix == null || suffixIcon == null,
        );

  /// The default controller for this text field.
  ///
  final TextEditingController? controller;

  /// The default focus node for this text field.
  ///
  final FocusNode? focusNode;

  /// Whether input editing is enabled.
  ///
  final bool? enabled;

  /// If set to true, the text field will be automatically focused upon initialization.
  ///
  final bool? autofocus;

  /// Should the text input be visually obscured.
  ///
  final bool? obscureText;

  /// The type of text field input.
  ///
  final TextInputType? keyboardType;

  /// Decoration prefix and suffix elements.
  ///
  final Widget? prefix, suffix, prefixIcon, suffixIcon;

  /// User-facing description labels.
  ///
  final String? hintText, labelText;

  /// Min and max lines this field is allowed to expand to.
  ///
  final int minLines, maxLines;

  /// Event triggered on keyboard "enter" key / confirmation.
  ///
  final Function(String)? onSubmitted;

  /// Optional input validation method.
  ///
  final String? Function(String?)? validator;

  /// Padding surrounding the visual elements.
  ///
  final EdgeInsets? padding;

  /// Whether to automatically display the delete "x" button.
  ///
  final bool displayDeleteButton;

  /// Events triggered on focus and controller changes.
  ///
  final Function()? onFocusChange, onControllerChanged;

  /// Invoked on text deletion by the "delete button" applied with [displayDeleteButton].
  ///
  final Function? onControllerCleared;

  /// Event triggered on text input field tap.
  ///
  final Function? onTap;

  /// Font size applied to the input field.
  ///
  final double? fontSize;

  /// Input field decoration colors.
  ///
  final Color? highlightColor, backgroundColor;

  /// An action the user has requested the text input control to perform.
  ///
  final TextInputAction? textInputAction;

  /// [TextStyle] applied to the validator error message text.
  ///
  final TextStyle? errorStyle;

  /// Whether the text input field is displayed with circular corners.
  ///
  final bool circularCorners;

  @override
  State<GsaWidgetTextField> createState() => _GsaWidgetTextFieldState();
}

class _GsaWidgetTextFieldState extends State<GsaWidgetTextField> {
  Future<void> _onTextControllerUpdate() async {
    if (widget.onControllerChanged != null) await widget.onControllerChanged!();
    if (mounted) setState(() {});
  }

  late FocusNode _focusNode;

  Future<void> _onFocusNodeUpdate() async {
    if (widget.onFocusChange != null) await widget.onFocusChange!();
    if (mounted) setState(() {});
  }

  late bool _obscureText;

  late BorderRadius _borderRadius;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onTextControllerUpdate);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusNodeUpdate);
    _obscureText = widget.obscureText ?? false;
    _borderRadius = BorderRadius.circular(widget.circularCorners ? 100 : 12);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      autofocus: widget.autofocus ?? false,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor ??
            (_focusNode.hasFocus || widget.controller != null && widget.controller!.text.isNotEmpty
                ? Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : const Color(0xff404040)
                : Theme.of(context).brightness == Brightness.light
                    ? const Color(0xffF0F3F5)
                    : const Color(0xffb3b3b3)),
        isDense: true,
        contentPadding: widget.padding ?? const EdgeInsets.fromLTRB(20, 16, 20, 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            color: widget.highlightColor ?? Theme.of(context).primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: widget.highlightColor != null
              ? BorderSide(color: widget.highlightColor!)
              : _focusNode.hasFocus || widget.controller != null && widget.controller!.text.isNotEmpty
                  ? const BorderSide(
                      color: Color(0xffE2E5EB),
                    )
                  : BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: widget.highlightColor != null
              ? BorderSide(color: widget.highlightColor!)
              : widget.controller == null || widget.controller!.text.isEmpty
                  ? BorderSide.none
                  : const BorderSide(
                      color: Color(0xffADBDC6),
                    ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(
            color: Color(0xffDE1E36),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: const BorderSide(
            color: Color(0xffDE1E36),
          ),
        ),
        prefixIcon: widget.prefixIcon != null
            ? SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: widget.prefixIcon!,
                ),
              )
            : null,
        suffix: widget.suffix,
        suffixIcon:
            widget.obscureText == true || _focusNode.hasFocus && widget.controller?.text.isNotEmpty == true && widget.displayDeleteButton
                ? IconButton(
                    icon: Icon(
                      widget.obscureText == true ? Icons.visibility : Icons.close,
                      color: widget.highlightColor ?? (_obscureText ? const Color(0xff63747E) : Theme.of(context).primaryColor),
                    ),
                    iconSize: 18,
                    onPressed: widget.obscureText == true
                        ? () => setState(() => _obscureText = !_obscureText)
                        : () async {
                            if (widget.onControllerCleared != null) {
                              await widget.onControllerCleared!();
                            }
                            setState(() => widget.controller!.clear());
                          },
                  )
                : widget.suffixIcon != null
                    ? SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: widget.suffixIcon!,
                        ),
                      )
                    : null,
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontWeight: _focusNode.hasFocus || widget.controller?.text.isNotEmpty == true ? FontWeight.w600 : FontWeight.w400,
          color: _focusNode.hasFocus || widget.controller?.text.isNotEmpty == true ? const Color(0xff283033) : const Color(0xff63747E),
        ),
        errorStyle: widget.errorStyle ??
            const TextStyle(
              color: Color(0xffDE1E36),
              fontSize: 10,
            ),
        errorMaxLines: 2,
        helperStyle: const TextStyle(
          color: Color(0xff63747E),
          fontSize: 10,
        ),
        hintStyle: const TextStyle(
          color: Color(0xff63747E),
        ),
      ),
      style: TextStyle(
        color: const Color(0xff63747E),
        fontSize: widget.fontSize ?? 12,
      ),
      autocorrect: false,
      enableSuggestions: false,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap != null ? () => widget.onTap!() : null,
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextControllerUpdate);
    _focusNode.removeListener(_onFocusNodeUpdate);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }
}
