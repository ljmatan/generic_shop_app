import 'package:generic_shop_app_architecture/gsa_architecture.dart';

/// User-generated input validation services.
///
class GsaaServiceInputValidation extends GsarService {
  GsaaServiceInputValidation._();

  static final _instance = GsaaServiceInputValidation._();

  // ignore: public_member_api_docs
  static GsaaServiceInputValidation get instance => _instance() as GsaaServiceInputValidation;

  /// Validation method for any form of a "personal" name, such as a company or a person name.
  ///
  /// Requires at least 2 characters, and max 20 characters. Numbers are not allowed.
  ///
  String? personalName(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.length < 2 || trimmed.length > 20 || RegExp(r'\d').hasMatch(trimmed)) {
      return 'Bitte Namen eintragen';
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
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.length < 2 ||
        trimmed.length > 50 ||
        !RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
        ).hasMatch(trimmed)) {
      return 'Bitte E-Mail-Adresse eintragen';
    }
    return null;
  }

  /// Validation method for a password.
  ///
  /// Must be at least 8 characters long, and must include an uppercase letter, lowercase letter, and a number.
  ///
  String? password(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.length < 8 ||
        !RegExp(r'[A-Z]').hasMatch(trimmed) ||
        !RegExp(r'[0-9]').hasMatch(trimmed) ||
        !RegExp(r'[a-z]').hasMatch(trimmed)) {
      return 'Das Passwort muss mindestens 8 Zeichen lang sein und 1 '
          'Großbuchstaben, 1 Kleinbuchstaben und 1 Zahl enthalten.';
    }
    return null;
  }

  /// Validation method for phone numbers.
  ///
  /// Accepts the international phone number standard.
  ///
  String? phoneNumber(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (!RegExp(
      r'((?:\+|00)[17](?: |\-)?|(?:\+|00)[1-9]\d{0,2}(?: |\-)?|(?:\+|00)1\-\d{3}(?: |\-)?)?(0\d|\([0-9]{3}\)|[1-9]{0,3})(?:((?: |\-)[0-9]{2}){4}|((?:[0-9]{2}){4})|((?: |\-)[0-9]{3}(?: |\-)[0-9]{4})|([0-9]{7}))',
    ).hasMatch(trimmed)) {
      return 'Please check your input.';
    }
    return null;
  }

  /// Validation method for a given street name.
  ///
  /// The given value must be at least 4 characters in length.
  ///
  String? street(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.length < 4) {
      return 'Bitte überprüfen Sie Ihre Eingaben';
    }
    return null;
  }

  /// Validation method for house numbers.
  ///
  /// The given value must not be empty i.e., the value may contain both numbers and letters.
  ///
  String? houseNumber(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Bitte überprüfen Sie Ihre Eingaben';
    }
    return null;
  }

  /// Validation method for postcode / zipcode validation.
  ///
  /// The given value must not be empty.
  ///
  String? postCode(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Bitte überprüfen Sie Ihre Eingaben';
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
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Bitte überprüfen Sie Ihre Eingaben';
    }
    return null;
  }

  /// Validation method for the state name validation.
  ///
  /// The given value must not be empty, and may contain both letters and numbers.
  ///
  String? state(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Bitte überprüfen Sie Ihre Eingaben';
    }
    return null;
  }

  /// Validation method for the country name validation.
  ///
  /// The given value must not be empty, and may contain both letters and numbers.
  ///
  String? country(String? input) {
    if (input == null) throw 'Input empty.';
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      return 'Bitte überprüfen Sie Ihre Eingaben';
    }
    return null;
  }
}
