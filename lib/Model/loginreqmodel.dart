class LoginRequestModel {
  String? deviceBrand;
  String? deviceModel;
  String? deviceOSVersion;
  String? deviceType;
  String? operatingSystem;
  String? city;
  String? county;
  String? deviceId;
  String? deviceToken;
  String? ipAddress;
  String? latitude;
  String? longitude;
  String? mobileNo;
  String? password;
  String? state;
  String? timeZone;

  LoginRequestModel(
      {this.deviceBrand,
      this.deviceModel,
      this.deviceOSVersion,
      this.deviceType,
      this.operatingSystem,
      this.city,
      this.county,
      this.deviceId,
      this.deviceToken,
      this.ipAddress,
      this.latitude,
      this.longitude,
      this.mobileNo,
      this.password,
      this.state,
      this.timeZone});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeviceBrand'] = this.deviceBrand;
    data['DeviceModel'] = this.deviceModel;
    data['DeviceOSVersion'] = this.deviceOSVersion;
    data['DeviceType'] = this.deviceType;
    data['OperatingSystem'] = this.operatingSystem;
    data['City'] = this.city;
    data['County'] = this.county;
    data['DeviceId'] = this.deviceId;
    data['DeviceToken'] = this.deviceToken;
    data['IpAddress'] = this.ipAddress;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['MobileNo'] = this.mobileNo;
    data['Password'] = this.password;
    data['State'] = this.state;
    data['TimeZone'] = this.timeZone;
    return data;
  }
}
