import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:generic_shop_app_content/content.dart';

export 'actions/_actions.dart';
export 'flair/_flair.dart';
export 'modules/_modules.dart';
export 'overlays/_overlays.dart';

mixin GsaWidget on Widget {
  GsaWidgets? get widgetRepresentation {
    return GsaWidgets.values.firstWhereOrNull(
      (widget) {
        return widget.widgetRuntimeType == runtimeType;
      },
    );
  }
}

enum GsaWidgets {
  actionBookmarkButton,
  actionDropdownButton,
  actionDropdownMenuGender,
  actionDropdownMenu,
  actionPhoneNumberInput,
  actionStickyBottomButton,
  actionSwitch,
  actionTermsConfirmation,
  actionTextField,
  flairBlobs,
  overlayAlert,
  overlayConfirmation,
  overlayContentBlocking,
  overlayLegalConsent,
  overlaySaleItem,
  appBar,
  cookieConsent,
  error,
  headline,
  image,
  logo,
  map,
  merchantPreview,
  saleItemCarousel,
  saleItemPreview,
  text,
  totalCartPrice,
  webContent;

  Type get widgetRuntimeType {
    switch (this) {
      case GsaWidgets.actionBookmarkButton:
        return GsaWidgetBookmarkButton;
      case GsaWidgets.actionDropdownButton:
        return GsaWidgetDropdownButton;
      case GsaWidgets.actionDropdownMenuGender:
        return GsaWidgetDropdownGender;
      case GsaWidgets.actionDropdownMenu:
        return GsaWidgetDropdownMenu;
      case GsaWidgets.actionPhoneNumberInput:
        return GsaWidgetPhoneNumberInput;
      case GsaWidgets.actionStickyBottomButton:
        return GsaWidgetStickyBottomButton;
      case GsaWidgets.actionSwitch:
        return GsaWidgetSwitch;
      case GsaWidgets.actionTermsConfirmation:
        return GsaWidgetTermsConfirmation;
      case GsaWidgets.actionTextField:
        return GsaWidgetTextField;
      case GsaWidgets.flairBlobs:
        return GsaWidgetFlairBlobBackground;
      case GsaWidgets.overlayAlert:
        return GsaWidgetOverlayAlert;
      case GsaWidgets.overlayConfirmation:
        return GsaWidgetOverlayConfirmation;
      case GsaWidgets.overlayContentBlocking:
        return GsaWidgetOverlayContentBlocking;
      case GsaWidgets.overlayLegalConsent:
        return GsaWidgetOverlayCookieConsent;
      case GsaWidgets.overlaySaleItem:
        return GsaWidgetOverlaySaleItem;
      case GsaWidgets.appBar:
        return GsaWidgetAppBar;
      case GsaWidgets.cookieConsent:
        return GsaWidgetCookieConsent;
      case GsaWidgets.error:
        return GsaWidgetError;
      case GsaWidgets.headline:
        return GsaWidgetHeadline;
      case GsaWidgets.image:
        return GsaWidgetImage;
      case GsaWidgets.logo:
        return GsaWidgetLogo;
      case GsaWidgets.map:
        return Widget; // TODO
      case GsaWidgets.merchantPreview:
        return GsaWidgetMerchantPreview;
      case GsaWidgets.saleItemCarousel:
        return GsaWidgetSaleItemCarousel;
      case GsaWidgets.saleItemPreview:
        return GsaWidgetSaleItemPreview;
      case GsaWidgets.text:
        return GsaWidgetText;
      case GsaWidgets.totalCartPrice:
        return GsaWidgetTotalCartPrice;
      case GsaWidgets.webContent:
        return GsaWidgetWebContent;
    }
  }
}
