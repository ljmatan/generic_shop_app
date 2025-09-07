import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

/// The type of button display.
///
enum _GsaWidgetButtonType {
  /// Button with style derived from the [FilledButton] widget.
  ///
  filled,

  /// Button with style derived from the [OutlinedButton] widget.
  ///
  outlined,

  /// Button with style derived from the [ElevatedButton] widget.
  ///
  elevated,

  /// Button with style derived from the [TextButton] widget.
  ///
  text,

  /// Button with style derived from the [IconButton] widget.
  ///
  icon,
}

/// Default button widget, includes multiple display styles.
///
class GsaWidgetButton extends StatefulWidget {
  /// Constructor implemented in order to build this widget as a [FilledButton] derivative.
  ///
  const GsaWidgetButton.filled({
    super.key,
    this.label,
    this.labelWidget,
    this.icon,
    this.iconWidget,
    this.elementSize,
    this.backgroundColor,
    this.foregroundColor,
    this.tonal = false,
    this.rounded = false,
    this.outlined = false,
    this.focusNode,
    this.interpolatedText = false,
    required this.onTap,
  }) : _type = _GsaWidgetButtonType.filled;

  /// Constructor implemented in order to build this widget as an [OutlinedButton] derivative.
  ///
  const GsaWidgetButton.outlined({
    super.key,
    this.label,
    this.labelWidget,
    this.icon,
    this.iconWidget,
    this.elementSize,
    this.backgroundColor,
    this.foregroundColor,
    this.rounded = false,
    this.outlined = false,
    this.focusNode,
    this.interpolatedText = false,
    required this.onTap,
  })  : _type = _GsaWidgetButtonType.outlined,
        tonal = false;

  /// Constructor implemented in order to build this widget as an [ElevatedButton] derivative.
  ///
  const GsaWidgetButton.elevated({
    super.key,
    this.label,
    this.labelWidget,
    this.icon,
    this.iconWidget,
    this.elementSize,
    this.backgroundColor,
    this.foregroundColor,
    this.rounded = false,
    this.outlined = false,
    this.focusNode,
    this.interpolatedText = false,
    required this.onTap,
  })  : _type = _GsaWidgetButtonType.elevated,
        tonal = false;

  /// Constructor implemented in order to build this widget as a [TextButton] derivative.
  ///
  const GsaWidgetButton.text({
    super.key,
    this.label,
    this.labelWidget,
    this.icon,
    this.iconWidget,
    this.elementSize,
    this.foregroundColor,
    this.outlined = false,
    this.focusNode,
    this.interpolatedText = false,
    required this.onTap,
  })  : _type = _GsaWidgetButtonType.text,
        backgroundColor = null,
        tonal = false,
        rounded = false;

  /// Constructor implemented in order to build this widget as an [IconButton] derivative.
  ///
  const GsaWidgetButton.icon({
    super.key,
    this.icon,
    this.iconWidget,
    this.elementSize,
    this.foregroundColor,
    this.outlined = false,
    this.focusNode,
    required this.onTap,
  })  : _type = _GsaWidgetButtonType.icon,
        label = null,
        labelWidget = null,
        backgroundColor = null,
        tonal = false,
        rounded = false,
        interpolatedText = false;

  /// Private property defining the type of button for rendering.
  ///
  final _GsaWidgetButtonType _type;

  /// Text label applied to the button display.
  ///
  final String? label;

  /// Widget applied as a replacement to the [String]-type [label].
  ///
  final Widget? labelWidget;

  /// Icon applied to the button display.
  ///
  final IconData? icon;

  /// Widget applied as a replacement to the [IconData]-type [icon].
  ///
  final Widget? iconWidget;

  /// The size property applied to foreground elements.
  ///
  final double? elementSize;

  /// Color applied to the background of the button.
  ///
  final Color? backgroundColor;

  /// Color applied to elements such as text or icons.
  ///
  final Color? foregroundColor;

  /// Whether the button will be displayed with a tonal variant.
  ///
  final bool tonal;

  /// Whether the button corners will be displayed as fully rounded.
  ///
  final bool rounded;

  /// Whether to render an element outline on foreground elements,
  /// used to ensure visibility on coloured backgrounds.
  ///
  final bool outlined;

  /// an object that can be used by a stateful widget to obtain the keyboard focus
  /// and to handle keyboard events.
  ///
  final FocusNode? focusNode;

  /// Whether the text is interpolated or defined as a static (translatable) entry.
  ///
  final bool interpolatedText;

  /// Method invoked on this button trigger.
  ///
  final VoidCallback? onTap;

