import 'package:flutter/cupertino.dart';

import '../../rate_trip.dart';

class RatingService {
  BuildContext context;
  Trip trip;

  RatingService({
    required this.context,
    required this.trip,
  });

  /// Starts rating trip
  Future<void> rate() async {
    return Navigator.push<void>(
      context,
      CupertinoPageRoute(
        builder: (context) => RateTrip(
          trip: trip,
        ),
      ),
    );
  }
}
