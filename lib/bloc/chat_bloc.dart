import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
final dio = Dio();

class ImdbBloc extends Bloc<ImdbEvent, ImdbState> {
     
  ImdbBloc() : super(ImdbInitial()) {
    on<Fetchmovie>((event, emit) async{
      emit(ImdbLoading());
      // Duration(seconds: 5);
      try{
        final response = await dio.get("https://www.omdbapi.com/",queryParameters: {'t':event.query,'apikey':"db749aeb"});
        if (response.data['Response'] == 'True') {
          var movies = response.data;
          print("The res is :${movies}");
          emit(ImdbLoaded(movies: movies));
        } else {
          emit(ImdbError(error: response.data['Error']));
        }
      }
      catch (e){
        emit(ImdbError(error: e.toString()));
      }
    });
  }
}