import 'rating_category_options.dart';

class RatingCategory {
  String? reference;
  String? name;
  List<RatingCategoryOptions>? options;

  RatingCategory({this.reference, this.name, this.options});

  RatingCategory.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    name = json['name'];
    if (json['options'] != null) {
      options = <RatingCategoryOptions>[];
      json['options'].forEach((v) {
        options!.add(RatingCategoryOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reference'] = reference;
    data['name'] = name;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
