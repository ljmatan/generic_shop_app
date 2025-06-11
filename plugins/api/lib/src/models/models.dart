/// Library defining all of the generic application model classes,
/// alongside their respective serialization methods and properties.
///
/// https://docs.flutter.dev/data-and-backend/serialization/json

// ignore_for_file: unused_element

library;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';
part 'src/model_address.dart';
part 'src/model_category.dart';
part 'src/model_order_draft.dart';
part 'src/model_consent.dart';
part 'src/model_contact.dart';
part 'src/model_legal_entity.dart';
part 'src/model_merchant.dart';
part 'src/model_person.dart';
part 'src/model_price.dart';
part 'src/model_promo_banner.dart';
part 'src/model_review.dart';
part 'src/model_sale_item.dart';
part 'src/model_sale_point.dart';
part 'src/model_shop_search.dart';
part 'src/model_translated.dart';
part 'src/model_user.dart';

/// Base model class definition, with basic properties defined.
///
abstract class _Model {
  _Model({
    required this.id,
    required this.originId,
    this.originUrl,
    this.deleted,
    this.categoryId,
    this.consentIds,
    this.tags,
    this.logs,
    this.originData,
  });

  /// Unique identifier for the GSA service.
  ///
  /// This ID is usually specified by the main system.
  ///
  String? id;

  /// Unique identifier from a 3rd-party service (origin source).
  ///
  /// This ID is usually provided by a remote source.
  ///
  String? originId;

  /// URL address of the origin source material.
  ///
  String? originUrl;

  /// Whether this entity has been marked as deleted.
  ///
  /// Used for the purposes of "soft deletion".
  ///
  bool? deleted;

  /// The identifier for the category applied to this entity.
  ///
  /// For more information, see [GsaModelCategory].
  ///
  String? categoryId;

  /// Identifiers for the terms and conditions rules applied to this object.
  ///
  List<String>? consentIds;

  /// Tags associated with this instance.
  ///
  /// Tags might represent some specific privileges associated with the object, or similar.
  ///
  List<String>? tags;

  /// String-type logs associated with this instance.
  ///
  List<String>? logs;

  /// The model object this class has been derived from.
  ///
  dynamic originData;

  static String _generateRandomString(int length) {
    const chars = ' abcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));
  }

  static int _generateRandomNumber(int length) {
    final random = Random();
    final min = pow(10, length - 1);
    final max = pow(10, length) - 1;
    return min.toInt() + random.nextInt(max.toInt() - min.toInt());
  }

  static double _fromCentum(int value) {
    return double.parse((value / 100).toStringAsFixed(2));
  }
}
