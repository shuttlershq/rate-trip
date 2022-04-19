import 'package:rate_trip/src/service/api/api.dart';

import '../../model/rating.dart';
import 'rating_service_contract.dart';

class RatingService implements RatingServiceContract {
  String ratingUri = "/ratings";
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
}
