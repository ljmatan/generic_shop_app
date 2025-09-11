/// Library defining the navigation target (route) interfaces and their respective implementations.

// ignore_for_file: public_member_api_docs

library;

import 'package:generic_shop_app_content/content.dart';

export 'package:generic_shop_app_architecture/arch.dart';

export 'auth/route_auth.dart';
export 'bookmarks/route_bookmarks.dart';
export 'camera/route_camera.dart';
export 'cart/route_cart.dart';
export 'chat/route_chat.dart';
export 'checkout/route_checkout.dart';
export 'clients/route_clients.dart';
export 'contact/route_merchant_contact.dart';
export 'cookie_consent/route_cookie_consent.dart';
export 'debug/route_debug.dart';
export 'guest_info/route_guest_info.dart';
export 'help/route_help.dart';
export 'legal_consent/route_legal_consent.dart';
export 'licences/route_licences.dart';
export 'login/route_login.dart';
export 'merchant/route_merchant.dart';
export 'onboarding/route_onboarding.dart';
export 'order_status/route_order_status.dart';
export 'payment_status/route_payment_status.dart';
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
  camera,
  cart,
  chat,
  checkout,
  clients,
  contact,
  cookieConsent,
  debug,
  guestInfo,
  help,
  legalConsent,
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
  GsaRoute Function([dynamic args]) get widget {
    switch (this) {
      case GsaRoutes.auth:
        return ([args]) => const GsaRouteAuth();
      case GsaRoutes.bookmarks:
        return ([args]) => const GsaRouteBookmarks();
      case GsaRoutes.camera:
        return ([args]) => GsaRouteCamera(
              mode: GsaRouteCameraMode.values.firstWhere(
                (value) {
                  return value.name == args['mode'];
                },
              ),
            );
      case GsaRoutes.cart:
        return ([args]) => const GsaRouteCart();
      case GsaRoutes.chat:
        return ([args]) => const GsaRouteChat();
      case GsaRoutes.checkout:
        return ([args]) => const GsaRouteCheckout();
      case GsaRoutes.clients:
        return ([args]) => const GsaRouteClients();
      case GsaRoutes.contact:
        return ([args]) => const GsaRouteMerchantContact();
      case GsaRoutes.cookieConsent:
        return ([args]) => const GsaRouteCookieConsent();
      case GsaRoutes.debug:
        return ([args]) => const GsaRouteDebug();
      case GsaRoutes.guestInfo:
        return ([args]) => const GsaRouteGuestInfo();
      case GsaRoutes.help:
        return ([args]) => const GsaRouteHelp();
      case GsaRoutes.legalConsent:
        return ([args]) {
          final url = args['url'] as String;
          return GsaRouteLegalConsent(
            url: url,
          );
        };
      case GsaRoutes.licences:
        return ([args]) => const GsaRouteLicences();
      case GsaRoutes.login:
        return ([args]) => const GsaRouteLogin();
      case GsaRoutes.merchant:
        return ([args]) => const GsaRouteMerchant();
      case GsaRoutes.onboarding:
        return ([args]) => const GsaRouteOnboarding();
      case GsaRoutes.orderStatus:
        return ([args]) => const GsaRouteOrderStatus();
      case GsaRoutes.paymentStatus:
        return ([args]) => const GsaRoutePaymentStatus();
      case GsaRoutes.register:
        return ([args]) => const GsaRouteRegister();
      case GsaRoutes.saleItemDetails:
        return ([args]) {
          if (args is GsaModelSaleItem) {
            return GsaRouteSaleItemDetails(args);
          } else {
            throw Exception(
              'Provided type ${args.runtimeType} is not of type GsaModelSaleItem.',
            );
          }
        };
      case GsaRoutes.settings:
        return ([args]) => const GsaRouteSettings();
      case GsaRoutes.shop:
        return ([args]) => const GsaRouteShop();
      case GsaRoutes.splash:
        return ([args]) => const GsaRouteSplash();
      case GsaRoutes.userProfile:
        return ([args]) => const GsaRouteUserProfile();
      case GsaRoutes.webView:
        return ([args]) {
          if (args['url'] is! String) {
            throw Exception(
              'Provided type ${args['url']} is not of type String.',
            );
          }
          if (args['urlPath'] is! String) {
            throw Exception(
              'Provided type ${args['urlPath']} is not of type String.',
            );
          }
          if (args['title'] is! String) {
            throw Exception(
              'Provided type ${args['title']} is not of type String.',
            );
          }
          return GsaRouteWebView(
            url: args['url'],
            urlPath: args['urlPath'],
            title: args['title'],
          );
        };
    }
  }

  @override
  Type get routeRuntimeType {
    switch (this) {
      case GsaRoutes.auth:
        return GsaRouteAuth;
      case GsaRoutes.bookmarks:
        return GsaRouteBookmarks;
      case GsaRoutes.camera:
        return GsaRouteCamera;
      case GsaRoutes.cart:
        return GsaRouteCart;
      case GsaRoutes.chat:
        return GsaRouteChat;
      case GsaRoutes.checkout:
        return GsaRouteCheckout;
      case GsaRoutes.clients:
        return GsaRouteClients;
      case GsaRoutes.contact:
        return GsaRouteMerchantContact;
      case GsaRoutes.cookieConsent:
        return GsaRouteCookieConsent;
      case GsaRoutes.debug:
        return GsaRouteDebug;
      case GsaRoutes.guestInfo:
        return GsaRouteGuestInfo;
      case GsaRoutes.help:
        return GsaRouteHelp;
      case GsaRoutes.legalConsent:
        return GsaRouteLegalConsent;
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
  String? get routeIdPrefix => null;

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

  /// Property used for overriding route displays.
  ///
  /// The property can be set by a client plugin in order to return another route
  /// as a replacement to [this] option:
  ///
  /// ```dart
  /// GsaRoutes.replacementRoute = (route) {
  ///   return switch (route) {
  ///     GsaRoutes.userProfile => () => CustomRoute(),
  ///     _ => null,
  ///   };
  /// };
  /// ```
  ///
  static GsaRoute? Function()? Function(GsaRouteType route)? replacementRoute;
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
      (route) {
        return route.routeRuntimeType == runtimeType;
      },
    );
  }
}
