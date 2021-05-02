import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_provider.dart';
import 'package:peliculas/models/pelicula_model.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Avengers',
    'Pequeña Miss Sunshine',
    'Tenet',
    'Avatar',
    'Wonder Woman',
    'Ironman',
    'Capitan America',
  ];
  final peliculasRecientes = [
    'Spiderman',
    'Wonder Woman',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        alignment: Alignment(0, 0),
        height: 100.0,
        width: 100.0,
        color: Colors.orangeAccent,
        child: Text(seleccion),
      ),
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias que aparecen cuando se escribe

  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculas
  //           .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList();

  //   return ListView.builder(
  //     itemCount: listaSugerida.length,
  //     itemBuilder: (context, i) => ListTile(
  //       leading: Icon(Icons.movie),
  //       title: Text(listaSugerida[i]),
  //       onTap: () {
  //         seleccion = listaSugerida[i];
  //         showResults(context);
  //       },
  //     ),
  //   );
  // }
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData)
          return ListView(
            children: snapshot.data
                .map((p) => ListTile(
                      leading: FadeInImage(
                        image: NetworkImage(p.getPosterImg()),
                        placeholder: AssetImage('assets/img/loading.gif'),
                        width: 50.0,
                        fit: BoxFit.contain,
                      ),
                      title: Text(p.title),
                      subtitle: Text(p.originalTitle),
                      onTap: () {
                        close(context, null);
                        p.uniqueId = '';
                        Navigator.pushNamed(context, 'detalle', arguments: p);
                      },
                    ))
                .toList(),
          );
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
