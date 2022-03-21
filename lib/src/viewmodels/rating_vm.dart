import 'package:flutter/material.dart';
import 'package:rate_trip/src/model/model.dart';

class RatingVm extends ChangeNotifier {
  /// ! STAR RATING
  int _starRating = 0;
  int get starRating => _starRating;
  set starRating(int v) {
    _starRating = v;
    notifyListeners();
  }

  /// ! COMMENT
  String? _comment;
  String get comment => _comment!;
  set comment(String v) {
    _comment = v;
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

  /// ! SEND RATING
  Rating get rating {
    return Rating(
      feedbackOptions: _issues.values.map((e) => e.name).toList(),
      comment: _comment,
      submittedAt: DateTime.now(),
      userId: 'id',
      value: _starRating,
    );
  }

  bool canSend() {
    return _issues.isNotEmpty && _comment != null && _starRating != 0;
  }
}
