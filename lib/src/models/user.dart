class User {
  User({this.id, this.fullName, this.email, this.userRole});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'] as String,
        fullName = data['fullName'] as String,
        email = data['email'] as String,
        userRole = data['userRole'] as String;

  final String id;
  final String fullName;
  final String email;
  final String userRole;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fullName': fullName,
        'email': email,
        'userRole': userRole,
      };
}
