import 'dart:io';

class Rating {
  int? value;
  List<String?> feedbackOptions;
  String? comment;
  String? userId;
  DateTime? submittedAt;
  List<File>? images;

  Rating({
    this.value,
    required this.feedbackOptions,
    this.comment,
    this.images,
    this.userId,
    this.submittedAt,
  });
}
