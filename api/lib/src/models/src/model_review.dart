import 'package:generic_shop_app_architecture/gsar.dart';

/// Model representing item reviews with a rating and a comment.
///
@GsarModelMacro()
class GsaaModelReview {
  double? rating;

  String? comment;

  String? timeCreatedIso8601;

  /// Creation time in the [DateTime] format.
  ///
  DateTime? get timeCreated => timeCreatedIso8601 != null ? DateTime.tryParse(timeCreatedIso8601!) : null;
}
