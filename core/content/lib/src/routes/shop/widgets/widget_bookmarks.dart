part of '../route_shop.dart';

class _WidgetBookmarks extends StatelessWidget {
  const _WidgetBookmarks();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                      child: const SizedBox(
                        width: 58,
                        height: 58,
                      ),
                    ),
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GsaWidgetText(
                      'Bookmark List',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GsaWidgetText(
                      'Review a list of your bookmarked products.',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        if (GsaServiceCacheEntry.cookieConsentFunctionality.mandatoryCookie.value == true) {
          const GsaRouteBookmarks().push();
        } else {
          const GsaWidgetOverlayCookieConsentMissing(
            message: 'You haven\'t enabled functional cookies, so bookmarks can\'t be saved.\n\n'
                'Update your cookie preferences to use this feature.',
            functional: true,
          ).openDialog();
        }
      },
    );
  }
}
