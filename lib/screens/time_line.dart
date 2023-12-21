import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_newapp/cubit/timeline_cubit/time_line_cubit.dart';
import 'package:firebase_with_newapp/models/post_model.dart';
import 'package:firebase_with_newapp/utils/firebase_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  // bool isFavorite = false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   context.read<TimeLineCubit>().getTimeLine();
  //   initializeDateFormatting();
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: BlocProvider(
        create: (context) => TimeLineCubit()..getTimeLine(),
        child: BlocBuilder<TimeLineCubit, TimeLineState>(
          builder: (context, state) {
            if (state is TimeLineLoaded) {
              log(state.posts.length.toString(), name: "TimeLineLoaded");
              if (state.posts.isEmpty) {
                return const Center(child: Text("List Is Empty!!!"));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final PostModel postItem = state.posts[index];
                  final data = DateFormat.yMEd('ar').format(postItem.createdAt);

                  return Column(
                    children: [
                      ListTile(
                        title: Text(postItem.user.name),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(postItem.user.photo),
                        ),
                        subtitle: Text(postItem.content),
                        trailing: Text(
                          data.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                postItem.isFavorite = !postItem.isFavorite;
                              });
                              if (postItem.isFavorite) {
                                FirebaseFirestore.instance
                                    .collection(
                                        CollectionNames.favoriteCollection)
                                    .add({
                                  'userId':
                                      FirebaseAuth.instance.currentUser?.uid,
                                  // 'postId':PostItem,
                                });
                              }
                            },
                            icon: Icon(
                              postItem.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: postItem.isFavorite ? Colors.red : null,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.comment_outlined)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.repeat_outlined)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.share)),
                        ],
                      ),
                    ],
                  );
                },
              );
            }
            if (state is TimeLineError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
