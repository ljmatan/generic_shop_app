import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// A general text input field display widget with input validation.
///
class GsaWidgetTextField extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.keyboardType,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.hintText,
    this.minLines = 1,
    this.maxLines = 1,
    this.onSubmitted,
    this.validator,
    this.displayDeleteButton = true,
    this.onFocusChange,
    this.onControllerChanged,
    this.onControllerCleared,
    this.onTap,
    this.textInputAction,
  });

  /// The default controller for this text field.
  ///
  final TextEditingController? controller;

  /// The default focus node for this text field.
  ///
  final FocusNode? focusNode;

  /// Whether input editing is enabled.
  ///
  final bool enabled;

  /// If set to true, the text field will be automatically focused upon initialization.
  ///
  final bool autofocus;

  /// Should the text input be visually obscured.
  ///
  final bool obscureText;

  /// The type of text field input.
  ///
  final TextInputType? keyboardType;

  /// Decoration prefix and suffix elements.
  ///
  final Widget? prefix, suffix, prefixIcon, suffixIcon;

  /// User-facing description labels.
  ///
  final String? labelText, hintText;

  /// Min and max lines this field is allowed to expand to.
  ///
  final int minLines, maxLines;

  /// Event triggered on keyboard "enter" key / confirmation.
  ///
  final Function(String)? onSubmitted;

  /// Optional input validation method.
  ///
  final String? Function(String?)? validator;

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

  /// An action the user has requested the text input control to perform.
  ///
  final TextInputAction? textInputAction;

  /// Theme properties applied to the text input field.
  ///
  /// The reason for the property being stored with global-level access
  /// is due to it's reuse with the [DropdownMenu] widget.
  ///
  static final themeProperties = (
    fillColor: (
      Brightness brightness,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
    ) {
      return focusNode?.hasFocus == true || textEditingController?.text.isNotEmpty == true
          ? brightness == Brightness.light
              ? Colors.white
              : const Color(0xff404040)
          : brightness == Brightness.light
              ? const Color(0xffF0F3F5)
              : const Color(0xffb3b3b3);
    },
    border: (
      FocusNode? focusNode,
      TextEditingController? textEditingController,
    ) {
      return OutlineInputBorder(
        borderRadius: GsaTheme.instance.borderRadius,
        borderSide: focusNode?.hasFocus == true || textEditingController?.text.isNotEmpty == true
            ? const BorderSide(
                color: Color(0xffE2E5EB),
              )
            : BorderSide.none,
      );
    },
    focusedBorder: (
      Color primaryColor,
    ) {
      return OutlineInputBorder(
        borderRadius: GsaTheme.instance.borderRadius,
        borderSide: BorderSide(
          color: primaryColor,
        ),
      );
    },
    enabledBorder: (
      FocusNode? focusNode,
      TextEditingController? textEditingController,
    ) {
      return OutlineInputBorder(
        borderRadius: GsaTheme.instance.borderRadius,
        borderSide: focusNode?.hasFocus == true || textEditingController?.text.isNotEmpty == true
            ? const BorderSide(
                color: Color(0xffE2E5EB),
              )
            : BorderSide.none,
      );
    },
    disabledBorder: (
      TextEditingController? textEditingController,
    ) {
      return OutlineInputBorder(
        borderRadius: GsaTheme.instance.borderRadius,
        borderSide: textEditingController?.text.isNotEmpty != true
            ? BorderSide.none
            : const BorderSide(
                color: Color(0xffADBDC6),
              ),
      );
    },
    errorBorder: () {
      return OutlineInputBorder(
        borderRadius: GsaTheme.instance.borderRadius,
        borderSide: const BorderSide(
          color: Color(0xffDE1E36),
        ),
      );
    },
    focusedErrorBorder: () {
      return OutlineInputBorder(
        borderRadius: GsaTheme.instance.borderRadius,
        borderSide: const BorderSide(
          color: Color(0xffDE1E36),
        ),
      );
    },
    labelStyle: (
      FocusNode? focusNode,
      TextEditingController? textEditingController,
    ) {
      return TextStyle(
        fontWeight: focusNode?.hasFocus == true || textEditingController?.text.isNotEmpty == true ? FontWeight.w600 : FontWeight.w400,
        color: focusNode?.hasFocus == true || textEditingController?.text.isNotEmpty == true
            ? const Color(0xff283033)
            : const Color(0xff63747E),
      );
    },
    textStyle: () {
      return const TextStyle(
        color: Color(0xff63747E),
        fontSize: 12,
      );
    },
  );

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

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onTextControllerUpdate);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusNodeUpdate);
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      textInputAction: widget.textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        fillColor: GsaWidgetTextField.themeProperties.fillColor(
          Theme.of(context).brightness,
          _focusNode,
          widget.controller,
        ),
        border: GsaWidgetTextField.themeProperties.border(
          _focusNode,
          widget.controller,
        ),
        focusedBorder: GsaWidgetTextField.themeProperties.focusedBorder(
          Theme.of(context).primaryColor,
        ),
        enabledBorder: GsaWidgetTextField.themeProperties.enabledBorder(
          _focusNode,
          widget.controller,
        ),
        disabledBorder: GsaWidgetTextField.themeProperties.disabledBorder(
          widget.controller,
        ),
        errorBorder: GsaWidgetTextField.themeProperties.errorBorder(),
        focusedErrorBorder: GsaWidgetTextField.themeProperties.focusedErrorBorder(),
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
                      color: _obscureText ? const Color(0xff63747E) : Theme.of(context).primaryColor,
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
        labelStyle: GsaWidgetTextField.themeProperties.labelStyle(
          _focusNode,
          widget.controller,
        ),
      ),
      style: GsaWidgetTextField.themeProperties.textStyle(),
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
