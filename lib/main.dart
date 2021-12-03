import 'package:flutter/material.dart';
import 'package:portfolio_website/homepage.dart';
import 'package:portfolio_website/tela/autores.dart';
import 'package:portfolio_website/tela/categoria.dart';
import 'package:portfolio_website/tela/consultaAutores.dart';
import 'package:portfolio_website/tela/editora.dart';
import 'package:portfolio_website/tela/idioma.dart';
import 'package:portfolio_website/tela/leitores.dart';
import 'package:portfolio_website/tela/consultaLeitores.dart';
import 'package:portfolio_website/tela/livros.dart';
import 'package:portfolio_website/tela/telaconsulta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Virtual',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/leitores': (context) => TabelaDemo(),
        '/consultaLeitores': (context) => TabelaDemo4(),
        '/autores': (context) => TabelaDemo3(),
        '/consultaAutores': (context) => TabelaDemo2(),
        '/categoria': (context) => TabelaDemo5(),
        '/idioma': (context) => TabelaDemo6(),
        '/editora': (context) => TabelaDemo7(),
        '/livros': (context) => TabelaDemo8(),
        '/telaconsulta': (context) => TabelaDemo9(),
      },
      theme: ThemeData(
          fontFamily: 'Barlow',
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontFamily: 'DMSerifDisplay'),
              headline2: TextStyle(
                  fontSize: 55,
                  color: Colors.white,
                  fontFamily: 'DMSerifDisplay'),
              headline3: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontFamily: 'DMSerifDisplay'),
              subtitle1: TextStyle(fontSize: 30, color: Colors.grey[500]),
              subtitle2: TextStyle(fontSize: 20, color: Colors.grey[500]),
              bodyText1:
                  TextStyle(fontSize: 20, color: Colors.white, height: 1.25),
              bodyText2:
                  TextStyle(fontSize: 17, color: Colors.white, height: 1.25),
              caption:
                  TextStyle(fontSize: 15, color: Colors.white, height: 1.25),
              button: TextStyle(fontSize: 17, color: Color(0xff1e1e24)))),
    );
  }
}
