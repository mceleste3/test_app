import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memoradium prueba',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Beer list"),
        ),
        backgroundColor: Colors.white70,
        body: const BeerList(),
      ),
    );
  }
}

class Beer {
  String title, description, imageUrl;
  Beer(this.title, this.description, this.imageUrl);
  Beer.fromJson(Map<String, dynamic> json)
      : title = json['name'],
        description = json['description'],
        imageUrl = json['image_url'];
}

class BeerList extends StatefulWidget {
  const BeerList({
    Key? key,
  }) : super(key: key);

  @override
  State<BeerList> createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  late bool load;
  late List<Beer> beers;

  @override
  void initState() {
    //inicializar la lista
    beers = [];
    load = true;

    _loadBeers();

    super.initState();
  }

  void _loadBeers() async {
    final response = await http.get(Uri.parse(
        'https://api.punkapi.com/v2/beers?brewed_before=11-2012&abv_gt=6'));
    final json = jsonDecode(response.body);

    List<Beer> _beers = [];
    for (var jsonBeer in json['results']) {
      _beers.add(Beer.fromJson(jsonBeer));
    }
    setState(() {
      beers = _beers;
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(beers[index].title),
          subtitle: Text(beers[index].description),
          leading: Image(
            image: NetworkImage(beers[index].imageUrl),
          ),
        );
      },
      itemCount: beers.length,
    );
  }
}

/*Falta:
- Separar el widget de la lista en una carpeta de componentes
- Estilizar la página
- Crear otro componente para cada elemento de la lista
- Realizar el enrutamiento  */