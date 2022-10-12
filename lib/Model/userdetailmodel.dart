class UserDetail {
  int? userId;
  String? firstName;
  String? lastName;
  String? emailId;
  String? dateOfBirth;
  String? address;
  String? bloodGroup;
  bool? isNotification;
  String? membershipCategoryName;
  String? membershipType;
  String? memberCode;
  String? relation;
  String? middleName;
  String? mobileNo;
  String? image;
  bool? gender;
  String? anniversaryDate;
  String? panDocument;
  String? aadhaarDocument;
  String? voterIdDocument;
  String? drivingLicenceDocument;
  String? identityPhotosName;
  String? panDocumentFullPath;
  String? aadhaarDocumentFullPath;
  String? drivingLicenceDocumentFullPath;
  String? identityPhotosFullPath;
  String? voterIdDocumentFullPath;
  int? idenityDetailId;
  String? contactNo;
  String? whatsAppNo;
  int? unitId;
  int? bindUnitCount;
  double? averageRating;
  String? dateOfJoining;
  String? fromTime;
  String? toTime;
  int? ratingCount;
  String? professionName;
  String? salutation;
  int? unReadNotificationCount;
  String? identityType;
  bool? isGrantPermission;
  bool? isVisitorDefaultCall;

  UserDetail(
      {this.userId,
      this.firstName,
      this.lastName,
      this.emailId,
      this.dateOfBirth,
      this.address,
      this.bloodGroup,
      this.isNotification,
      this.membershipCategoryName,
      this.membershipType,
      this.memberCode,
      this.relation,
      this.middleName,
      this.mobileNo,
      this.image,
      this.gender,
      this.anniversaryDate,
      this.panDocument,
      this.aadhaarDocument,
      this.voterIdDocument,
      this.drivingLicenceDocument,
      this.identityPhotosName,
      this.panDocumentFullPath,
      this.aadhaarDocumentFullPath,
      this.drivingLicenceDocumentFullPath,
      this.identityPhotosFullPath,
      this.voterIdDocumentFullPath,
      this.idenityDetailId,
      this.contactNo,
      this.whatsAppNo,
      this.unitId,
      this.bindUnitCount,
      this.averageRating,
      this.dateOfJoining,
      this.fromTime,
      this.toTime,
      this.ratingCount,
      this.professionName,
      this.salutation,
      this.unReadNotificationCount,
      this.identityType,
      this.isGrantPermission,
      this.isVisitorDefaultCall});

  UserDetail.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    emailId = json['EmailId'];
    dateOfBirth = json['DateOfBirth'];
    address = json['Address'];
    bloodGroup = json['BloodGroup'];
    isNotification = json['IsNotification'];
    membershipCategoryName = json['MembershipCategoryName'];
    membershipType = json['MembershipType'];
    memberCode = json['MemberCode'];
    relation = json['Relation'];
    middleName = json['MiddleName'];
    mobileNo = json['MobileNo'];
    image = json['Image'];
    gender = json['Gender'];
    anniversaryDate = json['AnniversaryDate'];
    panDocument = json['PanDocument'];
    aadhaarDocument = json['AadhaarDocument'];
    voterIdDocument = json['VoterIdDocument'];
    drivingLicenceDocument = json['DrivingLicenceDocument'];
    identityPhotosName = json['IdentityPhotosName'];
    panDocumentFullPath = json['PanDocumentFullPath'];
    aadhaarDocumentFullPath = json['AadhaarDocumentFullPath'];
    drivingLicenceDocumentFullPath = json['DrivingLicenceDocumentFullPath'];
    identityPhotosFullPath = json['IdentityPhotosFullPath'];
    voterIdDocumentFullPath = json['VoterIdDocumentFullPath'];
    idenityDetailId = json['IdenityDetailId'];
    contactNo = json['ContactNo'];
    whatsAppNo = json['WhatsAppNo'];
    unitId = json['UnitId'];
    bindUnitCount = json['BindUnitCount'];
    averageRating = json['AverageRating'];
    dateOfJoining = json['DateOfJoining'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
    ratingCount = json['RatingCount'];
    professionName = json['ProfessionName'];
    salutation = json['Salutation'];
    unReadNotificationCount = json['UnReadNotificationCount'];
    identityType = json['IdentityType'];
    isGrantPermission = json['IsGrantPermission'];
    isVisitorDefaultCall = json['IsVisitorDefaultCall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['EmailId'] = this.emailId;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Address'] = this.address;
    data['BloodGroup'] = this.bloodGroup;
    data['IsNotification'] = this.isNotification;
    data['MembershipCategoryName'] = this.membershipCategoryName;
    data['MembershipType'] = this.membershipType;
    data['MemberCode'] = this.memberCode;
    data['Relation'] = this.relation;
    data['MiddleName'] = this.middleName;
    data['MobileNo'] = this.mobileNo;
    data['Image'] = this.image;
    data['Gender'] = this.gender;
    data['AnniversaryDate'] = this.anniversaryDate;
    data['PanDocument'] = this.panDocument;
    data['AadhaarDocument'] = this.aadhaarDocument;
    data['VoterIdDocument'] = this.voterIdDocument;
    data['DrivingLicenceDocument'] = this.drivingLicenceDocument;
    data['IdentityPhotosName'] = this.identityPhotosName;
    data['PanDocumentFullPath'] = this.panDocumentFullPath;
    data['AadhaarDocumentFullPath'] = this.aadhaarDocumentFullPath;
    data['DrivingLicenceDocumentFullPath'] =
        this.drivingLicenceDocumentFullPath;
    data['IdentityPhotosFullPath'] = this.identityPhotosFullPath;
    data['VoterIdDocumentFullPath'] = this.voterIdDocumentFullPath;
    data['IdenityDetailId'] = this.idenityDetailId;
    data['ContactNo'] = this.contactNo;
    data['WhatsAppNo'] = this.whatsAppNo;
    data['UnitId'] = this.unitId;
    data['BindUnitCount'] = this.bindUnitCount;
    data['AverageRating'] = this.averageRating;
    data['DateOfJoining'] = this.dateOfJoining;
    data['FromTime'] = this.fromTime;
    data['ToTime'] = this.toTime;
    data['RatingCount'] = this.ratingCount;
    data['ProfessionName'] = this.professionName;
    data['Salutation'] = this.salutation;
    data['UnReadNotificationCount'] = this.unReadNotificationCount;
    data['IdentityType'] = this.identityType;
    data['IsGrantPermission'] = this.isGrantPermission;
    data['IsVisitorDefaultCall'] = this.isVisitorDefaultCall;
    return data;
  }
}
