import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/pokemon_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // late List pokedex;
  late Future<List<dynamic>> futurePokedex;


  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if(mounted){
  //     fetPokemondata();
  //   }
  // }

  void initState() {
    super.initState();
    futurePokedex = fetPokemondata(); // Assign the result of fetPokemondata to futurePokedex
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset('images/pball.png', width: 200, fit: BoxFit.fitWidth,),
          ),

          Positioned(
            top: 80,
            left: 20,
            child: Text("Pokedex",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
          ),

          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: futurePokedex,
                    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator()); // Show loading spinner
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}')); // Show error message
                      } else {
                        // Use snapshot.data to access the list of Pokedex entries
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.4,
                          ),
                          itemCount: snapshot.data?.length ?? 0, // Ensure we don't try to access .length on null
                          itemBuilder: (context, index) {
                            var type = snapshot.data?[index]['type'][0]; // Safely access the list element
                            return InkWell(
                              child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: type == 'Grass' ? Colors.greenAccent: type == "Fire" ? Colors.redAccent : type == "Water" ? Colors.blue
                                      : type == "Electric" ? Colors.yellow : type == "Rock" ? Colors.grey : type == "Ground" ? Colors.brown
                                      : type == "Psychic" ? Colors.indigo : type == "Fighting" ? Colors.orange : type == "Bug" ? Colors.lightGreenAccent
                                      : type == "Ghost" ? Colors.deepPurple : type == "Normal" ? Colors.black26 : type == "Poison" ? Colors.deepPurpleAccent : Colors.pink,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: -10,
                                      right: -10,
                                      child: Image.asset('images/pball.png', height: 100, fit: BoxFit.fitHeight,),
                                    ),
                                    Positioned(
                                      top: 20,
                                      left: 10,
                                      child: Text(
                                        snapshot.data?[index]['name'] ?? '', // Safely access the name property
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 45,
                                      left: 20,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
                                          child: Text(
                                            type.toString(), // Use the type variable defined earlier
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: Colors.black26,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data?[index]['img'], // Safely access the image URL
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),

                                    // Add other Positioned widgets similarly...
                                  ],

                                ),
                              ),
                            ),
                              onTap: (){
                                //TODO Navigate to new detail screen
                                Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonDetailScreen(
                                  pokemonDetail: snapshot.data?[index],
                                  color: type == 'Grass' ? Colors.greenAccent: type == "Fire" ? Colors.redAccent : type == "Water" ? Colors.blue
                                      : type == "Electric" ? Colors.yellow : type == "Rock" ? Colors.grey : type == "Ground" ? Colors.brown
                                      : type == "Psychic" ? Colors.indigo : type == "Fighting" ? Colors.orange : type == "Bug" ? Colors.lightGreenAccent
                                      : type == "Ghost" ? Colors.deepPurple : type == "Normal" ? Colors.black26 : type == "Poison" ? Colors.deepPurpleAccent : Colors.pink,
                                  heroTag: index,
                                )));
                              },
                            );

                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Widget build(BuildContext context) {
  //   var width = MediaQuery.of(context).size.width;
  //   var height = MediaQuery.of(context).size.height;
  //
  //   return Scaffold(
  //
  //     body: Stack(
  //
  //     children: [
  //       Positioned(
  //         top: -50,
  //           right: -50,
  //           child: Image.asset('images/pball.png', width: 200, fit: BoxFit.fitWidth,),
  //       ),
  //       Positioned(
  //         top: 100,
  //         left: 20,
  //         child: Text("KJFJKEZG", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
  //       ),
  //       Positioned(
  //         top: 150,
  //         bottom: 0,
  //         width: width,
  //         child: Column(
  //           children: [
  //             pokedex != null ? Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2,
  //               childAspectRatio: 1.4,
  //             ),
  //               itemCount: pokedex.length,
  //               itemBuilder: (context, index){
  //                 var type = pokedex[index]['type'][0];
  //                 return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
  //                     child: Container(
  //                         decoration: BoxDecoration(
  //                             color: Colors.green,
  //                             borderRadius: BorderRadius.all(Radius.circular(20))
  //                         ),
  //                         child: Stack(
  //                             children: [
  //                               Positioned(
  //                                   bottom: -10,
  //                                   right: -10,
  //                                   child: Image.asset('images/pball.png',
  //                                     height: 100,
  //                                     fit: BoxFit.fitHeight,)),
  //
  //
  //                               Positioned(
  //                                 top: 20,
  //                                 left: 10,
  //                                 child: Text(
  //                                   pokedex[index]['name'],
  //                                   style: TextStyle(
  //                                     fontWeight: FontWeight.bold, fontSize: 18,
  //                                     color: Colors.white,
  //
  //                                   ),
  //                                 ),
  //                               ),
  //                               Positioned(
  //                                 top: 45,
  //                                 left: 20,
  //                                 child: Container(
  //
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
  //                                     child: Text(
  //                                       type.toString(),
  //                                       style: TextStyle(
  //                                           color: Colors.white
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.all((Radius.circular(20))),
  //                                     color: Colors.black26,
  //
  //                                   ),
  //                                 ),
  //                               ),
  //                               Positioned(
  //                                 bottom: 5,
  //                                 right: 5,
  //                                 child: CachedNetworkImage(
  //                                   imageUrl: pokedex[index]['img'],
  //                                   height: 100,
  //                                   fit: BoxFit.fitHeight,
  //
  //                                 ),
  //                               ),
  //                             ]
  //                         )
  //                     )
  //                 );
  //               },
  //             )
  //             ): Center(
  //               child: CircularProgressIndicator(),
  //             )
  //           ]
  //         ),
  //       )
  //
  //
  //     ],
  //     )
  //   );
  //
  // }




  // void fetPokemondata(){
  //   var url = Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
  //   http.get(url).then((value) {
  //     if(value.statusCode == 200){
  //       var decodedJsonData = jsonDecode(value.body);
  //       // print(decodedJsonData);
  //       pokedex = decodedJsonData['pokemon'];
  //       setState(() {});
  //     }
  //   });
  //
  // }

  Future<List<dynamic>> fetPokemondata() async {
    var url = Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['pokemon']; // Return the decoded data
    } else {
      throw Exception('Failed to load Pokemon data');
    }
  }
}
