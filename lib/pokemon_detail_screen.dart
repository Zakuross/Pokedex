import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatefulWidget {
  final pokemonDetail;
  final Color color;
  final int heroTag;
  
  PokemonDetailScreen({Key? key, required this.pokemonDetail, required this.color, required this.heroTag}) : super(key: key);

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 1,
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,)
            ),
          ),

          Positioned(
            top: 80,
              left: 20,
              child: Text(widget.pokemonDetail['name'], style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold,
                fontSize: 30
              ),)
          ),
          Positioned(
            top: height * 0.18,
            right: -30,
            child: Image.asset('images/pball.png', height: 200, fit: BoxFit.fitHeight, ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              height: height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: Colors.white
              ),
            ),
          ),

        ],
      ),
    );
  }
}
