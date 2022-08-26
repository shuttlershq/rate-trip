// import 'dart:convert';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:rate_trip/src/model/model.dart';

// void main() {
//   late Settings settings;
//   dynamic json;
//   group('Test Settings model', () {
//     setUp(() async {
//       const file = """{
//         "settingId": "1",
//         "parameters": {
//           "language": "en",
//           "currency": "USD",
//           "theme": "light"
//         },
//     "user_avatar": "userAvatar",
//     "driver_name": "driverName",
//     "driver_avatar": "driverAvatar",
//     "vehicle_name": "vehicleName",
//     "vehicle_number": "vehicleNumber"}""";
//       json = jsonDecode(file);
//       settings = Settings.fromJson(json);
//     });
//     test('Check it is a valid object', () {
//       expect(settings.runtimeType, equals(Settings));
//     });
//     test('Check if it is equivalent to its json', () {
//       expect(settings.toJson(), equals(json));
//     });
//     // test('Check active loan class', () {
//     //   expect(ActiveLoan(me: null).account, equals(null));
//     // });
//     // test('Check account class', () {
//     //   expect(Account(applications: null, portfolios: null).applications,
//     //       equals(null));
//     // });
//     // test('Check portfolio class', () {
//     //   expect(Portfolios(nodes: null).nodes, equals(null));
//     // });
//     // test('Check portfolio node class', () {
//     //   expect(PortfolioNodes(amount: 60000).amount, equals(60000));
//     // });
//     // test('Check status class', () {
//     //   expect(Status(name: 'APPROVED').name, equals('APPROVED'));
//     // });
//     // test('Check repayment class', () {
//     //   expect(Repayments(id: '001').id, equals('001'));
//     // });
//     // test('Check histories class', () {
//     //   expect(Histories(nodes: null).nodes, equals(null));
//     // });
//     // test('Check portfolio class', () {
//     //   expect(Nodes(comment: 'Paid').comment, equals('Paid'));
//     // });
//   });
// }
