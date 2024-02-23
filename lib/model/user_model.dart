const String collectionUser = 'Users';

const String userFieldId = 'userId';

const String userFieldEmail = 'email';

class UserModel {
  String userId;

  String email;

  UserModel({required this.userId, required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      userFieldId: userId,
      userFieldEmail: email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        userId: map[userFieldId],
        email: map[userFieldEmail],
      );
}
