import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

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
        backgroundColor: Colors.white60,
        body: const BeerList(),
      ),
    );
  }
}

class Beer {
  String title, description, imageUrl;
  Beer(this.title, this.description, this.imageUrl);
}

class BeerList extends StatefulWidget {
  const BeerList({
    Key? key,
  }) : super(key: key);

  @override
  State<BeerList> createState() => _BeerListState();
}

class _BeerListState extends State<BeerList> {
  bool load = true;
  List<Beer> beers = [];

  @override
  void initState() {
    //inicializar la lista
    beers = [];
    load = true;

    _loadBeers();

    super.initState();
  }

  void _loadBeers() async {}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(beers[index].title),
          subtitle: Text(beers[index].description),
          leading: Icon(Icons.delete),
        );
      },
      itemCount: beers.length,
    );
  }
}
