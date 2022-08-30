class Settings {
  String? settingId;
  String busAvatar;
  String? driverName;
  String? userAvatar;
  String? vehicleName;
  String? vehicleNumber;
  String userFallbackAvatar;
  String? routeCode;
  Map<String, dynamic>? metadata;

  Settings({
    required this.settingId,
    required this.userFallbackAvatar,
    this.driverName,
    this.userAvatar,
    this.vehicleName,
    this.vehicleNumber,
    this.metadata,
    this.routeCode,
    required this.busAvatar,
  });
}
