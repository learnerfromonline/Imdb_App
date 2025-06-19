part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}
abstract class ImdbState {}

class ChatInitial extends ChatState {}

class ImdbInitial extends ImdbState{

}
class ImdbLoading extends ImdbState{

}
class ImdbLoaded extends ImdbState{
  final Map<String,dynamic> movies;
  ImdbLoaded( {required this.movies});
}
class ImdbError extends ImdbState{
  final String error;
  ImdbError({required this.error});
}
