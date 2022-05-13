import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rate_trip/src/service/api/api.dart';
import 'package:rate_trip/src/service/image/image.dart';
import 'package:rate_trip/src/service/rating/rating.dart';
import '../model/images.dart';
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

  RatingState _state = RatingState.initial;
  RatingState get state => _state;
  setState(RatingState value) {
    _state = value;
    notifyListeners();
  }

  String? errorMessage;
  String? get error => errorMessage;

  RatingVm({ImageServiceContract? imgService, required Trip trip}) {
    _trip = trip;
    imageService = imgService ?? imageService;
    httpService = HttpService(_trip.baseUrl!, apiDebugMode: true);
    httpService.setToken(trip.token!);
    ratingService = RatingService(httpService);
  }

  late Trip _trip;
  Trip get trip => _trip;
  set trip(Trip value) {
    _trip = value;
    notifyListeners();
  }

  /// ! STAR RATING
  int? _starRating;
  int? get starRating => _starRating;
  set starRating(int? v) {
    _starRating = v;
    notifyListeners();
  }

  List<String> _uploadedImages = [];
  List<String> get uploadedImages => _uploadedImages;
  set uploadedImages(List<String> value) {
    _uploadedImages = value;
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
            _issues.keys.length < (trip.serviceSettings?.maxValue ?? 5)
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
      settings: trip.settings,
      feedbackOptions: _issues.values.toList(),
      comment: _comment,
      value: _starRating,
      images: uploadedImages,
    );
  }

  bool canSend() {
    if (_starRating == null || _starRating == 0) {
      return false;
    }
    if (((_comment == null || _comment == '') &&
        _starRating! <= (trip.serviceSettings?.threshold ?? 3))) {
      return false;
    }
    return (_starRating! > (trip.serviceSettings?.threshold ?? 3) &&
            _issues.isEmpty) ||
        (_issues.length <= (trip.serviceSettings?.maxValue ?? 5) &&
            _issues.length >= (trip.serviceSettings?.minValue ?? 1) &&
            (_starRating! <= (trip.serviceSettings?.threshold ?? 3) &&
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
      ImageUpload? imagesUploaded =
          await ratingService.uploadImages(files: _images);
      if (imagesUploaded != null) {
        uploadedImages = imagesUploaded.images!
            .map((e) => e.split('.jpg').first + '.jpg')
            .toList();
      }
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
