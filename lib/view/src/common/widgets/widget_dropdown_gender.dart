import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/actions/widget_dropdown.dart';

class GsaWidgetDropdownGender extends StatefulWidget {
  final Function(String) onChanged;
  final GlobalKey<GsaWidgetDropdownState> dropdownKey;
  final String? initialValue;

  const GsaWidgetDropdownGender({
    super.key,
    required this.onChanged,
    required this.dropdownKey,
    this.initialValue,
  });

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
      child: GsaWidgetDropdown(
        key: widget.dropdownKey,
        label: 'Title',
        valueAt: _salutationIndex,
        padding: 20,
        children: _salutations
            .map(
              (e) => (
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
