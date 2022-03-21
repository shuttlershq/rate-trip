import 'rating_category.dart';
import 'settings.dart';

class Trip {
  Settings? settings;
  List<RatingCategory>? categories;

  Trip({this.settings, this.categories});
}
