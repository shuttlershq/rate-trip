import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_trip/rate_trip.dart';
import 'package:rate_trip/src/service/image/image_service_contract.dart';
import 'package:rate_trip/src/viewmodels/rating_vm.dart';

import '../mocks.dart';
import 'dart:io';

void main() {
  late ImageServiceContract imageService;
  late RatingVm model;
  late MockBuildContext context;
  late Trip trip;

  late final File mockStorageFile;
  late final File secondMockStorageFile;

  setUpAll(() {
    imageService = MockImageService();
    trip = Trip(
      baseUrl: "https://api.test.shuttlers.africa/rating",
      tripId: '23',
      token:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mzg2LCJjb3Jwb3JhdGVfaWQiOjEsImZuYW1lIjoiRGFvZHUiLCJsbmFtZSI6IkFqaXQiLCJlbWFpbCI6ImRhb2R1YWppdC10ZXN0QGdtYWlsLmNvbSIsInBob25lIjoiMDkwNTIyMjI4NTYiLCJwYXNzd29yZCI6IiQyYSQxMCQyNExHN2VQRmdnRG90VGY1RXVBWS5ldHVldDk3T2UwZ2g4RTdQMHBzcGdsa2I2R0NLNU94RyIsImFjdGl2ZSI6IjEiLCJhdmF0YXIiOiJodHRwczovL3NodXR0bGVycy1hdmF0YXJzLnMzLnVzLWVhc3QtMi5hbWF6b25hd3MuY29tL3VzZXItMzg2LWJuWGJNNWdEekUuanBlZyIsImNvZGUiOiJhOWJmODQ4MC00MDY4LTExZWMtOThhYy00YmI0YTM4NDFmMDMtMzg2IiwiY3JlYXRlZF9hdCI6IjIwMTgtMDYtMDlUMTU6MjY6MTguMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTAzLTE2VDA3OjIxOjMzLjAwMFoiLCJnZW5kZXIiOiJtYWxlIiwiZG9iIjpudWxsLCJjYXJfb3duZXIiOiIwIiwibmZjX2lkIjoiMGE1Y2JiNjAtMmQ4Yy00YzM5LTg2MzktNTYxNzBlOGU3YWM1Iiwic3RhZmZfaWQiOm51bGwsImNsaWVudF9pZCI6bnVsbCwibG9jYXRpb24iOm51bGwsInZlcmlmaWVkX2F0IjpudWxsLCJjaXR5X2lkIjpudWxsLCJsb2dpbl9yZW1vdGVfYWRkcmVzcyI6IjE3Mi4yMC40Ni4yOSIsImxvZ2luX2RhdGVfdGltZSI6IjIwMjItMDMtMTZUMDA6MDA6MDAuMDAwWiIsImxvZ2luX2lzX3N1Y2Nlc3NmdWwiOjEsImJsb2NrZWRfcmVhc29uIjpudWxsLCJpc19ibG9ja2VkIjowLCJibG9ja2VkX2F0IjpudWxsLCJzaWduX3VwX3NvdXJjZSI6Imd1ZXN0X21vZGUiLCJjb3VudHJ5X2NvZGUiOiJORyIsInBob25lX3ZlcmlmaWVkX2F0IjpudWxsLCJ1c2VyVHlwZSI6bnVsbCwiaWF0IjoxNjQ3NDMzNzk0LCJleHAiOjE2Nzg5Njk3OTR9.a3AQVUcsS2FwNvFqEn5TBgggnDvl3QeDkKdQwxiYi70',
      settings: Settings(
          driverFallbackAvatar: 'assets/images/user.png',
          busAvatar: 'assets/images/bus_icon.png',
          settingId: 'fdc3f58d-ddfe-41fa-a344-873f0c56d768',
          driverAvatar:
              "https://shuttlers-avatars.s3.us-east-2.amazonaws.com/user-386-bnXbM5gDzE.jpeg",
          driverName: "Mufasa Bigson",
          vehicleName: "Toyota Coaster Bus",
          vehicleNumber: "S21",
          metadata: {
            "trip_id": "23",
            "vehicle_id": "1",
            "driver_id": "1",
          }),
      categories: [
        RatingCategory(
          name: 'Test Category 1',
          reference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
          options: [
            RatingCategoryOptions(
                name: 'Cat 1 Option 1',
                ratingCategoryReference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
                reference: '58f44845-cec2-4971-a254-2ba867ef73b0'),
            RatingCategoryOptions(
                name: 'Cat 1 Option 2',
                ratingCategoryReference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
                reference: 'aa85e53c-7f2b-4474-9557-b8da41d52643'),
            RatingCategoryOptions(
                name: 'Cat 1 Option 3',
                ratingCategoryReference: '4639ca18-8702-4e09-aac5-2ab313c2f70a',
                reference: 'c9ba73d4-a8b9-4105-97bd-b098b4f533a4'),
          ],
        ),
        RatingCategory(
          name: 'Test Category',
          reference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
          options: [
            RatingCategoryOptions(
                name: 'Cat Option 1',
                ratingCategoryReference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
                reference: '5699045a-b799-4a7e-aecd-bb7929eed638'),
            RatingCategoryOptions(
                name: 'Cat Option 2',
                ratingCategoryReference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
                reference: '955eb9d7-8788-432a-9bea-8c50d582da6b'),
            RatingCategoryOptions(
                name: 'Cat Option 3',
                ratingCategoryReference: '485c76f4-adf5-4d77-be46-b5b9efa2cf0d',
                reference: '9ca1a8e1-f353-4514-a167-64d2057d4c56'),
          ],
        ),
        RatingCategory(
          name: 'Test Category 2',
          reference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
          options: [
            RatingCategoryOptions(
                name: 'Cat 2 Option 2',
                ratingCategoryReference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
                reference: '0ed9b653-11ee-446e-942e-57cca24414ed'),
            RatingCategoryOptions(
                name: 'Cat 2 Option 3',
                ratingCategoryReference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
                reference: '30888d7e-8a35-472f-8999-9b6b88b508d6'),
            RatingCategoryOptions(
                name: 'Cat 2 Option 1',
                ratingCategoryReference: 'f7b92bba-9e27-4957-a34a-1fb0aec62609',
                reference: '6492acbc-6b5f-4fa8-b16b-195446f8a5a4'),
          ],
        ),
      ],
      serviceSettings: ServiceSettings(
        createdAt: DateTime.now().toIso8601String(),
        incrementsBy: 1,
        maxValue: 5,
        minValue: 1,
        threshold: 3,
        name: 'some settings',
        reference: 'some-settings-reference',
        serviceId: 'trip_rating_service',
        parameters: 'some parameters',
      ),
    );
    model = RatingVm(imgService: imageService, trip: trip);
    context = MockBuildContext();

    mockStorageFile = MockFile();
    secondMockStorageFile = MockFile();
    when(() async => await imageService.pickImage())
        .thenAnswer((_) async => mockStorageFile);
    when(() => mockStorageFile.lengthSync()).thenReturn(2 * 1024 * 1024);
    when(() => mockStorageFile.path).thenReturn("mockStorageFile");
  });

  group('RatingViewmodelTest -', () {
    /// ! TEST FOR SENDING
    group('canSend -', () {
      test('When instantiated/constructed canSend should be false', () {
        expect(model.canSend(), false);
      });

      test(
          'When constructed and all conditions not met canSubmit should be false',
          () {
        // var model = RatingVm(trip: );
        model.starRating = 2;
        expect(model.canSend(), false);
      });

      test(
          'When constructed and rating >= 4 with no isses or comments canSubmit should be true',
          () {
        // var model = RatingVm(token: 'someToken');
        model.starRating = 4;
        expect(model.canSend(), true);
      });

      test(
          'When constructed and rating >= 4 with isses canSubmit should be false',
          () {
        // var model = RatingVm(token: 'someToken');
        model.starRating = 4;
        var options = RatingCategoryOptions(
            name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
        model.addIssues(options);
        expect(model.canSend(), false);
      });

      test(
          'When constructed and rating < 4 with no isses or comments canSubmit should be false',
          () {
        // var model = RatingVm(token: 'someToken');
        model.starRating = 3;
        expect(model.canSend(), false);
      });

      test(
          'When constructed and rating < 3 with isses not up to 5 canSubmit should be false',
          () {
        // var model = RatingVm(token: 'someToken');
        model.starRating = 3;
        var options = RatingCategoryOptions(
            name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
        model.addIssues(options);
        expect(model.canSend(), false);
      });
    });
  });

  /// ! TEST FOR ADDING COMMENT
  group('can add comment -', () {
    test('When constructed comment should be null', () {
      // var model = RatingVm(token: 'someToken');
      expect(model.comment, null);
    });

    test('After setting comment, comment shouldn\'t be empty', () {
      // var model = RatingVm(token: 'someToken');
      model.comment = "Some random comment";
      expect(model.comment, "Some random comment");
    });
  });

  /// ! TEST FOR GIVING STAR
  group('can assign a star rating -', () {
    test('When constructed star rating should be 0', () {
      // var model = RatingVm(token: 'someToken');
      expect(model.starRating, null);
    });

    test('Check star rating sets correctly', () {
      // var model = RatingVm(token: 'someToken');
      model.starRating = 2;
      expect(model.starRating, 2);
    });
  });

  /// ! TEST FOR ISSUES CATEGORY
  group('can add and remove issue -', () {
    test('When constructed issues should be empty', () {
      // var model = RatingVm(token: 'someToken');
      expect(model.issues.isEmpty, true);
    });

    test('Check can add issues correctly', () {
      // var model = RatingVm(token: 'someToken');
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      expect(model.issues.containsValue(options), true);
    });

    test('Check tapping an issue twice removes the issue correctly', () {
      // var model = RatingVm(token: 'someToken');
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      model.addIssues(options);
      expect(model.issues.containsValue(options), false);
    });

    test('Check can remove issues correctly', () {
      // var model = RatingVm(token: 'someToken');
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      model.removeIssues(options);
      expect(model.issues.containsValue(options), false);
    });

    test('Check can clear issues correctly', () {
      // var model = RatingVm(token: 'someToken');
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      model.clearIssues();
      expect(model.issues.isEmpty, true);
    });
  });

  /// ! TEST FOR ISSUES CATEGORY
  group('can add and remove issue options -', () {
    test('When constructed issues options should be empty', () {
      // var model = RatingVm(token: 'someToken');
      expect(model.options.isEmpty, true);
    });

    test('Check passing options from trip model works correctly', () {
      // var model = RatingVm(token: 'someToken');
      trip.categories?.forEach((element) {
        element.options?.forEach((element) {
          model.options.add(element);
        });
      });
      expect(model.options.length, 9);
    });
  });

  /// ! TEST FOR SETTINGS
  group('can add settings -', () {
    test('Can pass settings to trip object', () {
      var settings = Settings(
        settingId: '2',
        driverAvatar: "assets/images/user_icon.png",
        driverName: "Mufasa Bigson",
        vehicleName: "Toyota Coaster Bus",
        vehicleNumber: "S21",
        busAvatar: 'assets/images/bus_icon.png',
        driverFallbackAvatar: 'assets/images/bus_icon.png',
      );
      // model.
      Trip trip = Trip(
        baseUrl: 'someUrl',
        settings: settings,
        token: 'someToken',
        tripId: '2',
        serviceSettings: ServiceSettings(
          threshold: 3,
          minValue: 5,
        ),
      );
      expect(trip.settings!.vehicleNumber, "S21");
    });
  });

  /// ! TEST FOR RATING OBJECT
  group('Rating object tests -', () {
    // test('When constructed, rating comment should be empty', () {
    //   // var model = RatingVm(token: 'someToken');
    //   expect(model.rating.comment, null);
    // });

    test('When constructed, rating feedbackOptions should be empty', () {
      // var model = RatingVm(token: 'someToken');
      expect(model.rating.feedbackOptions.isEmpty, true);
    });

    test('When constructed, rating images should be empty', () {
      // var model = RatingVm(token: 'someToken');
      expect(model.rating.images!.isEmpty, true);
    });

    // test('When constructed, rating value should be zero', () {
    //   // var model = RatingVm(token: 'someToken');
    //   expect(model.rating.value, 0);
    // });
  });

  /// ! TEST FOR FILE UPLOADS
  /// group('RatingViewmodelTest -', () {
  group('can pick file -', () {
    test('pick image', () async {
      await model.getFileGallery(context: context);
      expect(model.images.isEmpty, false);
    });

    test('delete image', () async {
      model.deleteImage(mockStorageFile);
      expect(model.images.isEmpty, true);
    });

    group('cant pick file > 3MB-', () {
      setUp(() {
        when(() async => await imageService.pickImage())
            .thenAnswer((_) async => secondMockStorageFile);
        when(() => secondMockStorageFile.lengthSync())
            .thenReturn(3 * 1024 * 1024);
        when(() => secondMockStorageFile.path)
            .thenReturn("secondMockStorageFile");
      });

      test('pick image > 3MB', () async {
        var met = await model.getFileGallery(context: context);
        expect(met, false);
        expect(model.images.contains(secondMockStorageFile), false);
      });
    });
  });
}
