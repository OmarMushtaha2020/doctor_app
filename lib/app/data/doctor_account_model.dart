class DoctorAccountModel {
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic bio;
  dynamic cover;
  dynamic image;

  dynamic password;

  dynamic token;
  dynamic tokenDevice;
  DoctorAccountModel(this.name, this.email, this.phone, this.token,
      this.password, this.bio, this.image, this.cover,{this.tokenDevice});

  DoctorAccountModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
    password = json['password'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    tokenDevice=json['tokenDevice'];
  }

  Map<String, dynamic>? toMAp() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
      'password': password,
      'bio': bio,
      'image': image,
      'cover': cover,
      'tokenDevice':tokenDevice,
    };
  }
}
