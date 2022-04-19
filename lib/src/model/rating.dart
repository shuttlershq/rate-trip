import 'dart:io';

import '../../rate_trip.dart';

class Rating {
  Settings? settings;
  int? value;
  List<RatingCategoryOptions?> feedbackOptions;
  String? comment;
  List<File>? images;

  Rating({
    this.settings,
    this.value,
    required this.feedbackOptions,
    this.comment,
    this.images,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['setting_id'] = settings?.settingId;
    data['issues'] = feedbackOptions
        .map((e) => {
              'option_id': e?.reference,
            })
        .toList();
    data['star'] = value;
    data['details'] = comment;
    data['parameters'] = settings?.metadata;
    data['media'] = images?.map((e) => e.path).toList();
    return data;
  }
}
