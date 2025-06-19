import 'package:chat_app/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:dio/dio.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:google_fonts/google_fonts.dart';

class Imbd extends StatefulWidget {
  const Imbd({super.key});

  @override
  State<Imbd> createState() => _ImbdState();
}

class _ImbdState extends State<Imbd> {
  TextEditingController moviesearch = new TextEditingController();
  Map<String, dynamic>? result;
  final con = GestureFlipCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.yellow, Colors.black],
                  // transform: GradientRotation(14),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  tileMode: TileMode.mirror,
                ),
              ),

              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              child: Stack(
                children: [
                  Positioned(
                    top: 60,
                    left: 70,
                    child: Container(
                      child: GradientAnimationText(
                        transform: GradientRotation(34),
                        text: Text(
                          "Welcome To IMDB",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        colors: [
                          Colors.black,
                          Colors.black12,
                          Colors.black,

                          // Colors.black12,
                          // Colors.black,
                        ],
                        duration: Duration(seconds: 6),
                        reverse: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 110, left: 80),
                    width: 250,
                    child: AnimatedTextField(
                      controller: moviesearch,
                      animationType: Animationtype
                          .typer, // Use Animationtype.typer for Type Write Style animations
                      hintTextStyle: const TextStyle(
                        color: Colors.deepPurple,
                        overflow: TextOverflow.ellipsis,
                      ),
                      hintTexts: const [
                        'Avengers Endgame',
                        'Mission Impossible',
                        'Final Destination',
                      ],
                      decoration: InputDecoration(
                        suffixIcon: moviesearch.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  moviesearch.clear();
                                },
                                icon: Icon(Icons.close),
                              )
                            : Icon(Icons.search),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 100,
                    child: AnimatedButton(
                      height: 50,
                      width: 200,
                      text: 'Search',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: Colors.black,
                      borderColor: Colors.black,
                      borderRadius: 50,
                      
                      borderWidth: 2,
                      onPress: () {
                        // fetchMovie(moviesearch.text);
                        if (moviesearch.text.isNotEmpty) {
                          context.read<ImdbBloc>().add(
                            Fetchmovie(query: moviesearch.text),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 250),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: BlocBuilder<ImdbBloc, ImdbState>(
                            builder: (context, state) {
                              if (state is ImdbLoading) {
                                return Center(child: const CircularProgressIndicator());
                              }
                              if (state is ImdbLoaded) {
                                result = state.movies;
                                print("The results are from bloc are :$result");
                                return Column(
                                  children: [
                                    GestureFlipCard(
                                      controller: con,

                                      axis: FlipAxis.vertical,
                                      enableController: true,

                                      animationDuration: const Duration(
                                        seconds: 3,
                                      ),
                                      frontWidget: Center(
                                        child: Container(
                                          // margin: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            border: GradientBoxBorder(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.yellow,
                                                  Colors.black,
                                                  Colors.yellowAccent,
                                                ],
                                              ),
                                              width: 4,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              0,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.yellow,
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                offset: Offset(0, 4),
                                              ),
                                              BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                offset: Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,

                                          height: 500,
                                          // width: 190,
                                          child: Image.network(
                                            result?["Poster"] ?? "No Name",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      backWidget: Container(
                                        margin: EdgeInsets.only(
                                          right: 60,
                                          left: 60,
                                        ),

                                        decoration: BoxDecoration(
                                          border: GradientBoxBorder(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.yellow,
                                                Colors.black,
                                                Colors.yellowAccent,
                                              ],
                                            ),
                                            width: 4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            70,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.yellow,
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: Offset(0, 4),
                                            ),
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: AnimatedButton(
                                          height: 50,
                                          animatedOn: AnimatedOn.onTap,
                                          // width: 200,
                                          text: 'Movie Details',
                                          isReverse: true,
                                          selectedTextColor: Colors.white,
                                          transitionType:
                                              TransitionType.CENTER_LR_IN,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),
                                          // backgroundColor: Colors.yellowAccent,
                                          gradient: LinearGradient(
                                            colors: [Colors.yellow,Colors.black, Colors.yellow],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            tileMode: TileMode.clamp,
                                          ),
                                          // borderColor: Colors.white,
                                          borderRadius: 50,
                                          selectedBackgroundColor: Colors.black,
                                          
                                          borderWidth: 2,
                                          onPress: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  alertbox(result),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              if (state is ImdbError) {
                                print("The Error is : ${state.error}");
                                return Center(
                                  child: Text("OOPs No Movie Found With  ${moviesearch.text}",
                                  style: GoogleFonts.permanentMarker(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget RowText(String title, String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontFamily: 'Times New Roman',
          // fontSize: 20,
        ),
      ),
      Spacer(),
      Flexible(
        child: Text(
          text,
          overflow: TextOverflow.visible,
          // maxLines: 3,
          softWrap: true,
          style: GoogleFonts.permanentMarker(color: Colors.white),
        ),
      ),
    ],
  );
}

Widget alertbox(Map<String, dynamic>? result) {
  return AlertDialog(
    backgroundColor: Colors.black, // black background
    title: Text(
      "Movie Overview",
      style: TextStyle(color: Colors.white), // white title
    ),
    content: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 400, // adjust this height as needed
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(), // enables drag scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowText("Title", result?["Title"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Year", result?["Year"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Rated", result?["Rated"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Released", result?["Released"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Runtime", result?["Runtime"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Genre", result?["Genre"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Director", result?["Director"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Writer", result?["Writer"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Actors", result?["Actors"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Plot", result?["Plot"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Language", result?["Language"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Country", result?["Country"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Awards", result?["Awards"] ?? "No name"),
            SizedBox(height: 10),
            RowText("Ratings", result?["imdbRating"] ?? "No name"),
            SizedBox(height: 10),
            RowText("BoxOffice", result?["BoxOffice"] ?? "No name"),
            SizedBox(height: 10),

          ],
        ),
      ),
    ),
 
  );
}
