import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late List pokedex;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      fetPokemondata();
    }
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
          top: 150,
          bottom: 0,
          width: width,
          child: Column(
            children: [
              pokedex != null ? Expanded(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.4,
              ), itemCount: pokedex.length,
                itemBuilder: (context, index){
                  var type = pokedex[index]['type'][0];
                  return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Stack(
                              children: [
                                Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: Image.asset('images/pball.png',
                                      height: 100,
                                      fit: BoxFit.fitHeight,)),


                                Positioned(
                                  top: 20,
                                  left: 10,
                                  child: Text(
                                    pokedex[index]['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18,
                                      color: Colors.white,

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
                                        type.toString(),
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all((Radius.circular(20))),
                                      color: Colors.black26,

                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: CachedNetworkImage(
                                    imageUrl: pokedex[index]['img'],
                                    height: 100,
                                    fit: BoxFit.fitHeight,

                                  ),
                                ),
                              ]
                          )
                      )
                  );
                },
              )
              ): Center(
                child: CircularProgressIndicator(),
              )
            ]
        ),)


      ],
      )
    );

  }

  void fetPokemondata(){
    var url = Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if(value.statusCode == 200){
        var decodedJsonData = jsonDecode(value.body);
        // print(decodedJsonData);
        pokedex = decodedJsonData['pokemon'];
        setState(() {});
      }
    });

  }
}
