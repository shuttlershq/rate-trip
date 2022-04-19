class Settings {
  String? settingId;
  String? userAvatar;
  String? driverName;
  String? driverAvatar;
  String? vehicleName;
  String? vehicleNumber;
  Map<String, dynamic>? metadata;

  Settings({
    required this.settingId,
    this.userAvatar,
    this.driverName,
    this.driverAvatar,
    this.vehicleName,
    this.vehicleNumber,
    this.metadata,
  });

  Settings.fromJson(Map<String, dynamic> json) {
    settingId = json['settingId'];
    userAvatar = json['user_avatar'];
    driverName = json['driver_name'];
    driverAvatar = json['driver_avatar'];
    vehicleName = json['vehicle_name'];
    vehicleNumber = json['vehicle_number'];
    metadata = json['parameters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['settingId'] = settingId;
    data['user_avatar'] = userAvatar;
    data['driver_name'] = driverName;
    data['driver_avatar'] = driverAvatar;
    data['vehicle_name'] = vehicleName;
    data['vehicle_number'] = vehicleNumber;
    data['parameters'] = metadata;
    return data;
  }
}
