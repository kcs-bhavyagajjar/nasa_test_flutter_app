import 'package:test_app/Model/memberproperty.dart';
import 'package:test_app/Model/userdetailmodel.dart';

class CustomerDetailsModel {
  int? iD;
  String? customerName;
  String? customerAddress;
  String? requireKey;
  String? userId;
  String? outStandingAmt;
  UserDetail? userDetail;
  List<MemberPropertyInfo>? memberPropertyInfo;
  String? identityType;

  CustomerDetailsModel(
      {this.iD,
      this.customerName,
      this.customerAddress,
      this.requireKey,
      this.userId,
      this.outStandingAmt,
      this.userDetail,
      this.memberPropertyInfo,
      this.identityType});

  CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    customerName = json['CustomerName'];
    customerAddress = json['CustomerAddress'];
    requireKey = json['RequireKey'];
    userId = json['UserId'];
    outStandingAmt = json['OutStandingAmt'];
    userDetail = json['UserDetail'] != null
        ? new UserDetail.fromJson(json['UserDetail'])
        : null;
    if (json['MemberPropertyInfo'] != null) {
      memberPropertyInfo = <MemberPropertyInfo>[];
      json['MemberPropertyInfo'].forEach((v) {
        memberPropertyInfo!.add(new MemberPropertyInfo.fromJson(v));
      });
    }
    identityType = json['IdentityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CustomerName'] = this.customerName;
    data['CustomerAddress'] = this.customerAddress;
    data['RequireKey'] = this.requireKey;
    data['UserId'] = this.userId;
    data['OutStandingAmt'] = this.outStandingAmt;
    if (this.userDetail != null) {
      data['UserDetail'] = this.userDetail!.toJson();
    }
    if (this.memberPropertyInfo != null) {
      data['MemberPropertyInfo'] =
          this.memberPropertyInfo!.map((v) => v.toJson()).toList();
    }
    data['IdentityType'] = this.identityType;
    return data;
  }
}
