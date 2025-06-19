import 'package:chat_app/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
class Button extends StatefulWidget {
  final String query;
  
  final Function(Map<String, dynamic>) onResponse;
  const Button({super.key, required this.query, required this.onResponse});
  
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImdbBloc, ImdbState>(
      builder: (context, state) {
        if (state is ImdbLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ImdbLoaded) {
          widget.onResponse(state.movies);
          return AnimatedButton(
            height: 70,
            width: 200,
            text: 'Explore',
            isReverse: true,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.CENTER_TB_OUT,
            textStyle: TextStyle(color: Colors.black),
            backgroundColor: Colors.black,
            borderColor: Colors.white,
            borderRadius: 50,
            borderWidth: 2,
            onPress: () {
              print("Movie loaded: ${state.movies}");
            },
          );
        }
        if (state is ImdbError) {
          print("The Error is : ${state.error}");
          return AnimatedButton(
            height: 70,
            width: 200,
            text: 'Movie Not Found',
            isReverse: true,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.CENTER_TB_OUT,
            textStyle: TextStyle(color: Colors.black),
            backgroundColor: Colors.redAccent,
            borderColor: Colors.white,
            borderRadius: 50,
            borderWidth: 2,
            onPress: () {},
          );
        }
        return AnimatedButton(
          height: 70,
          width: 200,
          text: 'Search',
          isReverse: true,
          selectedTextColor: Colors.black,
          transitionType: TransitionType.LEFT_TO_RIGHT,
          textStyle: TextStyle(color: Colors.black),
          backgroundColor: Colors.black,
          borderColor: Colors.white,
          borderRadius: 50,
          borderWidth: 2,
          onPress: () {
            final query = widget.query;
            if (query.isNotEmpty) {
              context.read<ImdbBloc>().add(Fetchmovie(query: query));
            }
          },
        );
      },
    );
  }
}


