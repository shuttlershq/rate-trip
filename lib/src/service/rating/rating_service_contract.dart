import '../../model/rating.dart';

abstract class RatingServiceContract {
  Future<dynamic> rateTrip(Rating rating);
}
