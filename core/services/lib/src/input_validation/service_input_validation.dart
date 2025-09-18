import 'package:flutter/material.dart';
import 'package:generic_shop_app_architecture/arch.dart';

part 'service_input_validation_i18n.dart';

/// User-generated input validation services.
///
class GsaServiceInputValidation extends GsaService {
  GsaServiceInputValidation._();

  static final _instance = GsaServiceInputValidation._();

  // ignore: public_member_api_docs
  static GsaServiceInputValidation get instance => _instance() as GsaServiceInputValidation;

  /// Validation method for any form of a "personal" name, such as a company or a person name.
  ///
  /// Requires at least 2 characters, and max 20 characters. Numbers are not allowed.
  ///
  String? personalName(
    String? input,
  ) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._personalNameInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    if (trimmed!.length < 2 || trimmed.length > 20 || RegExp(r'\d').hasMatch(trimmed)) {
      return GsaServiceInputValidationI18N._personalNameRequiresVerification.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for a person first name.
  ///
  /// Invokes the [personalName] method.
  ///
  String? firstName(String? input) {
    return personalName(input);
  }

  /// Validation method for a person last name.
  ///
  /// Invokes the [personalName] method.
  ///
  String? lastName(String? input) {
    return personalName(input);
  }

  /// Validation method for an email address.
  ///
  /// The given value must be a proper email address.
  ///
  String? email(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._emailInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    if (trimmed!.length < 2 ||
        trimmed.length > 50 ||
        !RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
        ).hasMatch(trimmed)) {
      return GsaServiceInputValidationI18N._emailRequiresVerification.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for a password.
  ///
  /// Must be at least 8 characters long, and must include an uppercase letter, lowercase letter, and a number.
  ///
  String? password(
    BuildContext context, {
    required String? input,
  }) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._passwordInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    if (GsaPlugin.of(context).api?.passwordValidator != null) {
      return GsaPlugin.of(context).api!.passwordValidator!(trimmed);
    }
    return null;
  }

  /// Validation method for phone numbers.
  ///
  /// Accepts the international phone number standard.
  ///
  String? phoneNumber(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._passwordInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    if (!RegExp(
      r'((?:\+|00)[17](?: |\-)?|(?:\+|00)[1-9]\d{0,2}(?: |\-)?|(?:\+|00)1\-\d{3}(?: |\-)?)?(0\d|\([0-9]{3}\)|[1-9]{0,3})(?:((?: |\-)[0-9]{2}){4}|((?:[0-9]{2}){4})|((?: |\-)[0-9]{3}(?: |\-)[0-9]{4})|([0-9]{7}))',
    ).hasMatch(trimmed!)) {
      return GsaServiceInputValidationI18N._phoneNumberRequiresValidation.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for a given street name.
  ///
  /// The given value must be at least 4 characters in length.
  ///
  String? street(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._streetNameInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    if (trimmed!.length < 4) {
      return GsaServiceInputValidationI18N._streetNameRequiresValidation.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for house numbers.
  ///
  /// The given value must not be empty i.e., the value may contain both numbers and letters.
  ///
  String? houseNumber(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._houseNumberInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for postcode / zipcode validation.
  ///
  /// The given value must not be empty.
  ///
  String? postCode(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._postCodeInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for postcode / zipcode validation.
  ///
  /// Invokes the [postCode] method, serves as a helper method for different naming.
  ///
  String? zipCode(String? input) {
    return postCode(input);
  }

  /// Validation method for the city name validation.
  ///
  /// The given value must not be empty, and may contain both letters and numbers.
  ///
  String? city(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._cityInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for the state name validation.
  ///
  /// The given value must not be empty, and may contain both letters and numbers.
  ///
  String? state(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._stateInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for the country name validation.
  ///
  /// The given value must not be empty, and may contain both letters and numbers.
  ///
  String? country(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._countryInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for numbers.
  ///
  /// The given value must not be empty and must be of numerical type.
  ///
  String? number(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._numberInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    if (int.tryParse(trimmed!) == null) {
      return GsaServiceInputValidationI18N._numberInputRequiresVerification.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }

  /// Validation method for plain text.
  ///
  /// The given value must not be empty..
  ///
  String? plainText(String? input) {
    final trimmed = input?.trim();
    if (trimmed?.isNotEmpty != true) {
      return GsaServiceInputValidationI18N._plainTextInputEmpty.value.display.translateFromType(
        ancestor: runtimeType,
      );
    }
    return null;
  }
}
