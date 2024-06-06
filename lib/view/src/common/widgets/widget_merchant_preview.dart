import 'package:flutter/material.dart';
import 'package:generic_shop_app/services/services.dart';
import 'package:generic_shop_app/services/src/i18n/service_i18n.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app_api/generic_shop_app_api.dart';

/// A widget used for merchant / vendor information preview.
///
class GsaWidgetMerchantPreview extends StatelessWidget {
  // ignore: public_member_api_docs
  const GsaWidgetMerchantPreview(
    this.merchant, {
    super.key,
    this.displayActions = true,
  });

  /// Provided merchant / vendor information for display.
  ///
  final GsaaModelMerchant merchant;

  /// Whether to display the call, navigate, and "more info" actions / buttons.
  ///
  final bool displayActions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: displayActions ? const EdgeInsets.fromLTRB(14, 16, 14, 8) : const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (merchant.name != null)
                        Text(
                          merchant.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      if (merchant.address?.city != null)
                        Text(
                          merchant.address!.city! + (merchant.address!.country != null ? ', ${merchant.address!.country}' : ''),
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
                if (displayActions && MediaQuery.of(context).size.width >= 1000)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < 3; i++)
                        ElevatedButton(
                          child: Icon(Icons.abc),
                          onPressed: () {},
                        ),
                    ],
                  ),
              ],
            ),
            if (displayActions && MediaQuery.of(context).size.width < 1000)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    for (final action in {
                      (
                        label: 'CALL'.translated(context),
                        icon: Icons.call_outlined,
                        onTap: merchant.contact?.formattedPhoneNumber != null
                            ? () async {
                                await GsaServiceUrlLauncher.instance.launchCall(
                                  merchant.contact!.formattedPhoneNumber!,
                                );
                              }
                            : null,
                      ),
                      (
                        label: 'ROUTE'.translated(context),
                        icon: Icons.navigation,
                        onTap: merchant.address?.coordinates != null
                            ? () async {
                                await GsaServiceUrlLauncher.instance.launchMaps(
                                  merchant.address!.latitude!,
                                  merchant.address!.longitude!,
                                  displayName: merchant.name,
                                );
                              }
                            : null,
                      ),
                      (
                        label: 'INFO'.translated(context),
                        icon: Icons.web_asset,
                        onTap: merchant.originUrl != null
                            ? () async {
                                await GsaServiceUrlLauncher.instance.launchWeb(
                                  merchant.originUrl!,
                                );
                              }
                            : null,
                      ),
                    }.indexed)
                      Expanded(
                        child: Padding(
                          padding: switch (action.$1) {
                            0 => const EdgeInsets.only(right: 5),
                            1 => const EdgeInsets.symmetric(horizontal: 2.5),
                            2 => const EdgeInsets.only(left: 5),
                            int() => throw UnimplementedError(),
                          },
                          child: OutlinedButton(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Opacity(
                                    opacity: .8,
                                    child: Icon(
                                      action.$2.icon,
                                      size: 12,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    GsaWidgetText(
                                      action.$2.label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..color = Colors.white
                                          ..strokeWidth = 1.8,
                                      ),
                                    ),
                                    GsaWidgetText(
                                      action.$2.label,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onPressed: action.$2.onTap,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
