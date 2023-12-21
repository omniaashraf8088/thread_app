import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_newapp/utils/firebase_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_new_post_state.dart';

class AddNewPostCubit extends Cubit<AddNewPostState> {
  AddNewPostCubit() : super(AddNewPostInitial());
  final TextEditingController controller=TextEditingController(text: "'ياااااااااااااااااااااااااااارب'");
  Future<void>addPost( BuildContext context) async {
    emit(AddNewPostLoading());
    try {
      if (controller.text.isNotEmpty) {
        // final id = FirebaseFirestore.instance.doc('post').id;
        await FirebaseFirestore.instance.collection(CollectionNames.postCollection).add({
          'contant': controller.text,
          'ui': FirebaseAuth.instance.currentUser?.uid,
          'createdAt': DateTime.now().toString(),
        });
        controller.clear();
        //Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.cyan,
          content: Text(' process is success'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(' process is failed'),
          backgroundColor: Colors.red,
        ));
      }
    } on Exception catch (e) {
      // TODO
    }
  }
}
