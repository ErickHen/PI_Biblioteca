// ignore_for_file: dead_code

import 'dart:html';
import 'dart:ui';

import '/conexao/dadosIdioma.dart';
import '/conexao/servicosIdioma.dart';
import 'package:flutter/material.dart';

class TabelaDemo6 extends StatefulWidget {
  TabelaDemo6() : super();
  final String title = 'Nesta página voce irá cadastrar um novo idioma';

  @override
  TabelaDemoState createState() => TabelaDemoState();
}

class TabelaDemoState extends State<TabelaDemo6> {
  List<VideoAula> _videoaula;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _nomeController;
  TextEditingController _datasController;
  TextEditingController _idiomasController;
  VideoAula _select;
  bool _isatualizado;
  String _titulo;

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Cadastre um novo idioma'),
          actions: <Widget>[
            SizedBox(
              width: 600,
            ),
            TextButton(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Idioma:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: _idiomasController,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Data:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: _datasController,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 50),
                    TextButton(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Salvar",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onPressed: () {
                        _addPessoa();
                      },
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _videoaula = [];
    _isatualizado = false;
    _titulo = widget.title;
    _scaffoldKey = GlobalKey();

    _datasController = TextEditingController();
    _idiomasController = TextEditingController();
  }

  _showTitulo(String msg) {
    setState(() {
      _titulo = msg;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _getRegistros() {
    _showTitulo('Carregando dados... aguardade');
    Servicos.getRegistros().then((videoaula) {
      setState(() {
        _videoaula = videoaula;
      });
      _showTitulo(widget.title);
    });
  }

  _addPessoa() {
    if (_idiomasController.text.isEmpty && _datasController.text.isEmpty) {
      print('Textos vazios');
      return;
    }
    _showTitulo('Adicionando idioma');
    Servicos.addPessoa(
      _idiomasController.text,
      _datasController.text,
    ).then((result) {
      _getRegistros();
      _showTitulo(widget.title);

      _idiomasController.text = "";
      _datasController.text = "";
    });
  }

  _deletePessoa(VideoAula videoaula) {
    _showTitulo('Deletando idioma');
    Servicos.deletePessoa(videoaula.id).then((result) {
      _getRegistros();
      _showTitulo(widget.title);
    });
  }

  SingleChildScrollView _dados() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
                label: Text(
              'ID',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Idioma',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Datas',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Deletar',
              style: TextStyle(color: Colors.black),
            )),
          ],
          rows: _videoaula
              .map((videoaula) => DataRow(cells: [
                    DataCell(
                      Text(
                        videoaula.id,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.idiomas,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.datas,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deletePessoa(videoaula);
                        },
                      ),
                    ),
                  ]))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF24386e),
        title: Text(_titulo),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getRegistros();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              await showInformationDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/autor0.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(280),
          width: 1800,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: Column(
            children: [
              _dados(),
            ],
          ),
        ),
      ),
    );
  }
}
