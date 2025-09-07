import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetDropdownButton extends StatefulWidget {
  const GsaWidgetDropdownButton({
    super.key,
    this.label,
    this.initialSelectionIndex,
    this.children,
    this.labelStyle,
    this.height = 52,
    this.padding = 12,
    this.loading = false,
  }) : assert(label != null || children != null);

  final String? label;

  final int? initialSelectionIndex;

  final List<GsaWidgetDropdownEntry>? children;

  final TextStyle? labelStyle;

  final double height;

  final double padding;

  final bool loading;

  @override
  GsaWidgetDropdownButtonState createState() {
    return GsaWidgetDropdownButtonState();
  }
}

class GsaWidgetDropdownButtonState extends State<GsaWidgetDropdownButton> {
  final _key = GlobalKey();
  RenderBox? _renderBox;
  Offset? _widgetOffset;

  bool? _displayBelow;

  double get _fullItemsHeight => (widget.children!.length - 1) * widget.height;
  double get _heightCutoff => MediaQuery.of(context).size.height * .4;
  double get _itemsHeight => _fullItemsHeight < _heightCutoff ? _fullItemsHeight : _heightCutoff;

  void _getWidgetInfo() {
    if (1 == 1) {
      _renderBox = _key.currentContext!.findRenderObject() as RenderBox;
      _widgetOffset = _renderBox!.localToGlobal(Offset.zero);
      _displayBelow = MediaQuery.of(context).size.height - _widgetOffset!.dy - 100 > _itemsHeight;
      _widgetOffset = Offset(
        _widgetOffset!.dx,
        _widgetOffset!.dy - (_displayBelow! ? -widget.height - 10 : 10 + _itemsHeight),
      );
    } else {
      _renderBox = _key.currentContext!.findRenderObject() as RenderBox;
      _widgetOffset = _renderBox!.localToGlobal(Offset.zero);
      _displayBelow = MediaQuery.of(context).size.height - _widgetOffset!.dy - 100 > _itemsHeight;
      _widgetOffset = Offset(
        _widgetOffset!.dx,
        _widgetOffset!.dy -
            MediaQueryData.fromView(WidgetsBinding.instance.window).padding.top +
            (_displayBelow! ? widget.height + 10 : -_itemsHeight - 10),
      );
    }
  }

  String? _selected, _selectedId;

  bool _error = false;

  @override
  void initState() {
    super.initState();
    if (widget.children != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _getWidgetInfo());
    }
    if (widget.label == null || widget.initialSelectionIndex != null) {
      _selected = widget.children?[widget.initialSelectionIndex ?? 0].label;
      _selectedId = widget.children?[widget.initialSelectionIndex ?? 0].id;
    }
  }

  bool _expanded = false;

  bool validate() {
    setState(() => _error = _selected == null);
    return !_error;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            GestureDetector(
              key: _key,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _error
                      ? null
                      : _selected != null || _expanded
                          ? Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : const Color(0xff404040)
                          : Theme.of(context).brightness == Brightness.light
                              ? const Color(0xffF0F3F5)
                              : const Color(0xffb3b3b3),
                  border: _error
                      ? Border.all(
                          style: BorderStyle.solid,
                          color: const Color(0xffDE1E36),
                        )
                      : _expanded
                          ? Border.all(
                              color: Theme.of(context).primaryColor,
                            )
                          : Border.all(
                              color: _selected != null ? const Color(0xffADBDC6) : Colors.transparent,
                            ),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: widget.height,
                  child: Padding(
                    padding: EdgeInsets.only(left: widget.padding, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GsaWidgetText(
                            _selected ?? widget.label ?? 'ERROR',
                            style: (widget.labelStyle ?? const TextStyle(fontSize: 11)),
                          ),
                        ),
                        if (widget.children != null && widget.children!.length > 1)
                          AnimatedRotation(
                            turns: _expanded ? .5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.expand_more,
                              color: _error
                                  ? const Color(0xffDE1E36)
                                  : _expanded
                                      ? Theme.of(context).primaryColor
                                      : _selected != null
                                          ? null
                                          : const Color(0xff63747E),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: widget.loading || widget.children == null || widget.children!.length < 2
                  ? null
                  : () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      FocusScope.of(context).unfocus();
                      setState(() => _expanded = !_expanded);
                      _getWidgetInfo();
                      await showGeneralDialog(
                        context: context,
                        barrierLabel: '',
                        barrierDismissible: true,
                        barrierColor: Colors.transparent,
                        pageBuilder: (context, _, __) => Transform.translate(
                          offset: _widgetOffset!,
                          child: GestureDetector(
                            child: Material(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.05),
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: _renderBox!.size.width,
                                      height: _itemsHeight,
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        physics: const ClampingScrollPhysics(),
                                        children: [
                                          if (widget.children != null)
                                            for (var item in widget.children!
                                                .where((item) => _selectedId == null ? item.label != _selected : item.id != _selectedId))
                                              GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                child: SizedBox(
                                                  width: _renderBox!.size.width,
                                                  height: widget.height,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: widget.padding,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: GsaWidgetText(
                                                            item.label,
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  await item.onTap();
                                                  setState(
                                                    () {
                                                      _selected = item.label;
                                                      _selectedId = item.id;
                                                      _error = _selected == null;
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                      );
                      setState(() => _expanded = false);
                    },
            ),
            if (_selected != null && widget.label != null)
              Transform.translate(
                offset: const Offset(16, -8),
                child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GsaWidgetText(
                      widget.label!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10),
                    ),
                  ),
                ),
              ),
            if (widget.loading)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: .7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: widget.height,
                ),
              ),
          ],
        ),
        if (_error)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: GsaWidgetText(
              'Bitte auswählen',
              style: const TextStyle(
                color: Color(0xffDE1E36),
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}

class GsaWidgetDropdownEntry {
  GsaWidgetDropdownEntry({
    required this.label,
    required this.id,
    required this.onTap,
  });

  final String label;

  final String? id;

  final Function onTap;
}
