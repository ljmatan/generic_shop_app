import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app/config.dart';
import 'package:generic_shop_app/services/src/i18n/service_i18n.dart';

/// Flutter [Text] widget implementation with internationalization and editing features embedded.
///
class GsaWidgetText extends StatefulWidget {
  /// The default [GsaWidgetText] constructor, implementing the Flutter SDK [Text] widget.
  ///
  const GsaWidgetText(
    this.label, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines = 100,
    this.overflow,
  }) : labels = const [];

  /// The [GsaWidgetText] constructor implementing the Flutter SDK [Text.rich] widget.
  ///
  const GsaWidgetText.rich(
    this.labels, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines = 100,
    this.overflow,
  }) : label = '';

  /// The text displayed with this widget.
  ///
  final String label;

  /// Alternating style labels for display with the [GsaWidgetText.rich] constructor.
  ///
  final List<GsaWidgetTextSpan> labels;

  /// The text style applied to the [label] attribute.
  ///
  final TextStyle? style;

  /// Horizontal text alignment specification.
  ///
  final TextAlign? textAlign;

  /// The specified number of lines this text is allowed to expand to.
  ///
  final int? maxLines;

  final TextOverflow? overflow;

  @override
  State<GsaWidgetText> createState() {
    // ignore: no_logic_in_create_state
    return GsaConfig.editMode ? _GsaWidgetEditableTextState() : _GsaWidgetTextState();
  }
}

class _GsaWidgetTextState extends State<GsaWidgetText> {
  void _rebuildOnLanguageUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GsaConfig.languageNotifier.addListener(_rebuildOnLanguageUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return widget.labels.isNotEmpty
        ? Text.rich(
            TextSpan(
              children: [
                for (final label in widget.labels)
                  TextSpan(
                    text: label.text,
                    style: label.style,
                    recognizer: label.onTap != null ? (TapGestureRecognizer()..onTap = label.onTap) : null,
                  ),
              ],
            ),
            textAlign: widget.textAlign,
            style: widget.style,
            maxLines: widget.maxLines,
            overflow: widget.overflow ?? TextOverflow.ellipsis,
          )
        : Text(
            widget.label.translated(context),
            style: widget.style,
            textAlign: widget.textAlign ?? TextAlign.start,
            maxLines: widget.maxLines,
            overflow: widget.overflow ?? TextOverflow.ellipsis,
          );
  }

  @override
  void dispose() {
    GsaConfig.languageNotifier.removeListener(_rebuildOnLanguageUpdate);
    super.dispose();
  }
}

class _GsaWidgetEditableTextState extends State<GsaWidgetText> {
  late TextEditingController _textEditingController;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.label.translated(context));
  }

  @override
  Widget build(BuildContext context) {
    return EditableText(
      controller: _textEditingController,
      focusNode: _focusNode,
      style: widget.style ?? Theme.of(context).textTheme.bodyMedium!,
      cursorColor: Theme.of(context).primaryColor,
      backgroundCursorColor: Theme.of(context).colorScheme.secondary,
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}

class GsaWidgetTextSpan {
  const GsaWidgetTextSpan(
    this.text, {
    this.style,
    this.onTap,
  });

  final String text;

  final TextStyle? style;

  final VoidCallback? onTap;
}
