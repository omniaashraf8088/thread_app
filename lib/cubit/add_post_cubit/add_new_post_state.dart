part of 'add_new_post_cubit.dart';

@immutable
abstract class AddNewPostState {}

class AddNewPostInitial extends AddNewPostState {}
class AddNewPostLoading extends AddNewPostState {}
class AddNewPostLoaded extends AddNewPostState {}
class AddNewPostError extends AddNewPostState {
  final String message;
  AddNewPostError(this.message);
}
