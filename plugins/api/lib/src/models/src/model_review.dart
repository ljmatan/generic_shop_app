part of '../models.dart';

/// Model representing item reviews with a rating and a comment.
///
@JsonSerializable(explicitToJson: true)
class GsaModelReview extends _Model {
  // ignore: public_member_api_docs
  GsaModelReview({
    super.id,
    super.originId,
  });

  double? rating;

  String? comment;

  String? timeCreatedIso8601;

  /// Creation time in the [DateTime] format.
  ///
  DateTime? get timeCreated => timeCreatedIso8601 != null ? DateTime.tryParse(timeCreatedIso8601!) : null;

  // ignore: public_member_api_docs
  factory GsaModelReview.fromJson(Map json) {
    return _$GsaModelReviewFromJson(Map<String, dynamic>.from(json));
  }

  // ignore: public_member_api_docs
  Map<String, dynamic> toJson() {
    return _$GsaModelReviewToJson(this);
  }
}
