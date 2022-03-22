import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rate_trip/src/model/model.dart';
import 'package:path/path.dart' as path;

class RatingVm extends ChangeNotifier {
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
    !_issues.containsKey(issue.reference!) && _issues.keys.length < 5
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
      feedbackOptions: _issues.values.map((e) => e.name).toList(),
      comment: _comment,
      submittedAt: DateTime.now(),
      userId: 'id',
      value: _starRating,
      images: _images,
    );
  }

  bool canSend() {
    return _issues.isNotEmpty && _comment != null && _starRating != 0;
  }

  /// ! UPLOAD FILES
  final List<File> _images = [];
  List<File> get images => _images;
  Future<void> getFileGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? result = await _picker.pickImage(source: ImageSource.camera);

    if (result != null) {
      final file = File(result.path);
      int sizeInBytes = file.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb > 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uploaded file should be less than 2mb'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        File picture = File(result.path);
        String dir = path.dirname(result.path);
        String newPath = path.join(dir, 'IMG_${_images.length + 1}.jpg');
        File npicture = picture.renameSync(newPath);
        _images.add(npicture);
      }
    }
    notifyListeners();
  }

  void deleteImage(File file) {
    _images.remove(file);
    notifyListeners();
  }
}
