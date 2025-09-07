part of 'theme.dart';

/// Defines standardized text styles.
///
/// This enum enforces a **typography system** that ensures consistent sizing,
/// weight, and color usage across the app.
///
/// Each variant corresponds to a semantic role in UI design, not just a font size.
/// This way, design intent is preserved.
///
enum GsaThemeTextStyles {
  /// Small supporting text, often used for secondary labels or helper messages.
  ///
  /// Example: Timestamp under a message.
  ///
  small,

  /// Default text for paragraphs or regular content.
  ///
  /// Example: Body copy, form inputs, basic UI text.
  ///
  regular,

  /// Slightly larger than [regular] for emphasis.
  ///
  /// Example: Emphasized content, secondary section text.
  ///
  medium,

  /// Larger body text, often used for buttons or emphasized labels.
  ///
  /// Example: Settings menu items.
  ///
  large,

  /// A page or section title.
  ///
  /// Example: "Account Settings" heading.
  ///
  title,

  /// Subtitle or secondary heading.
  ///
  /// Example: Subsection label under a title.
  ///
  subtitle,

  /// Very small text, typically de-emphasized.
  ///
  /// Example: Captions under images or icons.
  ///
  caption,

  /// Text style used for actionable buttons.
  ///
  /// Example: "SUBMIT", "SAVE".
  ///
  button,

  /// Prominent heading text, larger than [title].
  ///
  /// Example: Section headers, dashboard labels.
  ///
  headline,

  /// Very large display text, for emphasis or branding.
  ///
  /// Example: Onboarding hero text, welcome screens.
  ///
  display,

  /// Error messages or validation feedback.
  ///
  /// Example: "Password is too short".
  ///
  error,

  /// Styled for hyperlinks or clickable text.
  ///
  /// Example: "Terms and Conditions".
  ///
  url;

  /// Retrieve the value of a [TextStyle] for this [GsaWidgetTextStyle] entry.
  ///
  TextStyle get value {
    switch (this) {
      case GsaThemeTextStyles.small:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.2,
        );

      case GsaThemeTextStyles.regular:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.4,
        );

      case GsaThemeTextStyles.medium:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.4,
        );

      case GsaThemeTextStyles.large:
        return const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 1.4,
        );

      case GsaThemeTextStyles.title:
        return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.3,
        );

      case GsaThemeTextStyles.subtitle:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF666666),
        );

      case GsaThemeTextStyles.caption:
        return const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: Color(0xFF999999),
        );

      case GsaThemeTextStyles.button:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.25,
        );

      case GsaThemeTextStyles.headline:
        return const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        );

      case GsaThemeTextStyles.display:
        return const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          height: 1.1,
        );

      case GsaThemeTextStyles.error:
        return const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFFD32F2F),
        );

      case GsaThemeTextStyles.url:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1976D2),
          decoration: TextDecoration.underline,
        );
    }
  }
}
