import 'package:firebase_with_newapp/cubit/add_post_cubit/add_new_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreenState();
}
class _PostScreenState extends State<PostScreen> {
  bool isLoading = false;
  final addNewPostCubit= AddNewPostCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => addNewPostCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Post'),
          actions: [
            TextButton(onPressed: () {
              addNewPostCubit.addPost(context);
            }, child: const Text('post'))
          ],
        ),
        body: TextFormField(
          controller:addNewPostCubit.controller,
          decoration: const InputDecoration(
              hintText: 'ياااااااااااااااااااااااااااارب'
          ),
          maxLines: 50,
        ),
      ),
    );
  }
}
