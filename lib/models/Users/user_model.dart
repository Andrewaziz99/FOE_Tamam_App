class UserModel {
  String? name;
  String? uId;
  bool? isAdmin;

  UserModel({
    this.name,
    this.uId,
    this.isAdmin,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'isAdmin': isAdmin,
    };
  }
}