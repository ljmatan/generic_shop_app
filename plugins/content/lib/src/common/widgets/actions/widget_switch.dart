import 'package:flutter/material.dart';

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

  final Function(bool) onTap;

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
            if (widget.label != null) widget.label!,
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 48,
                    height: 36,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_error)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'The terms must be accepted.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
