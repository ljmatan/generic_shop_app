import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_services/services.dart';

/// Defines standardized text styles..
///
/// This enum enforces a **typography system** that ensures consistent sizing,
/// weight, and color usage across the app.
///
/// Each variant corresponds to a semantic role in UI design, not just a font size.
/// This way, design intent is preserved.
///
enum GsaWidgetTextStyles {
  /// Small supporting text, often used for secondary labels or helper messages.
  ///
  /// Example: Timestamp under a message.
  ///
  small,

  /// Default text for paragraphs or regular content.
  ///
  /// Example: Body copy, form inputs, basic UI text.
  ///
  regular,

  /// Slightly larger than [regular] for emphasis.
  ///
  /// Example: Emphasized content, secondary section text.
  ///
  medium,

  /// Larger body text, often used for buttons or emphasized labels.
  ///
  /// Example: Settings menu items.
  ///
  large,

  /// A page or section title.
  ///
  /// Example: "Account Settings" heading.
  ///
  title,

  /// Subtitle or secondary heading.
  ///
  /// Example: Subsection label under a title.
  ///
  subtitle,

  /// Very small text, typically de-emphasized.
  ///
  /// Example: Captions under images or icons.
  ///
  caption,

  /// Text style used for actionable buttons.
  ///
  /// Example: "SUBMIT", "SAVE".
  ///
  button,

  /// Prominent heading text, larger than [title].
  ///
  /// Example: Section headers, dashboard labels.
  ///
  headline,

  /// Very large display text, for emphasis or branding.
  ///
  /// Example: Onboarding hero text, welcome screens.
  ///
  display,

  /// Error messages or validation feedback.
  ///
  /// Example: "Password is too short".
  ///
  error,

  /// Styled for hyperlinks or clickable text.
  ///
  /// Example: "Terms and Conditions".
  ///
  url;

  /// Retrieve the value of a [TextStyle] for this [GsaWidgetTextStyle] entry.
  ///
  TextStyle get value {
    switch (this) {
      case GsaWidgetTextStyles.small:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.2,
        );

      case GsaWidgetTextStyles.regular:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.4,
        );

      case GsaWidgetTextStyles.medium:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.4,
        );

      case GsaWidgetTextStyles.large:
        return const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 1.4,
        );

      case GsaWidgetTextStyles.title:
        return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.3,
        );

      case GsaWidgetTextStyles.subtitle:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF666666),
        );

      case GsaWidgetTextStyles.caption:
        return const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: Color(0xFF999999),
        );

      case GsaWidgetTextStyles.button:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.25,
        );

      case GsaWidgetTextStyles.headline:
        return const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        );

      case GsaWidgetTextStyles.display:
        return const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          height: 1.1,
        );

      case GsaWidgetTextStyles.error:
        return const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFFD32F2F),
        );

      case GsaWidgetTextStyles.url:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1976D2),
          decoration: TextDecoration.underline,
        );
    }
  }
}

/// Flutter [Text] widget implementation with internationalization and editing features embedded.
///
class GsaWidgetText extends StatefulWidget {
  /// The default [GsaWidgetText] constructor, implementing the Flutter SDK [Text] widget.
  ///
  GsaWidgetText(
    this.label, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isConstrained = false,
    this.isInterpolated = false,
  })  : _key = key,
        labels = const [];

  /// The [GsaWidgetText] constructor implementing the Flutter SDK [Text.rich] widget.
  ///
  GsaWidgetText.rich(
    this.labels, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isConstrained = false,
  })  : _key = key,
        label = '',
        isInterpolated = false;

  /// Key forwarded to this instance by the parent widget.
  ///
  final Key? _key;

  /// Unique key applied to this widget instance if no [_key] is specified.
  ///
  final _uniqueKey = UniqueKey();

  @override
  Key? get key {
    return _key ?? _uniqueKey;
  }

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

  /// Whether the widget will be automatically sized according to the parent constraints.
  ///
  final bool isConstrained;

  /// Whether the text value is provided as a variable (and not to be translated).
  ///
  final bool isInterpolated;

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
      maxLines: widget.maxLines,
    )..layout(
        maxWidth: MediaQuery.of(context).size.width,
      );

    return textPainter.size;
  }

  Key _textWidgetKey = UniqueKey();

  void _rebuildOnLanguageUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _textWidgetKey = UniqueKey();
        });
      }
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
  String _translatedContent(String value) {
    try {
      final translationReference = GsaServiceI18N.instance.getTranslationReference(
        context,
      );
      if (translationReference != null) {
        if (translationReference.route?.translatable != false) {
          return GsaServiceI18N.instance.translate(
                ancestor: translationReference.ancestor,
                route: translationReference.route.runtimeType,
                value: value,
              ) ??
              value;
        }
      }
    } catch (e) {
      // Do nothing.
    }
    return value;
  }

  late List<String> _textValues;

  @override
  void initState() {
    super.initState();
    _textValues = widget.translatedText ??
        (widget.text.labels.isNotEmpty
            ? [
                for (final label in widget.text.labels)
                  if (label.interpolated)
                    label.text
                  else
                    _translatedContent(
                      label.text,
                    ),
              ]
            : [
                if (widget.text.isInterpolated)
                  widget.text.label
                else
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
            overflow: widget.text.overflow,
          )
        : Text(
            _textValues[0],
            style: widget.text.style,
            textAlign: widget.text.textAlign ?? TextAlign.start,
            maxLines: widget.text.maxLines,
            overflow: widget.text.overflow,
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
