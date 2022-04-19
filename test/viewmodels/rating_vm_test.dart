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

  late final File mockStorageFile;
  late final File secondMockStorageFile;

  setUpAll(() {
    imageService = MockImageService();
    model = RatingVm(imgService: imageService, token: 'someToken');
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
        var model = RatingVm(token: 'someToken');
        model.starRating = 2;
        expect(model.canSend(), false);
      });

      test(
          'When constructed and rating >= 4 with no isses or comments canSubmit should be true',
          () {
        var model = RatingVm(token: 'someToken');
        model.starRating = 4;
        expect(model.canSend(), true);
      });

      test(
          'When constructed and rating >= 4 with isses canSubmit should be false',
          () {
        var model = RatingVm(token: 'someToken');
        model.starRating = 4;
        var options = RatingCategoryOptions(
            name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
        model.addIssues(options);
        expect(model.canSend(), false);
      });

      test(
          'When constructed and rating < 4 with no isses or comments canSubmit should be false',
          () {
        var model = RatingVm(token: 'someToken');
        model.starRating = 3;
        expect(model.canSend(), false);
      });

      test(
          'When constructed and rating < 4 with isses not up to 5 canSubmit should be false',
          () {
        var model = RatingVm(token: 'someToken');
        model.starRating = 4;
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
      var model = RatingVm(token: 'someToken');
      expect(model.comment, null);
    });

    test('After setting comment, comment shouldn\'t be empty', () {
      var model = RatingVm(token: 'someToken');
      model.comment = "Some random comment";
      expect(model.comment, "Some random comment");
    });
  });

  /// ! TEST FOR GIVING STAR
  group('can assign a star rating -', () {
    test('When constructed star rating should be 0', () {
      var model = RatingVm(token: 'someToken');
      expect(model.starRating, 0);
    });

    test('Check star rating sets correctly', () {
      var model = RatingVm(token: 'someToken');
      model.starRating = 2;
      expect(model.starRating, 2);
    });
  });

  /// ! TEST FOR ISSUES CATEGORY
  group('can add and remove issue -', () {
    test('When constructed issues should be empty', () {
      var model = RatingVm(token: 'someToken');
      expect(model.issues.isEmpty, true);
    });

    test('Check can add issues correctly', () {
      var model = RatingVm(token: 'someToken');
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      expect(model.issues.containsValue(options), true);
    });

    test('Check tapping an issue twice removes the issue correctly', () {
      var model = RatingVm(token: 'someToken');
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      model.addIssues(options);
      expect(model.issues.containsValue(options), false);
    });

    test('Check can remove issues correctly', () {
      var model = RatingVm(token: 'someToken');
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      model.removeIssues(options);
      expect(model.issues.containsValue(options), false);
    });

    test('Check can clear issues correctly', () {
      var model = RatingVm(token: 'someToken');
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
      var model = RatingVm(token: 'someToken');
      expect(model.options.isEmpty, true);
    });

    test('Check passing options from trip model works correctly', () {
      var model = RatingVm(token: 'someToken');
      Trip trip = Trip(
          token: 'someToken',
          tripId: '2',
          settings: Settings(
            settingId: '2',
            driverAvatar: "assets/images/bus_icon.png",
            driverName: "Mufasa Bigson",
            userAvatar: "assets/images/user_icon.png",
            vehicleName: "Toyota Coaster Bus",
            vehicleNumber: "S21",
          ),
          categories: [
            RatingCategory(
              name: 'Driver',
              reference: '1',
              options: [
                RatingCategoryOptions(
                    name: 'Rude Driver',
                    ratingCategoryReference: '1',
                    reference: '1'),
                RatingCategoryOptions(
                    name: 'Over speeding',
                    ratingCategoryReference: '1',
                    reference: '4'),
                RatingCategoryOptions(
                    name: 'Inexperienced',
                    ratingCategoryReference: '1',
                    reference: '7'),
              ],
            ),
            RatingCategory(
              name: 'Vehicle',
              reference: '2',
              options: [
                RatingCategoryOptions(
                    name: 'Bad AC',
                    ratingCategoryReference: '2',
                    reference: '2'),
                RatingCategoryOptions(
                    name: 'Capacity issues',
                    ratingCategoryReference: '2',
                    reference: '5'),
                RatingCategoryOptions(
                    name: 'Dirty',
                    ratingCategoryReference: '2',
                    reference: '8'),
              ],
            ),
            RatingCategory(
              name: 'Marshals',
              reference: '3',
              options: [
                RatingCategoryOptions(
                    name: 'Poor communication',
                    ratingCategoryReference: '3',
                    reference: '3'),
                RatingCategoryOptions(
                    name: 'Abussive',
                    ratingCategoryReference: '3',
                    reference: '6'),
                RatingCategoryOptions(
                    name: 'Unfriendly',
                    ratingCategoryReference: '3',
                    reference: '9'),
              ],
            ),
          ]);
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
        driverAvatar: "assets/images/bus_icon.png",
        driverName: "Mufasa Bigson",
        userAvatar: "assets/images/user_icon.png",
        vehicleName: "Toyota Coaster Bus",
        vehicleNumber: "S21",
      );
      // model.
      Trip trip = Trip(settings: settings, token: 'someToken', tripId: '2');
      expect(trip.settings!.vehicleNumber, "S21");
    });
  });

  /// ! TEST FOR RATING OBJECT
  group('Rating object tests -', () {
    test('When constructed, rating comment should be empty', () {
      var model = RatingVm(token: 'someToken');
      expect(model.rating.comment, null);
    });

    test('When constructed, rating feedbackOptions should be empty', () {
      var model = RatingVm(token: 'someToken');
      expect(model.rating.feedbackOptions.isEmpty, true);
    });

    test('When constructed, rating images should be empty', () {
      var model = RatingVm(token: 'someToken');
      expect(model.rating.images!.isEmpty, true);
    });

    test('When constructed, rating value should be zero', () {
      var model = RatingVm(token: 'someToken');
      expect(model.rating.value, 0);
    });
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
