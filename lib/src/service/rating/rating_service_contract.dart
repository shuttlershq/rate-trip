import 'dart:io';

import '../../model/images.dart';
import '../../model/rating.dart';

abstract class RatingServiceContract {
  Future<dynamic> rateTrip(Rating rating);
  Future<ImageUpload?>? uploadImages({List<File> files});
}
