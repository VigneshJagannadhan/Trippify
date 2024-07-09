class UserModel {
  String? userId;
  String? name;
  String? email;
  String? createdDate;

  UserModel(
    this.userId,
    this.name,
    this.email,
    this.createdDate,
  );

  UserModel.fromJson(Map<String, dynamic> data) {
    userId = data['user_id'];
    name = data['name'];
    email = data['email'];
    createdDate = data['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['created_date'] = createdDate;
    return data;
  }
}
