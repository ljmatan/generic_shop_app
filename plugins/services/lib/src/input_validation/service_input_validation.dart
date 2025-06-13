import 'package:generic_shop_app_architecture/gsar.dart';

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
  String? personalName(String? input) {
    if (input == null) return 'Personal name input is empty.';
    final trimmed = input.trim();
    if (trimmed.length < 2 || trimmed.length > 20 || RegExp(r'\d').hasMatch(trimmed)) {
      return 'Please verify your name input.';
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
    if (input == null) return 'Email input is empty.';
    final trimmed = input.trim();
    if (trimmed.length < 2 ||
        trimmed.length > 50 ||
        !RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
        ).hasMatch(trimmed)) {
      return 'Please verify your email input.';
    }
    return null;
  }

  /// Validation method for a password.
  ///
  /// Must be at least 8 characters long, and must include an uppercase letter, lowercase letter, and a number.
  ///
  String? password(String? input) {
    if (input == null) return 'Password input is empty.';
    final trimmed = input.trim();
    if (trimmed.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(trimmed) ||
        !RegExp(r'[0-9]').hasMatch(trimmed) ||
        !RegExp(r'[a-z]').hasMatch(trimmed)) {
      return 'The password must be 8 letters in length, '
          'with at least one uppercase symbol, '
          'with at least one lowercase symbol, '
          'and with at least one number.';
    }
    return null;
  }

  /// Validation method for phone numbers.
  ///
  /// Accepts the international phone number standard.
  ///
  String? phoneNumber(String? input) {
    if (input == null) return 'Phone number input is empty.';
    final trimmed = input.trim();
    if (!RegExp(
      r'((?:\+|00)[17](?: |\-)?|(?:\+|00)[1-9]\d{0,2}(?: |\-)?|(?:\+|00)1\-\d{3}(?: |\-)?)?(0\d|\([0-9]{3}\)|[1-9]{0,3})(?:((?: |\-)[0-9]{2}){4}|((?:[0-9]{2}){4})|((?: |\-)[0-9]{3}(?: |\-)[0-9]{4})|([0-9]{7}))',
    ).hasMatch(trimmed)) {
      return 'Please verify your phone number input.';
    }
    return null;
  }

  /// Validation method for a given street name.
  ///
  /// The given value must be at least 4 characters in length.
  ///
  String? street(String? input) {
    if (input == null) return 'Street name input is empty.';
    final trimmed = input.trim();
    if (trimmed.length < 4) {
      return 'Please verify your street name input.';
    }
    return null;
  }

  /// Validation method for house numbers.
  ///
  /// The given value must not be empty i.e., the value may contain both numbers and letters.
  ///
  String? houseNumber(String? input) {
    if (input == null) return 'House number input is empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Please verify your house number input.';
    }
    return null;
  }

  /// Validation method for postcode / zipcode validation.
  ///
  /// The given value must not be empty.
  ///
  String? postCode(String? input) {
    if (input == null) return 'Postcode input is empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Please verify your postcode input.';
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
    if (input == null) return 'City name input is empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Please verify your city name input.';
    }
    return null;
  }

  /// Validation method for the state name validation.
  ///
  /// The given value must not be empty, and may contain both letters and numbers.
  ///
  String? state(String? input) {
    if (input == null) return 'State name input is empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Please verify your state name input.';
    }
    return null;
  }

  /// Validation method for the country name validation.
  ///
  /// The given value must not be empty, and may contain both letters and numbers.
  ///
  String? country(String? input) {
    if (input == null) return 'Country name input is empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Please verify your country name input.';
    }
    return null;
  }

  /// Validation method for numbers.
  ///
  /// The given value must not be empty and must be of numerical type.
  ///
  String? number(String? input) {
    if (input == null) return 'Number input is empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Please verify your number input.';
    }
    return null;
  }

  /// Validation method for plain text.
  ///
  /// The given value must not be empty..
  ///
  String? plainText(String? input) {
    if (input == null) return 'Input is empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Please verify your input.';
    }
    return null;
  }
}
