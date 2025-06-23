import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_services/services.dart';

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

  /// Property defining how overflowing text should be handled.
  ///
  final TextOverflow? overflow;

  /// Optional method provided for translation purposes.
  ///
  static Future<List<String>>? Function(List<String> text)? translate;

  @override
  State<GsaWidgetText> createState() {
    // ignore: no_logic_in_create_state
    return GsaConfig.editMode ? _GsaWidgetEditableTextState() : _GsaWidgetTextState();
  }
}

class _GsaWidgetTextState extends State<GsaWidgetText> {
  late List<String> text;

  Size _measureTextSize() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text.length > 1 ? null : text.elementAtOrNull(0),
        children: text.length > 1
            ? [
                for (final textSection in text.indexed)
                  TextSpan(
                    text: textSection.$2,
                    style: widget.labels.elementAtOrNull(textSection.$1)?.style,
                  ),
              ]
            : null,
        style: widget.style,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(
        maxWidth: MediaQuery.of(context).size.width,
      );

    return textPainter.size;
  }

  void _rebuildOnLanguageUpdate() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GsaConfig.languageNotifier.addListener(_rebuildOnLanguageUpdate);
    text = widget.labels.isNotEmpty
        ? [widget.label]
        : widget.labels.map(
            (label) {
              return label.text;
            },
          ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GsaWidgetText.translate != null
        ? FutureBuilder(
            future: GsaWidgetText.translate!(text),
            builder: (context, snapshot) {
              if (snapshot.data?.isNotEmpty == true) {
                return _WidgetTextDisplay(
                  label: widget.label,
                  labels: widget.labels,
                  translatedText: snapshot.data!,
                  textAlign: widget.textAlign,
                  style: widget.style,
                  maxLines: widget.maxLines,
                  overflow: widget.overflow,
                );
              }

              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey,
                ),
                child: SizedBox.fromSize(
                  size: _measureTextSize(),
                ),
              );
            },
          )
        : _WidgetTextDisplay(
            label: widget.label,
            labels: widget.labels,
            translatedText: null,
            textAlign: widget.textAlign,
            style: widget.style,
            maxLines: widget.maxLines,
            overflow: widget.overflow,
          );
  }

  @override
  void dispose() {
    GsaConfig.languageNotifier.removeListener(_rebuildOnLanguageUpdate);
    super.dispose();
  }
}

class _WidgetTextDisplay extends StatelessWidget {
  const _WidgetTextDisplay({
    required this.label,
    required this.labels,
    required this.translatedText,
    required this.textAlign,
    required this.style,
    required this.maxLines,
    required this.overflow,
  });

  final String label;

  final List<GsaWidgetTextSpan> labels;

  final List<String>? translatedText;

  final TextAlign? textAlign;

  final TextStyle? style;

  final int? maxLines;

  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return labels.isNotEmpty
        ? Text.rich(
            TextSpan(
              children: [
                for (final label in labels.indexed)
                  TextSpan(
                    text: translatedText?.elementAtOrNull(label.$1) ?? label.$2.text,
                    style: label.$2.style,
                    recognizer: label.$2.onTap != null ? (TapGestureRecognizer()..onTap = label.$2.onTap) : null,
                  ),
              ],
            ),
            textAlign: textAlign,
            style: style,
            maxLines: maxLines,
            overflow: overflow ?? TextOverflow.ellipsis,
          )
        : GsaWidgetText(
            translatedText?.isNotEmpty == true ? translatedText![0] : label.translated(context),
            style: style,
            textAlign: textAlign ?? TextAlign.start,
            maxLines: maxLines,
            overflow: overflow ?? TextOverflow.ellipsis,
          );
  }
}

class _GsaWidgetEditableTextState extends State<GsaWidgetText> {
  late TextEditingController _textEditingController;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.label.translated(context),
    );
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
