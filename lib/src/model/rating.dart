class Rating {
  int? value;
  List<String?> feedbackOptions;
  String? comment;
  String? userId;
  DateTime? submittedAt;

  Rating({
    this.value,
    required this.feedbackOptions,
    this.comment,
    this.userId,
    this.submittedAt,
  });
}
