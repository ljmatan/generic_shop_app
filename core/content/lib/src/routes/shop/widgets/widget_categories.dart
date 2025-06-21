part of '../route_shop.dart';

class _WidgetCategories extends StatefulWidget {
  const _WidgetCategories(
    this.categories, {
    required this.setCategory,
  });

  final List<GsaModelCategory> categories;

  final Function(GsaModelCategory category) setCategory;

  @override
  State<_WidgetCategories> createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<_WidgetCategories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GsaWidgetHeadline('Categories'),
          const SizedBox(height: 6),
          const GsaWidgetText(
            'Shop with ease by exploring our organized category list, tailored to your interests.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          for (final category in widget.categories.indexed) ...[
            if (category.$1 != 0) const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: Row(
                          children: [
                            DecoratedBox(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: Center(
                                  child: GsaWidgetText(
                                    '${category.$1 + 1}',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: GsaWidgetText(
                                category.$2.name ?? 'N/A',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (category.$2.description != null)
                        DecoratedBox(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                            child: GsaWidgetText(
                              category.$2.description!,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                onTap: () => widget.setCategory(category.$2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
