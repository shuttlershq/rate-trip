class ServiceSettings {
  String? reference;
  String? name;
  int? threshold;
  int? minValue;
  int? maxValue;
  int? incrementsBy;
  String? serviceId;
  String? parameters;
  String? createdAt;

  ServiceSettings(
      {this.reference,
      this.name,
      this.threshold,
      this.minValue,
      this.maxValue,
      this.incrementsBy,
      this.serviceId,
      this.parameters,
      this.createdAt});

  ServiceSettings.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    name = json['name'];
    threshold = json['threshold'];
    minValue = json['min_value'];
    maxValue = json['max_value'];
    incrementsBy = json['increments_by'];
    serviceId = json['service_id'];
    parameters = json['parameters'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reference'] = reference;
    data['name'] = name;
    data['threshold'] = threshold;
    data['min_value'] = minValue;
    data['max_value'] = maxValue;
    data['increments_by'] = incrementsBy;
    data['service_id'] = serviceId;
    data['parameters'] = parameters;
    data['created_at'] = createdAt;
    return data;
  }
}
