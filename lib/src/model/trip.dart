import 'rating_category.dart';
import 'service_settings.dart';
import 'settings.dart';

class Trip {
  String token;
  String? tripId;
  Settings? settings;
  ServiceSettings? serviceSettings;
  List<RatingCategory>? categories;

  Trip({
    required this.settings,
    required this.serviceSettings,
    this.categories = const [],
    required this.tripId,
    required this.token,
  });
}
