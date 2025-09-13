import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

class GsaWidgetPopupMenu extends StatefulWidget {
  const GsaWidgetPopupMenu({
    super.key,
    required this.items,
  });

  final Iterable<
      ({
        IconData icon,
        String label,
        Function? onTap,
      })> items;

  @override
  State<GsaWidgetPopupMenu> createState() {
    return _GsaWidgetPopupMenuState();
  }
}

class _GsaWidgetPopupMenuState extends State<GsaWidgetPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.apps,
      ),
      iconColor: Theme.of(context).primaryColor,
      style: ButtonStyle(
        fixedSize: WidgetStatePropertyAll(
          Size(
            GsaTheme.of(context).actionElementHeight,
            GsaTheme.of(context).actionElementHeight,
          ),
        ),
      ),
      position: PopupMenuPosition.under,
      itemBuilder: (context) {
        return [
          for (final item in widget.items)
            PopupMenuItem(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ListTile(
                  leading: Icon(
                    item.icon,
                    size: 12,
                    color: item.onTap == null ? Colors.grey : null,
                  ),
                  title: GsaWidgetText(
                    item.label,
                    style: TextStyle(
                      color: item.onTap == null ? Colors.grey : null,
                    ),
                  ),
                  onTap: item.onTap == null
                      ? null
                      : () async {
                          await item.onTap!();
                        },
                ),
              ),
            ),
        ];
      },
    );
  }
}
