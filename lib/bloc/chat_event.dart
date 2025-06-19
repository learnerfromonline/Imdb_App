part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}
abstract class ImdbEvent {}

class Fetchmovie extends ImdbEvent{
  final String query;
  Fetchmovie({required this.query});

}