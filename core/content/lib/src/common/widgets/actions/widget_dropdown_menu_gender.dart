import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetDropdownGender extends StatefulWidget {
  const GsaWidgetDropdownGender({
    super.key,
    required this.onChanged,
    required this.dropdownKey,
    this.initialValue,
  });

  final Function(String) onChanged;

  final GlobalKey<GsaWidgetDropdownButtonState> dropdownKey;

  final String? initialValue;

  @override
  State createState() => _GsaWidgetDropdownGenderState();
}

class _GsaWidgetDropdownGenderState extends State<GsaWidgetDropdownGender> {
  static const _salutations = ['-', 'Mr.', 'Mrs.', 'Other'];
  String? _salutation;
  int? _salutationIndex;

  @override
  void initState() {
    super.initState();
    _salutation = widget.initialValue;
    final matching = _salutations.where((e) => e.toLowerCase() == _salutation?.toLowerCase());
    if (matching.isNotEmpty) {
      _salutation = matching.first;
      _salutationIndex = _salutations.indexOf(_salutation!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: GsaWidgetDropdownButton(
        key: widget.dropdownKey,
        label: 'Title',
        initialSelectionIndex: _salutationIndex,
        padding: 20,
        children: _salutations
            .map(
              (e) => GsaWidgetDropdownEntry(
                label: e,
                id: null,
                onTap: () {
                  _salutation = e;
                  widget.onChanged(e);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
