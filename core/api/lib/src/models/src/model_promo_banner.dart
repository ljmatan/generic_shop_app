part of '../models.dart';

/// Dashboard promotional content model.
///
@JsonSerializable(explicitToJson: true)
class GsaModelPromoBanner extends _Model {
  // ignore: public_member_api_docs
  GsaModelPromoBanner({
    super.id,
    super.originId,
    required this.label,
    required this.description,
    required this.contentUrl,
    required this.photoUrl,
    this.photoBase64,
  });

  /// Title or label associated with this promotional content.
  ///
  String? label;

  /// The description text of this promotional content.
  ///
  String? description;

  /// URL redirection property defining the content origin source.
  ///
  String? contentUrl;

  /// Image resource address associated with this promotional content.
  ///
  String? photoUrl;

  /// Byte data specified for a photo, used instead of relying on a [photoUrl] implementation.
  ///
  String? photoBase64;

  // ignore: public_member_api_docs
  factory GsaModelPromoBanner.fromJson(Map json) {
    return _$GsaModelPromoBannerFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelPromoBannerToJson(this);
  }

  // ignore: public_member_api_docs
  factory GsaModelPromoBanner.mock() {
    return GsaModelPromoBanner(
      label: _Model._generateRandomString(12),
      description: _Model._generateRandomString(40),
      contentUrl: 'https://example.org',
      photoUrl: 'https://picsum.photos/${1000 + Random().nextInt(100)}/${1600 + Random().nextInt(100)}',
      photoBase64: null,
    );
  }
}
