import 'rating_category.dart';
import 'service_settings.dart';
import 'settings.dart';

class Trip {
  String? baseUrl;
  String? token;
  String? tripId;
  Settings? settings;
  ServiceSettings? serviceSettings;
  List<RatingCategory>? categories;

  Trip({
    required this.baseUrl,
    required this.settings,
    required this.serviceSettings,
    this.categories = const [],
    required this.tripId,
    required this.token,
  })  : assert(baseUrl != null),
        assert(settings != null),
        assert(serviceSettings != null),
        assert(tripId != null),
        assert(token != null);
}
