class UserModel{
  final String name;
  final String id;
  final String profile;
  final String password;
  final String email;
  final String phoneNumber;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.name,
    required this.id,
    required this.profile,
    required this.password,
    required this.email,
    required this.phoneNumber,
  });


  UserModel copyWith({
    String? name,
    String? id,
    String? profile,
    String? password,
    String? email,
    String? phoneNumber,
  }) {
    return UserModel(
      name: name ?? this.name,
      id: id ?? this.id,
      profile: profile ?? this.profile,
      password: password ?? this.password,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'profile': profile,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name']??"",
      id: map['id']??"",
      profile: map['profile']??"",
      password: map['password']??"",
      email: map['email']??"",
      phoneNumber: map['phoneNumber']??"",
    );
  }

//</editor-fold>
}