  @override
  State<GsaWidgetButton> createState() => _GsaWidgetButtonState();
}

class _GsaWidgetButtonState extends State<GsaWidgetButton> {
  late FocusNode _focusNode;

  late Widget? _icon;

  late Widget? _label;

  late ButtonStyle _buttonStyle;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    _icon = widget.iconWidget == null && widget.icon == null
        ? null
        : SizedBox(
            height: Theme.of(context).actionElementHeight,
            child: Center(
              widthFactor: 1,
              child: widget.iconWidget ??
                  (widget.icon != null
                      ? Icon(
                          widget.icon,
                          color: widget.foregroundColor,
                          size: widget.elementSize,
                          shadows: widget.outlined == true ? Theme.of(context).outline.shadows() : null,
                        )
                      : null),
            ),
          );
    _label = widget.labelWidget == null && widget.label == null
        ? null
        : SizedBox(
            height: Theme.of(context).actionElementHeight,
            child: Center(
              widthFactor: 1,
              child: widget.labelWidget != null
                  ? widget.labelWidget!
                  : widget.label == null
                      ? const SizedBox()
                      : GsaWidgetText(
                          '${widget.label}',
                          isInterpolated: widget.interpolatedText,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: widget.foregroundColor,
                            fontSize: widget.elementSize,
                            shadows: widget.outlined == true ? Theme.of(context).outline.shadows() : null,
                            decoration: widget._type == _GsaWidgetButtonType.text ? TextDecoration.underline : null,
                          ),
                        ),
            ),
          );
    _buttonStyle = ButtonStyle(
      shape: widget.rounded
          ? WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            )
          : null,
      backgroundColor: widget.backgroundColor != null
          ? WidgetStateProperty.all<Color>(
              widget.backgroundColor!,
            )
          : null,
      foregroundColor: widget.foregroundColor != null
          ? WidgetStateProperty.all<Color>(
              widget.foregroundColor!,
            )
          : null,
    );
    return SizedBox(
      height: Theme.of(context).actionElementHeight,
      child: switch (widget._type) {
        _GsaWidgetButtonType.filled => widget.tonal
            ? _icon == null
                ? FilledButton.tonal(
                    child: _label,
                    style: _buttonStyle,
                    focusNode: _focusNode,
                    onPressed: widget.onTap,
                  )
                : FilledButton.tonalIcon(
                    label: _label ?? _icon!,
                    icon: _label == null ? null : _icon,
                    style: _buttonStyle,
                    focusNode: _focusNode,
                    onPressed: widget.onTap,
                  )
            : _icon == null
                ? FilledButton(
                    child: _label,
                    style: _buttonStyle,
                    focusNode: _focusNode,
                    onPressed: widget.onTap,
                  )
                : FilledButton.icon(
                    label: _label ?? _icon!,
                    icon: _label == null ? null : _icon,
                    style: _buttonStyle,
                    focusNode: _focusNode,
                    onPressed: widget.onTap,
                  ),
        _GsaWidgetButtonType.outlined => _icon == null
            ? OutlinedButton(
                child: _label,
                style: _buttonStyle,
                focusNode: _focusNode,
                onPressed: widget.onTap,
              )
            : OutlinedButton.icon(
                label: _label ?? _icon!,
                icon: _label == null ? null : _icon,
                style: _buttonStyle,
                focusNode: _focusNode,
                onPressed: widget.onTap,
              ),
        _GsaWidgetButtonType.elevated => _icon == null
            ? ElevatedButton(
                child: _label,
                style: _buttonStyle,
                focusNode: _focusNode,
                onPressed: widget.onTap,
              )
            : ElevatedButton.icon(
                label: _label ?? _icon!,
                icon: _label == null ? null : _icon,
                style: _buttonStyle,
                focusNode: _focusNode,
                onPressed: widget.onTap,
              ),
        _GsaWidgetButtonType.text => _icon == null
            ? TextButton(
                child: _label ?? const SizedBox(),
                style: _buttonStyle,
                focusNode: _focusNode,
                onPressed: widget.onTap,
              )
            : TextButton.icon(
                label: _label ?? _icon!,
                icon: _label == null ? null : _icon,
                style: _buttonStyle,
                focusNode: _focusNode,
                onPressed: widget.onTap,
              ),
        _GsaWidgetButtonType.icon => IconButton(
            icon: _icon ?? const SizedBox(),
            style: _buttonStyle,
            iconSize: widget.elementSize,
            color: Theme.of(context).primaryColor,
            focusNode: _focusNode,
            onPressed: widget.onTap,
          ),
      },
    );
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }
}
