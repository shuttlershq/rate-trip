import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rate_trip/src/model/images.dart';
import 'dart:io';

import 'package:rate_trip/src/service/api/api.dart';

import '../../model/rating.dart';
import 'rating_service_contract.dart';

class RatingService implements RatingServiceContract {
  String ratingUri = "/ratings";
  String imageUri = "/ratings/upload";
  HttpServiceContract? httpService;
  RatingService(this.httpService);

  @override
  Future<dynamic> rateTrip(Rating rating) async {
    try {
      var response = await httpService!.post(ratingUri, body: rating.toJson());
      return response;
    } catch (e) {
      throw 'An error occurred!';
    }
  }

  @override
  Future<ImageUpload?>? uploadImages({List<File> files = const []}) async {
    ImageUpload? images;

    List<MultipartFile> multipartfiles = [];
    for (var item in files) {
      MultipartFile file = await MultipartFile.fromFile(
        item.path,
        filename: item.toString(),
      );
      multipartfiles.add(file);
    }

    var formData = FormData.fromMap({
      'media[]': multipartfiles,
    });

    try {
      var response = await httpService!.post(imageUri, body: formData);
      images = ImageUpload.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return images;
  }
}
