import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetRadioButton<T> extends StatefulWidget {
  GsaWidgetRadioButton({
    required this.options,
    this.initialValue,
    required this.onChanged,
  });

  final List<
      ({
        String label,
        T value,
      })> options;

  final T? initialValue;

  final Function(T?) onChanged;

  @override
  State createState() {
    return _GsaWidgetRadioButtonState<T>();
  }
}

class _GsaWidgetRadioButtonState<T> extends State<GsaWidgetRadioButton<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroup<T>(
      groupValue: _selectedValue,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
        widget.onChanged(value);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final option in widget.options)
            RadioListTile<T>(
              title: GsaWidgetText(
                option.label,
              ),
              value: option.value,
              selected: option.value == _selectedValue,
              activeColor: Theme.of(context).primaryColor,
              contentPadding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}
