class Settings {
  String? userAvatar;
  String? driverName;
  String? driverAvatar;
  String? vehicleName;
  String? vehicleNumber;

  Settings(
      {this.userAvatar,
      this.driverName,
      this.driverAvatar,
      this.vehicleName,
      this.vehicleNumber});

  Settings.fromJson(Map<String, dynamic> json) {
    userAvatar = json['user_avatar'];
    driverName = json['driver_name'];
    driverAvatar = json['driver_avatar'];
    vehicleName = json['vehicle_name'];
    vehicleNumber = json['vehicle_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_avatar'] = userAvatar;
    data['driver_name'] = driverName;
    data['driver_avatar'] = driverAvatar;
    data['vehicle_name'] = vehicleName;
    data['vehicle_number'] = vehicleNumber;
    return data;
  }
}
