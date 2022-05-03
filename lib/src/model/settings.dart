class Settings {
  String? settingId;
  String? userAvatar;
  String? driverName;
  String? driverAvatar;
  String? vehicleName;
  String? vehicleNumber;
  String? driverFallbackAvatar;
  String? userFallbackAvatar;
  Map<String, dynamic>? metadata;

  Settings({
    required this.settingId,
    required this.driverFallbackAvatar,
    this.driverName,
    this.driverAvatar,
    this.vehicleName,
    this.vehicleNumber,
    this.metadata,
  }) : assert(driverFallbackAvatar != null && driverFallbackAvatar != '');

  Settings.fromJson(Map<String, dynamic> json) {
    settingId = json['settingId'];
    driverName = json['driver_name'];
    driverAvatar = json['driver_avatar'];
    vehicleName = json['vehicle_name'];
    vehicleNumber = json['vehicle_number'];
    metadata = json['parameters'];
    driverFallbackAvatar = json['driver_fallback_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['settingId'] = settingId;
    data['driver_name'] = driverName;
    data['driver_avatar'] = driverAvatar;
    data['vehicle_name'] = vehicleName;
    data['vehicle_number'] = vehicleNumber;
    data['parameters'] = metadata;
    data['driver_fallback_avatar'] = driverFallbackAvatar;
    return data;
  }
}
