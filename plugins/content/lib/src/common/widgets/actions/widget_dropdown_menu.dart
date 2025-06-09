import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/src/common/widgets/actions/_actions.dart';

/// Generic dropdown menu integration with custom theme properties.
///
class GsaWidgetDropdownMenu extends StatefulWidget {
  /// Default, unnamed widget constructor.
  ///
  const GsaWidgetDropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    this.initialSelection,
    this.enableFilter = true,
    this.enableSearch = true,
    this.textController,
    this.focusNode,
    this.enabled = true,
    this.labelText,
    this.hintText,
    this.onSelected,
  });

  /// A collection of selection entries available with this menu.
  ///
  final List<DropdownMenuEntry> dropdownMenuEntries;

  /// The value that's initially specified as the selected dropdown menu option.
  ///
  final dynamic initialSelection;

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

  /// Callback invoked on dropdown menu entry selection.
  ///
  final void Function(dynamic)? onSelected;

  @override
  State<GsaWidgetDropdownMenu> createState() => _GsaWidgetDropdownMenuState();
}

class _GsaWidgetDropdownMenuState extends State<GsaWidgetDropdownMenu> {
  late TextEditingController _textController;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = widget.textController ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DropdownMenu(
        dropdownMenuEntries: widget.dropdownMenuEntries,
        enableFilter: widget.enableFilter,
        enableSearch: widget.enableSearch,
        controller: _textController,
        focusNode: _focusNode,
        enabled: widget.enabled,
        label: widget.labelText == null ? null : Text(widget.labelText!),
        hintText: widget.hintText,
        width: MediaQuery.of(context).size.width,
        initialSelection: widget.initialSelection,
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
        onSelected: widget.onSelected,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.textController == null) _textController.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }
}
