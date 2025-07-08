import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/config.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/gsac.dart';
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
    this.translationReference,
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
    this.translationReference,
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

  /// The [Type] with which the translated content is referenced.
  ///
  /// The translations are usually referenced against [GsaRoute] types,
  /// but a custom one can be provided as well.
  ///
  final Type? translationReference;

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

  Key _textWidgetKey = UniqueKey();

  void _rebuildOnLanguageUpdate() {
    setState(() {
      _textWidgetKey = UniqueKey();
    });
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
                  key: _textWidgetKey,
                  text: widget,
                  translatedText: snapshot.data!,
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
            key: _textWidgetKey,
            text: widget,
            translatedText: null,
          );
  }

  @override
  void dispose() {
    GsaConfig.languageNotifier.removeListener(_rebuildOnLanguageUpdate);
    super.dispose();
  }
}

class _WidgetTextDisplay extends StatefulWidget {
  const _WidgetTextDisplay({
    required super.key,
    required this.text,
    required this.translatedText,
  });

  final GsaWidgetText text;

  final List<String>? translatedText;

  @override
  State<_WidgetTextDisplay> createState() => _WidgetTextDisplayState();
}

class _WidgetTextDisplayState extends State<_WidgetTextDisplay> {
  Type? get _translationReference {
    if (widget.text.translationReference != null) {
      return widget.text.translationReference;
    }
    Type? translationReference;
    final ancestorElements = <Element>[];
    if (context.findAncestorWidgetOfExactType<GsaWidgetAppBar>() != null) {
      context.visitAncestorElements(
        (element) {
          if (element.widget is GsaRoute) {
            return false;
          }
          ancestorElements.add(element);
          return true;
        },
      );
      for (final ancestor in ancestorElements) {
        final matchingType = GsaServiceI18N.widgetTypes.firstWhereOrNull(
          (widgetType) {
            return widgetType == ancestor.widget.runtimeType;
          },
        );
        if (matchingType != null) {
          translationReference = matchingType;
          break;
        }
      }
    }
    return translationReference ?? context.findAncestorStateOfType<GsaRouteState>()?.widget.runtimeType;
  }

  String _translatedContent(String value) {
    final translationReference = widget.text.translationReference ?? _translationReference;
    if (translationReference != null) {
      return GsaServiceI18N.instance.translate(
            ancestor: translationReference,
            value: value,
          ) ??
          value;
    } else {
      return value;
    }
  }

  late List<String> _textValues;

  @override
  void initState() {
    super.initState();
    _textValues = widget.translatedText ??
        (widget.text.labels.isNotEmpty
            ? [
                for (final label in widget.text.labels)
                  _translatedContent(
                    label.text,
                  ),
              ]
            : [
                _translatedContent(
                  widget.text.label,
                ),
              ]);
  }

  @override
  Widget build(BuildContext context) {
    return widget.text.labels.isNotEmpty
        ? Text.rich(
            TextSpan(
              children: [
                for (final label in widget.text.labels.indexed)
                  TextSpan(
                    text: _textValues[label.$1],
                    style: label.$2.style,
                    recognizer: label.$2.onTap != null ? (TapGestureRecognizer()..onTap = label.$2.onTap) : null,
                  ),
              ],
            ),
            textAlign: widget.text.textAlign,
            style: widget.text.style,
            maxLines: widget.text.maxLines,
            overflow: widget.text.overflow ?? TextOverflow.ellipsis,
          )
        : Text(
            _textValues[0],
            style: widget.text.style,
            textAlign: widget.text.textAlign ?? TextAlign.start,
            maxLines: widget.text.maxLines,
            overflow: widget.text.overflow ?? TextOverflow.ellipsis,
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
      text: widget.label,
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
    this.interpolated = false,
  });

  final String text;

  final TextStyle? style;

  final VoidCallback? onTap;

  final bool interpolated;
}
