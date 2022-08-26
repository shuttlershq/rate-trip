class Settings {
  String? settingId;
  String? busAvatar;
  String? driverName;
  String? driverAvatar;
  String? vehicleName;
  String? vehicleNumber;
  String? driverFallbackAvatar;
  String? routeCode;
  Map<String, dynamic>? metadata;

  Settings({
    required this.settingId,
    required this.driverFallbackAvatar,
    this.driverName,
    this.driverAvatar,
    this.vehicleName,
    this.vehicleNumber,
    this.metadata,
    this.routeCode,
    required this.busAvatar,
  })  : assert(driverFallbackAvatar != null && driverFallbackAvatar != ''),
        assert(busAvatar != null && busAvatar != '');
}
