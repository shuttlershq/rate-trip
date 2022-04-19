import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_trip/src/model/model.dart';

void main() {
  late RatingCategoryOptions options;
  dynamic json;
  group('Test Settings model', () {
    setUp(() async {
      const file = """{
    "name": "driverName",
    "reference": "driverAvatar",
    "category_id": "vehicleName"
}""";
      json = jsonDecode(file);
      options = RatingCategoryOptions.fromJson(json);
    });
    test('Check it is a valid object', () {
      expect(options.runtimeType, equals(RatingCategoryOptions));
    });
    test('Check if it is equivalent to its json', () {
      expect(options.toJson(), equals(json));
    });
  });
}
