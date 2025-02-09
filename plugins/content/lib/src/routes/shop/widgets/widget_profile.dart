part of '../route_shop.dart';

class _WidgetProfile extends StatelessWidget {
  const _WidgetProfile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: GestureDetector(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          GsaDataUser.instance.user?.personalDetails?.firstName != null
                              ? 'Hello, ${GsaDataUser.instance.user!.personalDetails!.firstName!}!'
                              : 'Hey you!',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Update your details, adjust your preferences, and manage your account all in one place.',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
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
                          backgroundColor: Theme.of(context).colorScheme.secondary,
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
          (switch (GsaConfig.provider) {
            GsaConfigProvider.ivancica => const GivRouteUserProfile(),
            _ => const GsaRouteUserProfile(),
          })
              .push();
        },
      ),
    );
  }
}
