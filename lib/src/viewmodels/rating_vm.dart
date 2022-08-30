import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rate_trip/src/service/api/api.dart';
import 'package:rate_trip/src/service/image/image.dart';
import 'package:rate_trip/src/service/rating/rating.dart';
import '../model/model.dart';
import 'package:path/path.dart' as path;

enum RatingState {
  initial,
  loading,
  loaded,
  error,
}

class RatingVm extends ChangeNotifier {
  ImageServiceContract imageService = ImageService();
  late HttpServiceContract httpService;
  late RatingServiceContract ratingService;

  bool _disposed = false;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  RatingState _state = RatingState.initial;
  RatingState get state => _state;
  setState(RatingState value) {
    _state = value;
    if (!_disposed && hasListeners) notifyListeners();
  }

  String? errorMessage;
  String? get error => errorMessage;

  RatingVm({required Trip trip}) {
    _trip = trip;
    httpService = HttpService(_trip.baseUrl, apiDebugMode: kDebugMode);
    httpService.setToken(trip.token);
    ratingService = RatingService(httpService);
  }

  late Trip _trip;
  Trip get trip => _trip;
  set trip(Trip value) {
    _trip = value;
    if (!_disposed && hasListeners) notifyListeners();
  }

  /// ! STAR RATING
  int? _starRating;
  int? get starRating => _starRating;
  set starRating(int? v) {
    _starRating = v;
    if (!_disposed && hasListeners) notifyListeners();
  }

  List<String> _uploadedImages = [];
  List<String> get uploadedImages => _uploadedImages;
  set uploadedImages(List<String> value) {
    _uploadedImages = value;
    if (!_disposed && hasListeners) notifyListeners();
  }

  /// ! RATING CATEGORY OPTIONS;
  final List<RatingCategoryOptions> _options = [];
  List<RatingCategoryOptions> get options => _options;

  /// ! COMMENT
  String _comment = '';
  String get comment => _comment;
  set comment(String v) {
    _comment = v;
    if (!_disposed && hasListeners) notifyListeners();
  }

  /// ! CONTROLLER
  TextEditingController commentField = TextEditingController();

  /// ! ISSUES CATEGORY OPTIONS
  Map<String, RatingCategoryOptions> _issues = {};
  Map<String, RatingCategoryOptions> get issues => _issues;
  void clearIssues() {
    _issues = {};
    if (!_disposed && hasListeners) notifyListeners();
  }

  void addIssues(RatingCategoryOptions issue) {
    !_issues.containsKey(issue.reference!) &&
            _issues.keys.length < (trip.serviceSettings.maxValue ?? 5)
        ? _issues.putIfAbsent(issue.reference!, () => issue)
        : _issues.remove(issue.reference);
    if (!_disposed && hasListeners) notifyListeners();
  }

  void removeIssues(RatingCategoryOptions issue) {
    _issues.remove(issue.reference);
    if (!_disposed && hasListeners) notifyListeners();
  }

  /// ! SEND RATING
  Rating get rating {
    return Rating(
      settings: trip.settings,
      feedbackOptions: _issues.values.toList(),
      comment: _comment.isEmpty ? ' ' : _comment,
      value: _starRating,
      images: uploadedImages,
    );
  }

  bool canPickIssues() {
    if (_starRating == null || _starRating == 0) {
      return false;
    }

    if (_starRating != null &&
        _starRating! <= (_trip.serviceSettings.threshold ?? 3)) {
      return true;
    }

    return false;
  }

  bool canSend() {
    if (_starRating == null || _starRating == 0) {
      return false;
    }
    return (_starRating! > (trip.serviceSettings.threshold ?? 3) &&
            _issues.isEmpty) ||
        (_issues.length <= (trip.serviceSettings.maxValue ?? 5) &&
            _issues.length >= (trip.serviceSettings.minValue ?? 1) &&
            (_starRating! <= (trip.serviceSettings.threshold ?? 3) &&
                _starRating! > 0));
  }

  /// ! UPLOAD FILES

  final List<File> _images = [];
  List<File> get images => _images;
  Future<bool> getFileGallery({BuildContext? context}) async {
    final File? file = await imageService.pickImage();

    if (file != null) {
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 5) {
        errorMessage = 'Image greater than 5MB';
        notifyListeners();
        return false;
      } else {
        String dir = path.dirname(file.path);
        String newPath = path.join(dir, 'IMG_${_images.length + 1}.jpg');
        File npicture = file.renameSync(newPath);
        _images.add(npicture);
        notifyListeners();
        return true;
      }
    }
    errorMessage = 'Can\'t pick file';
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
        errorMessage = response.toString();
        setState(RatingState.error);
      }
    } catch (e) {
      errorMessage = e.toString();
      setState(RatingState.error);
    }
  }
}
