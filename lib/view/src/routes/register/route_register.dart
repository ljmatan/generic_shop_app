import 'package:flutter/material.dart';
import 'package:generic_shop_app/view/src/common/widgets/widget_text.dart';
import 'package:gsa_architecture/gsa_architecture.dart';

/// Route providing user authentication options, such as login, registration, or guest user login.
///
class GsaRouteRegister extends GsarRoute {
  // ignore: public_member_api_docs
  const GsaRouteRegister({
    super.key,
    this.username,
    this.password,
  });

  /// Prefilled data.
  ///
  final String? username, password;

  @override
  State<GsaRouteRegister> createState() => _GsaRouteRegisterState();

  @override
  String get routeId => 'register';

  @override
  String get displayName => 'Register';
}

class _GsaRouteRegisterState extends GsarRouteState<GsaRouteRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GsaWidgetText(widget.displayName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const GsaWidgetText(
            'Register an Account',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
