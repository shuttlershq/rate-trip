import 'package:flutter_test/flutter_test.dart';
import 'package:rate_trip/rate_trip.dart';
import 'package:rate_trip/src/viewmodels/rating_vm.dart';

void main() {
  group('RatingViewmodelTest -', () {
    /// ! TEST FOR SENDING
    group('canSend -', () {
      test('When constructed canSend should be false', () {
        var model = RatingVm();
        expect(model.canSend(), false);
      });

      test('When constructed canSubmit should be false', () {
        var model = RatingVm();
        model.starRating = 2;
        expect(model.canSend(), false);
      });
    });
  });

  /// ! TEST FOR ADDING COMMENT
  group('can add comment -', () {
    test('When constructed comment should be null', () {
      var model = RatingVm();
      expect(model.comment, null);
    });

    test('After setting comment, comment shouldn\'t be empty', () {
      var model = RatingVm();
      model.comment = "Some random comment";
      expect(model.comment, "Some random comment");
    });
  });

  /// ! TEST FOR GIVING STAR
  group('can assign a star rating -', () {
    test('When constructed star rating should be 0', () {
      var model = RatingVm();
      expect(model.starRating, 0);
    });

    test('Check star rating sets correctly', () {
      var model = RatingVm();
      model.starRating = 2;
      expect(model.starRating, 2);
    });
  });

  /// ! TEST FOR ISSUES CATEGORY
  group('can add and remove issue -', () {
    test('When constructed issues should be empty', () {
      var model = RatingVm();
      expect(model.issues.isEmpty, true);
    });

    test('Check can add issues correctly', () {
      var model = RatingVm();
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      expect(model.issues.containsValue(options), true);
    });

    test('Check tapping an issue twice removes the issue correctly', () {
      var model = RatingVm();
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      model.addIssues(options);
      expect(model.issues.containsValue(options), false);
    });

    test('Check can remove issues correctly', () {
      var model = RatingVm();
      var options = RatingCategoryOptions(
          name: 'Unfriendly', ratingCategoryReference: '3', reference: '9');
      model.addIssues(options);
      model.removeIssues(options);
      expect(model.issues.containsValue(options), false);
    });

    test('Check can clear issues correctly', () {
      var model = RatingVm();
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
      var model = RatingVm();
      expect(model.options.isEmpty, true);
    });

    test('Check passing options from trip model works correctly', () {
      var model = RatingVm();
      Trip trip = Trip(
          settings: Settings(
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
  // TODO:
  /// ! TEST FOR RATING OBJECT
  /// ! TEST FOR FILE UPLOADS
}
