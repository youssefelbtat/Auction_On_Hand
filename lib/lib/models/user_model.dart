class UserModel {
  String? userId;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? picture;
  String? address1;
  String? address2;
  String? phone;
  String? userName;
  bool? isEmailVerified;
  int? numOfPoints;

  UserModel(
      {this.userId,
      this.email,
        this.password,
      this.firstName,
      this.lastName,
      this.picture,
      this.address1,
      this.address2,
      this.phone,
      this.userName,
      this.isEmailVerified,
      this.numOfPoints});

  UserModel.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) {
      return;
    }
    userId = json['uId'];
    email = json['email'];
    password=json['passWord'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
    address1 = json['address1'];
    address2 = json['address2'];
    userName = json['uName'];
    phone = json['phone'];
    isEmailVerified = json['isEmail'];
    numOfPoints = json['numPoints'];
  }

  toJson() {
    return {
      'uId': userId,
      'email': email,
      'passWord':password,
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
      'address1': address1,
      'address2': address2,
      'uName': userName,
      'phone': phone,
      'isEmail': isEmailVerified,
      'numPoints': numOfPoints,
    };
  }
}
