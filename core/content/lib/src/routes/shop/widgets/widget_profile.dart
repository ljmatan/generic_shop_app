part of '../route_shop.dart';

class _WidgetProfile extends StatelessWidget {
  const _WidgetProfile();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GsaWidgetText(
                        'Review Your Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      GsaWidgetText(
                        'Review your details, '
                        'adjust your preferences, '
                        'and manage your account all in one place.',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
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
                          Icons.person,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        const GsaRouteUserProfile().push(
          replacement: GsaConfig.plugin.client == GsaClient.froddoB2b,
        );
      },
    );
  }
}
