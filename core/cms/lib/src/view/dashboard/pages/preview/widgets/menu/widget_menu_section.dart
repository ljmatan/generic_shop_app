part of '../../page_preview.dart';

class _WidgetMenuSection extends StatefulWidget {
  const _WidgetMenuSection({
    this.initiallyExpanded = false,
    required this.label,
    required this.description,
    this.hint,
    required this.children,
  });

  final bool initiallyExpanded;

  final String label;

  final String description;

  final String? hint;

  final List<Widget> children;

  @override
  State<_WidgetMenuSection> createState() => _WidgetMenuSectionState();
}

class _WidgetMenuSectionState extends State<_WidgetMenuSection> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  final _animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: _animationDuration,
      curve: Curves.easeInOut,
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Row(
              children: [
                Expanded(
                  child: GsaWidgetText(
                    widget.label,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                AnimatedRotation(
                  duration: _animationDuration,
                  turns: _expanded ? 0 : .5,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          GsaWidgetText(
            widget.description,
          ),
          if (_expanded) ...[
            if (widget.hint != null) ...[
              SizedBox(
                height: GsaTheme.of(context).paddings.content.small,
              ),
              GsaWidgetText(
                widget.hint!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            SizedBox(
              height: GsaTheme.of(context).paddings.content.mediumLarge,
            ),
            ...widget.children,
          ],
        ],
      ),
    );
  }
}
