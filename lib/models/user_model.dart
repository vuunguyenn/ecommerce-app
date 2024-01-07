class UserModel{
  String id;
  String? name;
  String email;
  String? phone;

  UserModel({
    required this.id,
    this.name,
    required this.email,
    this.phone,

});
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id:json['id'], name: json['name'], email: json['email'], phone: json['phone'],
    );
  }

}