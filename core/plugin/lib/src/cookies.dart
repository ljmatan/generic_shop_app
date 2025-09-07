/// Collection of cookie information related to a client integration.
///
class GsaPluginCookies {
  /// Generates an instance of the object,
  /// marking the cookie requirement with [bool] values.
  ///
  GsaPluginCookies({
    required this.functional,
    required this.marketing,
    required this.statistical,
  });

  /// Mandatory cookie category, always active.
  ///
  bool get mandatory {
    return true;
  }

  /// Cookie category identifier.
  ///
  final bool functional, marketing, statistical;
}
