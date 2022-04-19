import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_trip/src/service/api/api.dart';
import 'package:rate_trip/src/service/image/image_service_contract.dart';
import 'package:rate_trip/src/service/rating/rating.dart';

class MockFile extends Mock implements File {}

class MockImageService extends Mock implements ImageServiceContract {}

class MockRatingService extends Mock implements RatingServiceContract {}

class MockHttpService extends Mock implements HttpServiceContract {}

class MockBuildContext extends Mock implements BuildContext {}
