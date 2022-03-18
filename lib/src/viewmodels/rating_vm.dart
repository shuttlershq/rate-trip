import 'package:flutter/material.dart';
import 'package:rate_trip/src/model/model.dart';

class RatingVm extends ChangeNotifier {
  /// ! DUMMY
  List<RatingCategory> categories = [
    RatingCategory(name: 'Driver', reference: '1'),
    RatingCategory(name: 'Vehicle', reference: '2'),
    RatingCategory(name: 'Marshals', reference: '3'),
  ];

  List<RatingCategoryOptions> options = [
    RatingCategoryOptions(
        name: 'Rude Driver', ratingCategoryReference: '1', reference: '1'),
    RatingCategoryOptions(
        name: 'Bad AC', ratingCategoryReference: '2', reference: '2'),
    RatingCategoryOptions(
        name: 'Poor communication',
        ratingCategoryReference: '3',
        reference: '3'),
    RatingCategoryOptions(
        name: 'Over speeding', ratingCategoryReference: '1', reference: '4'),
    RatingCategoryOptions(
        name: 'Capacity issues', ratingCategoryReference: '2', reference: '5'),
    RatingCategoryOptions(
        name: 'Abussive', ratingCategoryReference: '3', reference: '6'),
    RatingCategoryOptions(
        name: 'Inexperienced', ratingCategoryReference: '1', reference: '7'),
    RatingCategoryOptions(
        name: 'Dirty', ratingCategoryReference: '2', reference: '8'),
    RatingCategoryOptions(
        name: 'Unfriendly', ratingCategoryReference: '3', reference: '9'),
  ];

  /// ! STAR RATING
  int _starRating = 1;
  int get starRating => _starRating;
  set starRating(int v) {
    _starRating = v;
    notifyListeners();
  }

  /// ! ISSUES CATEGORY OPTIONS
  Map<String, RatingCategoryOptions> _issues = {};
  Map<String, RatingCategoryOptions> get issues => _issues;
  void clearIssues() {
    _issues = {};
    notifyListeners();
  }

  void addIssues(RatingCategoryOptions issue) {
    !_issues.containsKey(issue.reference!) && _issues.keys.length < 5
        ? _issues.putIfAbsent(issue.reference!, () => issue)
        : _issues.remove(issue.reference);
    notifyListeners();
  }

  void removeIssues(RatingCategoryOptions issue) {
    _issues.remove(issue);
    notifyListeners();
  }

  /// ! Upload file
}
