class RatingCategoryOptions {
  String? name;
  String? reference;
  String? ratingCategoryReference;

  RatingCategoryOptions(
      {this.name, this.reference, this.ratingCategoryReference});

  RatingCategoryOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    reference = json['reference'];
    ratingCategoryReference = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['reference'] = reference;
    data['category_id'] = ratingCategoryReference;
    return data;
  }
}
