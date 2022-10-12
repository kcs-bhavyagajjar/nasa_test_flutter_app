class LoginModel {
  String? Firstname;
  String? Middlename;
  String? Lastname;
  String? email;
  String? pass;
  String? mobile;
  String? Groupvalue;
  String? Singlevalue;

  LoginModel(
      {this.email,
      this.pass,
      this.Firstname,
      this.Lastname,
      this.Middlename,
      this.mobile,
      this.Groupvalue,
      this.Singlevalue});

  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    pass = json['pass'];
    Firstname = json['Firstname'];
    Middlename = json['MiddleName'];
    Lastname = json['Lastname'];
    mobile = json['Mobile'];
    Groupvalue = json['Groupvalue'];
    Singlevalue = json['Singlevalue'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['email'] = email;
    data['pass'] = pass;
    data['Firstname'] = Firstname;
    data['Middlename'] = Middlename;
    data['Lastname'] = Lastname;
    data['Mobile'] = mobile;
    data['Groupvalue'] = Groupvalue;
    data['Singlevalue'] = Singlevalue;
    return data;
  }
}
