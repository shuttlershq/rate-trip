import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rate_trip/src/service/api/api.dart';
import 'package:rate_trip/src/service/image/image.dart';
import 'package:rate_trip/src/service/rating/rating.dart';
import '../model/model.dart';

enum RatingState {
  initial,
  loading,
  loaded,
  error,
}

class RatingVm extends ChangeNotifier {
  static String baseUrl = "https://api.develop.shuttlers.africa/rating";
  ImageServiceContract imageService = ImageService();
  late HttpServiceContract httpService;
  late RatingServiceContract ratingService;

  RatingState _state = RatingState.initial;
  RatingState get state => _state;
  setState(RatingState value) {
    _state = value;
    notifyListeners();
  }

  String? errorMessage;
  String? get error => errorMessage;

  RatingVm({ImageServiceContract? imgService, required String token}) {
    imageService = imgService ?? imageService;
    httpService = HttpService(baseUrl, apiDebugMode: true);
    httpService.setToken(token);
    ratingService = RatingService(httpService);
  }

  Trip? _trip;
  Trip? get trip => _trip;
  set trip(Trip? value) {
    _trip = value;
    notifyListeners();
  }

  /// ! STAR RATING
  int _starRating = 0;
  int get starRating => _starRating;
  set starRating(int v) {
    _starRating = v;
    notifyListeners();
  }

  /// ! RATING CATEGORY OPTIONS;
  final List<RatingCategoryOptions> _options = [];
  List<RatingCategoryOptions> get options => _options;

  /// ! COMMENT
  String? _comment;
  String? get comment => _comment;
  set comment(String? v) {
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
    !_issues.containsKey(issue.reference!) &&
            _issues.keys.length < (trip?.serviceSettings?.minValue ?? 5)
        ? _issues.putIfAbsent(issue.reference!, () => issue)
        : _issues.remove(issue.reference);
    notifyListeners();
  }

  void removeIssues(RatingCategoryOptions issue) {
    _issues.remove(issue.reference);
    notifyListeners();
  }

  /// ! SEND RATING
  Rating get rating {
    return Rating(
      settings: trip?.settings,
      feedbackOptions: _issues.values.toList(),
      comment: _comment,
      value: _starRating,
      images: _images,
    );
  }

  bool canSend() {
    if (_comment == null) {
      return false;
    }
    return (_starRating >= (trip?.serviceSettings?.threshold ?? 4) &&
            _issues.isEmpty) ||
        (_issues.length == (trip?.serviceSettings?.minValue ?? 5) &&
            (_starRating < (trip?.serviceSettings?.threshold ?? 4) &&
                _starRating > 0));
  }

  /// ! UPLOAD FILES

  final List<File> _images = [];
  List<File> get images => _images;
  Future<bool> getFileGallery({BuildContext? context}) async {
    final File? file = await imageService.pickImage();

    if (file != null) {
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 2) {
        return false;
      } else {
        _images.add(file);
        return true;
      }
    }
    notifyListeners();

    throw Exception('Can\'t pick file');
  }

  void deleteImage(File file) {
    _images.remove(file);
    notifyListeners();
  }

  Future<void> rateTrip() async {
    setState(RatingState.loading);
    try {
      var response = await ratingService.rateTrip(rating);
      if (response is Response) {
        setState(RatingState.loaded);
      } else {
        setState(RatingState.error);
        errorMessage = response.toString();
        notifyListeners();
      }
    } catch (e) {
      errorMessage = e.toString();
      setState(RatingState.error);
      notifyListeners();
    }
  }
}
