import 'package:flutter/material.dart';
import 'package:peliculas/screens/home_screen.dart';
import 'package:peliculas/screens/pelicula_detalle_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomeScreen(),
        'detalle': (BuildContext context) => PeliculaDetalleScreen(),
      },
    );
  }
}
