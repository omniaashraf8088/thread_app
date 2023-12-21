import 'package:firebase_with_newapp/models/user_model.dart';

class PostModel {
  final String autherId;
  final DateTime createdAt;
  final UserModel user;
  final String content;
  bool isFavorite = false;

  PostModel(
      {
        required this.content,
        required this.autherId,
        required this.user,
        required this.createdAt}
      );

  factory PostModel.fromJson(Map<String, dynamic> json,
       UserModel user) {
    return PostModel(
        createdAt: DateTime.parse(json['createdAt']),
        content: json['contant'],
        autherId: json['ui'],
        user: user
    );
  }



  Map<String,dynamic> tojson(){
    return{
      'content':content,
      'createdAt':createdAt,
      'autherId':autherId,
    };
  }
}
