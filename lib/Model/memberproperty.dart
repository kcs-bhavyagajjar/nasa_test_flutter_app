class MemberPropertyInfo {
  String? propertyName;
  int? unitId;
  int? accountHeadId;
  String? accountName;
  String? towerName;
  String? gstNo;

  MemberPropertyInfo(
      {this.propertyName,
      this.unitId,
      this.accountHeadId,
      this.accountName,
      this.towerName,
      this.gstNo});

  MemberPropertyInfo.fromJson(Map<String, dynamic> json) {
    propertyName = json['PropertyName'];
    unitId = json['UnitId'];
    accountHeadId = json['AccountHeadId'];
    accountName = json['AccountName'];
    towerName = json['TowerName'];
    gstNo = json['GSTNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PropertyName'] = this.propertyName;
    data['UnitId'] = this.unitId;
    data['AccountHeadId'] = this.accountHeadId;
    data['AccountName'] = this.accountName;
    data['TowerName'] = this.towerName;
    data['GSTNo'] = this.gstNo;
    return data;
  }
}
