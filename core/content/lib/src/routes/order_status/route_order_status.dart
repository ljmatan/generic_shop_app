import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/gsac.dart';

/// Route displaying the order status information.
///
class GsaRouteOrderStatus extends GsacRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsaRouteOrderStatus({super.key});

  @override
  State<GsaRouteOrderStatus> createState() => _GsaRouteOrderStatusState();
}

class _GsaRouteOrderStatusState extends GsaRouteState<GsaRouteOrderStatus> {
  @override
  Widget view(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GsaWidgetAppBar(
            label: widget.displayName,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(26),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Center(
                  child: GsaWidgetText(
                    'Order Complete',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: GsaWidgetText.rich(
                    const [
                      GsaWidgetTextSpan(
                        'Order ID: ',
                      ),
                      GsaWidgetTextSpan(
                        'V32SDA1',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GsaWidgetText.rich(
                    const [
                      GsaWidgetTextSpan(
                        'Order fullfilment is done by the amazing community of\n\n',
                      ),
                      GsaWidgetTextSpan(
                        'Independent Herbalife Distributors',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: FilledButton(
                    child: GsaWidgetText(
                      'HOME',
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
