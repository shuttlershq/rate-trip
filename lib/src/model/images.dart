class ImageUpload {
  List<String>? images;
  String? message;
  bool? success;

  ImageUpload({this.images, this.message, this.success});

  ImageUpload.fromJson(Map<String, dynamic> json) {
    images = json['data'].cast<String>();
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = images;
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}
