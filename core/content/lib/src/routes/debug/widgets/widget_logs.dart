part of '../route_debug.dart';

class _WidgetLogs<T> extends StatelessWidget {
  const _WidgetLogs({
    required this.label,
    this.hint,
    this.emptyCollectionLabel,
    required this.collection,
    required this.itemBuilder,
  });

  final String label;

  final String? hint;

  final Iterable<T>? collection;

  final Widget Function(T item) itemBuilder;

  final String? emptyCollectionLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Theme.of(context).paddings.listViewHorizontal(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          GsaWidgetText(
            label,
          ),
          const SizedBox(height: 16),
          if (hint != null) ...[
            Card(
              child: Padding(
                padding: Theme.of(context).paddings.card(),
                child: GsaWidgetText(
                  hint!,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          const Divider(),
          if (collection?.isNotEmpty == true)
            ListView.builder(
              padding: Theme.of(context).paddings.listView(),
              itemCount: collection!.length,
              itemBuilder: (context, index) {
                final item = collection!.elementAt(index);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index != 0) const SizedBox(height: 10),
                    itemBuilder(item),
                  ],
                );
              },
            )
          else ...[
            const SizedBox(height: 16),
            GsaWidgetText(
              emptyCollectionLabel ?? 'No entries found.',
            ),
          ],
        ],
      ),
    );
  }
}
