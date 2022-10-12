import 'package:test_app/Model/customerdetail.dart';

class LoginResponse {
  List<CustomerDetailsModel>? customerDetails;
  String? mobileNo;
  String? userToken;
  String? applicationName;
  String? companyLogo;
  String? splashScreen;
  String? settingLogo;
  String? isCommitteeMenuDisplay;
  String? isActivePaymentGateway;
  String? paymentType;
  String? isCommitteeMember;
  String? isPrivacy;
  String? isVisitorPermission;
  String? chatEnable;
  bool? webHelpScr;
  bool? androidHelpScr;
  bool? iosHelpScr;
  String? checkPayment;
  String? checkLicnce;
  String? supportMobileNo;
  String? supportEmail;
  bool? isFirstLogin;
  String? isStaffPermission;
  bool? isNotification;
  bool? isUnitExpired;

  LoginResponse(
      {this.customerDetails,
      this.mobileNo,
      this.userToken,
      this.applicationName,
      this.companyLogo,
      this.splashScreen,
      this.settingLogo,
      this.isCommitteeMenuDisplay,
      this.isActivePaymentGateway,
      this.paymentType,
      this.isCommitteeMember,
      this.isPrivacy,
      this.isVisitorPermission,
      this.chatEnable,
      this.webHelpScr,
      this.androidHelpScr,
      this.iosHelpScr,
      this.checkPayment,
      this.checkLicnce,
      this.supportMobileNo,
      this.supportEmail,
      this.isFirstLogin,
      this.isStaffPermission,
      this.isNotification,
      this.isUnitExpired});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['CustomerDetails'] != null) {
      customerDetails = <CustomerDetailsModel>[];
      json['CustomerDetails'].forEach((v) {
        customerDetails!.add(new CustomerDetailsModel.fromJson(v));
      });
    }
    mobileNo = json['MobileNo'];
    userToken = json['UserToken'];
    applicationName = json['ApplicationName'];
    companyLogo = json['CompanyLogo'];
    splashScreen = json['SplashScreen'];
    settingLogo = json['SettingLogo'];
    isCommitteeMenuDisplay = json['IsCommitteeMenuDisplay'];
    isActivePaymentGateway = json['IsActivePaymentGateway'];
    paymentType = json['PaymentType'];
    isCommitteeMember = json['IsCommitteeMember'];
    isPrivacy = json['IsPrivacy'];
    isVisitorPermission = json['IsVisitorPermission'];
    chatEnable = json['ChatEnable'];
    webHelpScr = json['WebHelpScr'];
    androidHelpScr = json['AndroidHelpScr'];
    iosHelpScr = json['IosHelpScr'];
    checkPayment = json['CheckPayment'];
    checkLicnce = json['CheckLicnce'];
    supportMobileNo = json['SupportMobileNo'];
    supportEmail = json['SupportEmail'];
    isFirstLogin = json['IsFirstLogin'];
    isStaffPermission = json['IsStaffPermission'];
    isNotification = json['IsNotification'];
    isUnitExpired = json['IsUnitExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerDetails != null) {
      data['CustomerDetails'] =
          this.customerDetails!.map((v) => v.toJson()).toList();
    }
    data['MobileNo'] = this.mobileNo;
    data['UserToken'] = this.userToken;
    data['ApplicationName'] = this.applicationName;
    data['CompanyLogo'] = this.companyLogo;
    data['SplashScreen'] = this.splashScreen;
    data['SettingLogo'] = this.settingLogo;
    data['IsCommitteeMenuDisplay'] = this.isCommitteeMenuDisplay;
    data['IsActivePaymentGateway'] = this.isActivePaymentGateway;
    data['PaymentType'] = this.paymentType;
    data['IsCommitteeMember'] = this.isCommitteeMember;
    data['IsPrivacy'] = this.isPrivacy;
    data['IsVisitorPermission'] = this.isVisitorPermission;
    data['ChatEnable'] = this.chatEnable;
    data['WebHelpScr'] = this.webHelpScr;
    data['AndroidHelpScr'] = this.androidHelpScr;
    data['IosHelpScr'] = this.iosHelpScr;
    data['CheckPayment'] = this.checkPayment;
    data['CheckLicnce'] = this.checkLicnce;
    data['SupportMobileNo'] = this.supportMobileNo;
    data['SupportEmail'] = this.supportEmail;
    data['IsFirstLogin'] = this.isFirstLogin;
    data['IsStaffPermission'] = this.isStaffPermission;
    data['IsNotification'] = this.isNotification;
    data['IsUnitExpired'] = this.isUnitExpired;
    return data;
  }
}
