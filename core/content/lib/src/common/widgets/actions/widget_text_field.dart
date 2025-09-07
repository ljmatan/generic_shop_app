import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

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
    this.minLines,
    this.maxLines,
    this.onSubmitted,
    this.validator,
    this.displayDeleteButton = true,
    this.onFocusChange,
    this.onControllerChanged,
    this.onControllerCleared,
    this.onTap,
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.contentPadding,
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
  final int? minLines, maxLines;

  /// Event triggered on keyboard "enter" key / confirmation.
  ///
  final Function(String value)? onSubmitted;

  /// Optional input validation method.
  ///
  final String? Function(String? value)? validator;

  /// Whether to automatically display the delete "x" button.
  ///
  final bool displayDeleteButton;

  /// Event triggered on focus change.
  ///
  final Function(bool focused)? onFocusChange;

  /// Event triggered on controller change.
  ///
  final Future<String?>? Function(String value)? onControllerChanged;

  /// Invoked on text deletion by the "delete button" applied with [displayDeleteButton].
  ///
  final Function? onControllerCleared;

  /// Event triggered on text input field tap.
  ///
  final Function? onTap;

  /// An action the user has requested the text input control to perform.
  ///
  final TextInputAction? textInputAction;

  /// Whether and how to align text horizontally.
  ///
  final TextAlign textAlign;

  /// The padding for the input decoration's container.
  ///
  final EdgeInsetsGeometry? contentPadding;

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
        color: GsaTheme.instance.data.brightness == Brightness.light
            ? focusNode?.hasFocus == true || textEditingController?.text.isNotEmpty == true
                ? const Color(0xff283033)
                : const Color(0xff63747E)
            : Colors.white,
      );
    },
    textStyle: (BuildContext context) {
      return TextStyle(
        color: GsaTheme.instance.data.brightness == Brightness.light ? const Color(0xff63747E) : Colors.white,
        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
      );
    },
  );

  @override
  State<GsaWidgetTextField> createState() => _GsaWidgetTextFieldState();
}

class _GsaWidgetTextFieldState extends State<GsaWidgetTextField> {
  late TextEditingController _textController;

  bool _externalTextUpdate = false;

  Future<void> _onTextControllerUpdate() async {
    if (widget.onControllerChanged != null && !_externalTextUpdate) {
      final text = await widget.onControllerChanged!(
        _textController.text,
      );
      if (text != null) {
        _externalTextUpdate = true;
        _textController.text = text;
      }
    } else {
      _externalTextUpdate = false;
    }
    if (mounted) {
      setState(() {});
    }
  }

  late FocusNode _focusNode;

  Future<void> _onFocusNodeUpdate() async {
    if (widget.onFocusChange != null) {
      await widget.onFocusChange!(_focusNode.hasFocus);
    }
    if (mounted) {
      setState(() {});
    }
  }

  final _buttonFocusNode = FocusNode(
    skipTraversal: true,
    canRequestFocus: false,
    descendantsAreTraversable: false,
    descendantsAreFocusable: false,
  );

  late bool _obscureText;

  late double _horizontalPadding;

  @override
  void initState() {
    super.initState();
    _textController = widget.controller ?? TextEditingController();
    _textController.addListener(_onTextControllerUpdate);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusNodeUpdate);
    _obscureText = widget.obscureText;
    _horizontalPadding = ((widget.contentPadding ?? GsaTheme.instance.data.inputDecorationTheme.contentPadding)?.horizontal ?? 0) / 2;
  }

  String? _errorText;

  bool get _suffixAutoImplemented {
    return _obscureText == true || _focusNode.hasFocus && _textController.text.isNotEmpty == true && widget.displayDeleteButton;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Theme.of(context).actionElementHeight * (widget.maxLines ?? widget.minLines ?? 1),
          child: TextFormField(
            controller: _textController,
            focusNode: _focusNode,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            minLines: widget.minLines,
            maxLines: _obscureText ? 1 : widget.maxLines,
            textInputAction: widget.textInputAction,
            textAlign: widget.textAlign,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding,
              fillColor: GsaWidgetTextField.themeProperties.fillColor(
                Theme.of(context).brightness,
                _focusNode,
                _textController,
              ),
              border: GsaWidgetTextField.themeProperties.border(
                _focusNode,
                _textController,
              ),
              focusedBorder: GsaWidgetTextField.themeProperties.focusedBorder(
                Theme.of(context).primaryColor,
              ),
              enabledBorder: GsaWidgetTextField.themeProperties.enabledBorder(
                _focusNode,
                _textController,
              ),
              disabledBorder: GsaWidgetTextField.themeProperties.disabledBorder(
                _textController,
              ),
              errorBorder: GsaWidgetTextField.themeProperties.errorBorder(),
              focusedErrorBorder: GsaWidgetTextField.themeProperties.focusedErrorBorder(),
              prefix: widget.prefix,
              prefixIconConstraints: widget.prefixIcon == null
                  ? BoxConstraints(
                      minWidth: _horizontalPadding,
                      maxWidth: _horizontalPadding,
                    )
                  : null,
              prefixIcon: widget.prefixIcon != null
                  ? SizedBox(
                      width: 48,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: widget.prefixIcon!,
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                    ),
              suffix: widget.suffix,
              suffixIconConstraints: widget.suffixIcon != null || _suffixAutoImplemented
                  ? null
                  : BoxConstraints(
                      minWidth: _horizontalPadding,
                      maxWidth: _horizontalPadding,
                    ),
              suffixIcon: widget.suffixIcon != null
                  ? SizedBox(
                      width: 48,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: widget.suffixIcon!,
                      ),
                    )
                  : _suffixAutoImplemented
                      ? GsaWidgetButton.icon(
                          icon: widget.obscureText == true ? Icons.visibility : Icons.close,
                          foregroundColor: _obscureText ? const Color(0xff63747E) : Theme.of(context).primaryColor,
                          elementSize: 18,
                          focusNode: _buttonFocusNode,
                          onTap: widget.obscureText == true
                              ? () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                }
                              : () {
                                  _textController.clear();
                                  if (widget.onControllerCleared != null) {
                                    widget.onControllerCleared!();
                                  }
                                },
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                        ),
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle: GsaWidgetTextField.themeProperties.labelStyle(
                _focusNode,
                _textController,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator == null
                ? null
                : (value) {
                    final errorText = widget.validator!(value);
                    if (_errorText != errorText) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _errorText = errorText;
                        });
                      });
                    }
                    return errorText;
                  },
            errorBuilder: (context, errorText) {
              return const SizedBox();
            },
            onFieldSubmitted: widget.onSubmitted,
            style: GsaWidgetTextField.themeProperties.textStyle(context),
            autocorrect: false,
            enableSuggestions: false,
            onTap: widget.onTap != null ? () => widget.onTap!() : null,
          ),
        ),
        if (_errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _horizontalPadding,
            ),
            child: Text(
              _errorText!,
              style: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(
      _onTextControllerUpdate,
    );
    if (widget.controller == null) {
      _textController.dispose();
    }
    if (_focusNode.hasFocus && widget.onFocusChange != null) {
      widget.onFocusChange!(false);
    }
    _focusNode.removeListener(
      _onFocusNodeUpdate,
    );
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _buttonFocusNode.dispose();
    super.dispose();
  }
}
