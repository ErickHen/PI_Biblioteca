// ignore_for_file: dead_code

import 'dart:html';
import 'dart:ui';

import '../conexao/dadosLivros.dart';
import '../conexao/servicosLivros.dart';
import 'package:flutter/material.dart';

class TabelaDemo8 extends StatefulWidget {
  TabelaDemo8() : super();
  final String title = 'Nesta página voce irá cadastrar um novo livro';

  @override
  TabelaDemoState createState() => TabelaDemoState();
}

class TabelaDemoState extends State<TabelaDemo8> {
  List<VideoAula> _videoaula;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _codigoController;
  TextEditingController _livroController;
  TextEditingController _autorController;
  TextEditingController _localizacaoController;
  TextEditingController _disponibilidadeController;
  VideoAula _select;
  bool _isatualizado;
  String _titulo;

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Cadastre um novo livro'),
          actions: <Widget>[
            SizedBox(
              width: 600,
            ),
            TextButton(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Código:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: _codigoController,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Livro:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: _livroController,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Autor:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: _autorController,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Localização:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: _localizacaoController,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 50),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Disponibilidade:",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    TextField(
                      controller: _disponibilidadeController,
                      style: TextStyle(color: Colors.black),
                    ),
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
    _codigoController = TextEditingController();
    _livroController = TextEditingController();
    _autorController = TextEditingController();
    _localizacaoController = TextEditingController();
    _disponibilidadeController = TextEditingController();
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
        _videoaula = videoaula.cast<VideoAula>();
      });
      _showTitulo(widget.title);
    });
  }

  _addPessoa() {
    if (_codigoController.text.isEmpty &&
        _livroController.text.isEmpty &&
        _autorController.text.isEmpty &&
        _localizacaoController.text.isEmpty &&
        _disponibilidadeController.text.isEmpty) {
      print('Textos vazios');
      return;
    }
    _showTitulo('Adicionando livro');
    Servicos.addPessoa(
            _codigoController.text,
            _livroController.text,
            _autorController.text,
            _localizacaoController.text,
            _disponibilidadeController.text)
        .then((result) {
      _getRegistros();
      _showTitulo(widget.title);
      _codigoController.text = "";
      _livroController.text = "";
      _autorController.text = "";
      _localizacaoController.text = "";
      _disponibilidadeController.text = "";
    });
  }

  _deletePessoa(VideoAula videoaula) {
    _showTitulo('Deletando livro');
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
              'Código',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Livro',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Autor',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Localização',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Disponibilidade',
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
                        videoaula.codigo,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.livro,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.autor,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.localizacao,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.disponibilidade,
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
