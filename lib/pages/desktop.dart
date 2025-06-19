import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_app/bloc/chat_bloc.dart'; // Ensure this is your bloc import
import 'package:shimmer_animation/shimmer_animation.dart';

class DesktopApp extends StatefulWidget {
  const DesktopApp({super.key});

  @override
  State<DesktopApp> createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> {
  final TextEditingController moviesearch = TextEditingController();
  Map<String, dynamic>? result;
  final con = GestureFlipCardController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.yellow],
            begin: Alignment.center,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(
          children: [
            // Title and Search Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: GradientAnimationText(
                    transform: GradientRotation(34),
                    text: Text(
                      "🎬 Welcome to IMDB Search",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    colors: [Colors.black, Colors.white, Colors.yellow],
                    duration: const Duration(seconds: 5),
                    reverse: true,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 300,
                  child: AnimatedTextField(
                    controller: moviesearch,
                    animationType: Animationtype.typer,
                    hintTextStyle: const TextStyle(color: Colors.deepPurple),
                    hintTexts: const [
                      'Interstellar',
                      'Avengers: Endgame',
                      'Inception',
                    ],
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => moviesearch.clear(),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                AnimatedButton(
                  height: 50,
                  width: 140,
                  text: 'Search',
                  isReverse: true,
                  selectedTextColor: Colors.black,
                  selectedBackgroundColor: Colors.yellow,
                  transitionType: TransitionType.LEFT_TO_RIGHT,
                  textStyle: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
                  backgroundColor: Colors.black,
                  borderColor: Colors.black,
                  borderRadius: 30,
                  borderWidth: 2,
                  onPress: () {
                    if (moviesearch.text.isNotEmpty) {
                      context.read<ImdbBloc>().add(
                            Fetchmovie(query: moviesearch.text),
                          );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Results
            Expanded(
              child: BlocBuilder<ImdbBloc, ImdbState>(
                builder: (context, state) {
                  if (state is ImdbLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  }

                  if (state is ImdbLoaded) {
                    result = state.movies;
                    return Center(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(border: GradientBoxBorder(gradient: LinearGradient(colors: [Colors.white,Colors.yellow,Colors.yellowAccent,const Color.fromARGB(205, 255, 255, 255)],begin: Alignment.topLeft,end: Alignment.bottomLeft,),width: 7),borderRadius: BorderRadius.circular(40)),
                            child: 
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              
                              child: Image.network(result?["Poster"] ?? "No Name", fit: BoxFit.fill)),
                          ),
                          SizedBox(width: 170,),
                          // Spacer(),
                          Expanded(
                            child: Container(
                              height: 450,
                              padding: EdgeInsets.all(17),
                              decoration: BoxDecoration(border: GradientBoxBorder(gradient: LinearGradient(colors: [const Color.fromARGB(145, 255, 255, 255),Colors.yellow,Colors.black],),width: 9),borderRadius: BorderRadius.circular(50),color: const Color.fromARGB(168, 0, 0, 0)),
                              margin: EdgeInsets.only(top: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RowText("Title", result?["Title"] ?? "No name"),
                                            SizedBox(height: 10),
                                            RowText("Ratings", result?["imdbRating"] ?? "No name"),
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
                                         
                                            RowText("BoxOffice", result?["BoxOffice"] ?? "No name"),
                                            SizedBox(height: 10),
                                
                                          ],
                                        ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    );
                  }

                  if (state is ImdbError) {
                    return Center(
                      child: Text(
                        "Oops! No movie found for '${moviesearch.text}'",
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget alertbox(Map<String, dynamic>? result) {
  return AlertDialog(
    backgroundColor: Colors.grey[900],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Text("🎞️ Movie Overview", style: GoogleFonts.poppins(color: Colors.white)),
    content: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final field in [
            "Title", "Year", "Rated", "Released", "Runtime", "Genre", "Director",
            "Writer", "Actors", "Plot", "Language", "Country", "Awards", "imdbRating", "BoxOffice"
          ])
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: RowText(field, result?[field] ?? "N/A"),
            ),
        ],
      ),
    ),
  );
}

Widget RowText(String title, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 1,
        child: Text(
          "$title: ",
          style: GoogleFonts.poppins(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      Expanded(
        flex: 4,
        child: Text(
          text,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    ],
  );
}

