import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetSwitch extends StatefulWidget {
  const GsaWidgetSwitch({
    super.key,
    required this.value,
    this.label,
    this.child,
    this.enabled = true,
    this.rebuild = true,
    required this.onTap,
  });

  final bool value;

  final Widget? label;

  final Widget? child;

  final bool enabled;

  final bool rebuild;

  final Function(bool newValue) onTap;

  @override
  GsaWidgetSwitchState createState() => GsaWidgetSwitchState();
}

class GsaWidgetSwitchState extends State<GsaWidgetSwitch> {
  bool _error = false;

  bool validate() {
    setState(() => _error = !widget.value);
    return !_error;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              widget.label!,
              const SizedBox(height: 14),
            ],
            Row(
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Switch(
                    value: widget.value,
                    onChanged: widget.enabled
                        ? (value) {
                            if (widget.rebuild) setState(() {});
                            widget.onTap(value);
                          }
                        : null,
                  ),
                ),
                if (widget.child != null) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: widget.child!,
                  ),
                ],
              ],
            ),
          ],
        ),
        if (_error)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: GsaWidgetText(
              'The terms must be accepted.',
              style: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          ),
      ],
    );
  }
}
