import 'rating_category.dart';
import 'settings.dart';

class Trip {
  String token;
  String? tripId;
  Settings? settings;
  List<RatingCategory>? categories;

  Trip({
    required this.settings,
    this.categories = const [],
    required this.tripId,
    required this.token,
  });
}
