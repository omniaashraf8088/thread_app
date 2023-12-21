part of 'time_line_cubit.dart';
@immutable
abstract class TimeLineState {}
class TimeLineInitial extends TimeLineState {}
final  class TimeLineLoaded extends TimeLineState {
  final List<PostModel> posts;
  TimeLineLoaded(this.posts);
}
final  class TimeLineLoading extends TimeLineState {}
final class TimeLineError extends TimeLineState{
  final String message;
  TimeLineError(this.message);
}