import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Generic dropdown menu integration with custom theme properties.
///
class GsaWidgetDropdownMenu<T> extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetDropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    this.initialSelection,
    this.enableFilter = true,
    this.enableSearch = true,
    this.width,
    this.height,
    this.textController,
    this.focusNode,
    this.enabled = true,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSelected,
    this.validator,
  });

  /// A collection of selection entries available with this menu.
  ///
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// The value that's initially specified as the selected dropdown menu option.
  ///
  final T? initialSelection;

  /// Property defining dropdown result filtering behaviour.
  ///
  /// If the property is set to `true`, dropdown result filtering is enabled.
  ///
  final bool enableFilter;

  /// Property defining dropdown result search behaviour.
  ///
  /// If the property is set to `true`, dropdown result search is enabled.
  ///
  final bool enableSearch;

  /// Size specified for a dropdown menu instance.
  ///
  final double? width, height;

  /// The default controller for this dropdown menu.
  ///
  final TextEditingController? textController;

  /// The default focus node for this dropdown menu.
  ///
  final FocusNode? focusNode;

  /// Whether option editing is enabled.
  ///
  final bool enabled;

  /// User-facing description labels.
  ///
  final String? labelText, hintText;

  /// Decorative elements.
  ///
  final Widget? prefixIcon, suffixIcon;

  /// Callback invoked on dropdown menu entry selection.
  ///
  /// If `true` is returned by the method, the input is cleared on selection.
  ///
  final bool? Function(T? value)? onSelected;

  /// Optional input validation method.
  ///
  final String? Function(String? value)? validator;

  @override
  State<GsaWidgetDropdownMenu<T>> createState() {
    return _GsaWidgetDropdownMenuState<T>();
  }
}

class _GsaWidgetDropdownMenuState<T> extends State<GsaWidgetDropdownMenu<T>> {
  Key _key = UniqueKey();

  late T? _initialSelection;

  late TextEditingController _textController;

  void _onTextControllerUpdate() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          if (_textController.text.isEmpty) _initialSelection = null;
          _key = UniqueKey();
        });
      },
    );
  }

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _initialSelection = widget.initialSelection;
    _textController = widget.textController ??
        TextEditingController(
          text: widget.initialSelection != null
              ? widget.dropdownMenuEntries
                  .firstWhereOrNull(
                    (entry) => entry.value == _initialSelection,
                  )
                  ?.label
              : null,
        );
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenuFormField<T>(
      key: _key,
      dropdownMenuEntries: widget.dropdownMenuEntries,
      enableFilter: widget.enableFilter,
      enableSearch: widget.enableSearch,
      controller: _textController,
      focusNode: _focusNode,
      enabled: widget.enabled,
      leadingIcon: widget.prefixIcon,
      trailingIcon: widget.suffixIcon,
      label: widget.labelText == null
          ? null
          : GsaWidgetText(
              widget.labelText!,
            ),
      hintText: widget.hintText,
      width: widget.width,
      menuHeight: widget.height,
      initialSelection: _initialSelection,
      expandedInsets: EdgeInsets.zero,
      textStyle: GsaWidgetTextField.themeProperties.textStyle(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      menuStyle: Theme.of(context).dropdownMenuTheme.menuStyle?.copyWith(
            minimumSize: WidgetStatePropertyAll(
              Size(
                0,
                widget.width ?? 0,
              ),
            ),
            maximumSize: WidgetStatePropertyAll(
              Size(
                MediaQuery.of(context).size.height,
                widget.width ?? MediaQuery.of(context).size.width,
              ),
            ),
          ),
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
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
            labelStyle: GsaWidgetTextField.themeProperties.labelStyle(
              _focusNode,
              _textController,
            ),
          ),
      onSaved: (value) {
        if (value is String) {
          _textController.text = value;
          _initialSelection = value;
          _onTextControllerUpdate();
        }
      },
      onSelected: (value) {
        if (value is String) {
          _textController.text = value;
          _initialSelection = value;
          _onTextControllerUpdate();
        }
        if (widget.onSelected != null) {
          final clear = widget.onSelected!(value);
          if (clear == true) _textController.clear();
        }
      },
      textInputAction: TextInputAction.done,
      validator: widget.validator != null
          ? (value) {
              if (value is String) {
                return widget.validator!(value);
              } else {
                return 'DropdownMenuFormField.validator not set with proper type.';
              }
            }
          : null,
    );
  }

  @override
  void dispose() {
    if (widget.textController == null) _textController.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }
}
