

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_newapp/models/post_model.dart';
import 'package:firebase_with_newapp/models/user_model.dart';
import 'package:firebase_with_newapp/utils/firebase_keys.dart';
import 'package:flutter/material.dart';

part 'time_line_state.dart';

class TimeLineCubit extends Cubit<TimeLineState> {
  TimeLineCubit() : super(TimeLineInitial());

  void getTimeLine() async {
    try {
      emit(TimeLineLoading());

      final posts = await FirebaseFirestore.instance
          .collection(CollectionNames.postCollection)
          .get();
      final List<PostModel> listOfPosts=[];
      for (final post in posts.docs) {
        final fetchedUser = await FirebaseFirestore.instance
            .collection(CollectionNames.userCollection)
            .where('userId', isEqualTo: post.data()['ui'])
            .get();
        final user=UserModel.fromJson(fetchedUser.docs.first.data());
        print('user id is ${user.toJson()}');
        final modelPost=PostModel.fromJson(post.data(),user);
        listOfPosts.add(modelPost);
      }
      emit(TimeLineLoaded(listOfPosts));
    } catch (e) {
      emit(TimeLineError(e.toString()));
      print(e.toString());
      // TODO
    }
  }
}
