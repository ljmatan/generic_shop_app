import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:generic_shop_app_architecture/gsar.dart';

/// Route displaying the order status information.
///
class GsaRouteOrderStatus extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteOrderStatus({super.key});

  @override
  State<GsaRouteOrderStatus> createState() => _GsaRouteOrderStatusState();

  @override
  String get routeId => 'order-status';

  @override
  String get displayName => 'Order Status';
}

class _GsaRouteOrderStatusState extends GsarRouteState<GsaRouteOrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GsaWidgetText(widget.displayName),
      ),
      body: ListView(
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
          const Center(
            child: GsaWidgetText(
              'Order Complete',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: GsaWidgetText.rich(
              [
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
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: GsaWidgetText.rich(
              [
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
              child: const GsaWidgetText(
                'HOME',
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}
