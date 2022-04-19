import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:rate_trip/src/model/model.dart';

void main() {
  late RatingCategory category;
  dynamic json;
  group('Test Settings model', () {
    setUp(() async {
      const file = """{
    "name": "driverName",
    "reference": "driverAvatar",
    "options": [
        {
            "name": "driverName",
            "reference": "driverAvatar",
            "category_id": "vehicleName"
        },
        {
            "name": "driverName",
            "reference": "driverAvatar",
            "category_id": "vehicleName"
        }
    ]
}""";
      json = jsonDecode(file);
      category = RatingCategory.fromJson(json);
    });
    test('Check it is a valid object', () {
      expect(category.runtimeType, equals(RatingCategory));
    });
    test('Check if it is equivalent to its json', () {
      expect(category.toJson(), equals(json));
    });
  });
}
