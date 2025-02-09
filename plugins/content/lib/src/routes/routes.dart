/// Library defining the navigation target (route) interfaces and their respective implementations.

// ignore_for_file: public_member_api_docs

library;

import 'package:generic_shop_app_content/src/routes/bookmarks/route_bookmarks.dart';
import 'package:generic_shop_app_content/src/routes/cart/route_cart.dart';
import 'package:generic_shop_app_content/src/routes/chat/route_chat.dart';
import 'package:generic_shop_app_content/src/routes/checkout/route_checkout.dart';
import 'package:generic_shop_app_content/src/routes/contact/route_merchant_contact.dart';
import 'package:generic_shop_app_content/src/routes/debug/route_debug.dart';
import 'package:generic_shop_app_content/src/routes/guest_info/route_guest_info.dart';
import 'package:generic_shop_app_content/src/routes/help/route_help.dart';
import 'package:generic_shop_app_content/src/routes/licences/route_licences.dart';
import 'package:generic_shop_app_content/src/routes/login/route_login.dart';
import 'package:generic_shop_app_content/src/routes/merchant/route_merchant.dart';
import 'package:generic_shop_app_content/src/routes/onboarding/route_onboarding.dart';
import 'package:generic_shop_app_content/src/routes/order_status/route_order_status.dart';
import 'package:generic_shop_app_content/src/routes/payment_status/route_payment_status.dart';
import 'package:generic_shop_app_content/src/routes/register/route_register.dart';
import 'package:generic_shop_app_content/src/routes/sale_item_details/route_sale_item_details.dart';
import 'package:generic_shop_app_content/src/routes/settings/route_settings.dart';
import 'package:generic_shop_app_content/src/routes/shop/route_shop.dart';
import 'package:generic_shop_app_content/src/routes/splash/route_splash.dart';
import 'package:generic_shop_app_content/src/routes/user_profile/route_user_profile.dart';
import 'package:generic_shop_app_content/src/routes/webview/route_webview.dart';
import 'package:generic_shop_app_architecture/gsar.dart';
import 'package:generic_shop_app_content/src/routes/auth/route_auth.dart';

export 'auth/route_auth.dart';
export 'cart/route_cart.dart';
export 'chat/route_chat.dart';
export 'checkout/route_checkout.dart';
export 'contact/route_merchant_contact.dart';
export 'debug/route_debug.dart';
export 'guest_info/route_guest_info.dart';
export 'help/route_help.dart';
export 'licences/route_licences.dart';
export 'login/route_login.dart';
export 'merchant/route_merchant.dart';
export 'onboarding/route_onboarding.dart';
export 'order_status/route_order_status.dart';
export 'register/route_register.dart';
export 'sale_item_details/route_sale_item_details.dart';
export 'settings/route_settings.dart';
export 'shop/route_shop.dart';
export 'splash/route_splash.dart';
export 'user_profile/route_user_profile.dart';
export 'webview/route_webview.dart';

/// Collection of Route objects implemented by the "Generic Shop App" project.
///
enum GsaRoutes implements GsaRouteType {
  auth,
  bookmarks,
  cart,
  chat,
  checkout,
  contact,
  debug,
  guestInfo,
  help,
  licences,
  login,
  merchant,
  onboarding,
  orderStatus,
  paymentStatus,
  register,
  saleItemDetails,
  settings,
  shop,
  splash,
  userProfile,
  webView;

  @override
  Type get routeRuntimeType {
    switch (this) {
      case GsaRoutes.auth:
        return GsaRouteAuth;
      case GsaRoutes.bookmarks:
        return GsaRouteBookmarks;
      case GsaRoutes.cart:
        return GsaRouteCart;
      case GsaRoutes.chat:
        return GsaRouteChat;
      case GsaRoutes.checkout:
        return GsaRouteCheckout;
      case GsaRoutes.contact:
        return GsaRouteMerchantContact;
      case GsaRoutes.debug:
        return GsaRouteDebug;
      case GsaRoutes.guestInfo:
        return GsaRouteGuestInfo;
      case GsaRoutes.help:
        return GsaRouteHelp;
      case GsaRoutes.licences:
        return GsaRouteLicences;
      case GsaRoutes.login:
        return GsaRouteLogin;
      case GsaRoutes.merchant:
        return GsaRouteMerchant;
      case GsaRoutes.onboarding:
        return GsaRouteOnboarding;
      case GsaRoutes.orderStatus:
        return GsaRouteOrderStatus;
      case GsaRoutes.paymentStatus:
        return GsaRoutePaymentStatus;
      case GsaRoutes.register:
        return GsaRouteRegister;
      case GsaRoutes.saleItemDetails:
        return GsaRouteSaleItemDetails;
      case GsaRoutes.settings:
        return GsaRouteSettings;
      case GsaRoutes.shop:
        return GsaRouteShop;
      case GsaRoutes.splash:
        return GsaRouteSplash;
      case GsaRoutes.userProfile:
        return GsaRouteUserProfile;
      case GsaRoutes.webView:
        return GsaRouteWebView;
    }
  }

  @override
  String get routeId {
    switch (this) {
      default:
        return name.replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (Match m) => '${m[1]}-${m[2]!.toLowerCase()}',
        );
    }
  }

  @override
  String get displayName {
    switch (this) {
      default:
        return name
            .replaceAllMapped(
              RegExp(r'([a-z0-9])([A-Z])'),
              (Match m) => '${m[1]} ${m[2]}',
            )
            .replaceFirstMapped(
              RegExp(r'^[a-z]'),
              (Match m) => m[0]!.toUpperCase(),
            );
    }
  }
}

/// A base Route class implementing the [GsaRoute] interface.
///
abstract class GsacRoute extends GsaRoute {
  /// Default, unnamed widget constructor.
  ///
  const GsacRoute({super.key});

  @override
  GsaRouteType get routeType {
    return GsaRoutes.values.firstWhere(
      (route) => route.routeRuntimeType == runtimeType,
    );
  }
}
