class UserResponse {
  String userId;
  String email;
  DateTime dateOfBirth;
  String gender;
  String displayName;
  bool emailVerified;
  String phoneNumber;
  String? photoUrl;
  String role;
  DateTime lastSignIn;
  bool disabled;

  UserResponse({
    required this.userId,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.displayName,
    required this.emailVerified,
    required this.phoneNumber,
    this.photoUrl,
    required this.role,
    required this.lastSignIn,
    required this.disabled,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json['userId'],
      email: json['email'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      displayName: json['displayName'],
      emailVerified: json['emailVerified'],
      phoneNumber: json['phoneNumber'],
      photoUrl: json['photoUrl'],
      role: json['role'],
      lastSignIn: DateTime.parse(json['lastSignIn']),
      disabled: json['disabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'displayName': displayName,
      'emailVerified': emailVerified,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'role': role,
      'lastSignIn': lastSignIn.toIso8601String(),
      'disabled': disabled,
    };
  }
}