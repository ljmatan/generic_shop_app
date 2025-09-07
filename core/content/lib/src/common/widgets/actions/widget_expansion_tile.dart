import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetExpansionTile extends StatefulWidget {
  const GsaWidgetExpansionTile({
    super.key,
    required this.title,
    this.titleInterpolated = false,
    required this.children,
    this.expandedCrossAxisAlignment = CrossAxisAlignment.start,
  });

  final String title;

  final bool titleInterpolated;

  final List<Widget> children;

  final CrossAxisAlignment expandedCrossAxisAlignment;

  @override
  State<GsaWidgetExpansionTile> createState() {
    return _GsaWidgetExpansionTileState();
  }
}

class _GsaWidgetExpansionTileState extends State<GsaWidgetExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: GsaWidgetText(
          widget.title,
          isInterpolated: widget.titleInterpolated,
        ),
        children: widget.children,
        expandedCrossAxisAlignment: widget.expandedCrossAxisAlignment,
      ),
    );
  }
}
