// ignore_for_file: dead_code

import 'dart:html';
import 'dart:ui';

import '/conexao/dadosEditora.dart';
import '/conexao/servicosEditora.dart';
import 'package:flutter/material.dart';

class TabelaDemo7 extends StatefulWidget {
  TabelaDemo7() : super();
  final String title = 'Nesta página voce irá cadastrar uma nova editora';

  @override
  TabelaDemoState createState() => TabelaDemoState();
}

class TabelaDemoState extends State<TabelaDemo7> {
  List<VideoAula> _videoaula;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _datasController;
  TextEditingController _editoraController;
  VideoAula _select;
  bool _isatualizado;
  String _titulo;

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Cadastre ums nova editora'),
          actions: <Widget>[
            SizedBox(
              width: 600,
            ),
            TextButton(
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Insira uma nova editora"),
                      controller: _editoraController,
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "dia/mês/ano"),
                      controller: _datasController,
                      style: TextStyle(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_editoraController.text == "" ||
                                _datasController.text == "") {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("ERRO"),
                                  content:
                                      Text("Preencha os campos corretamente"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK")),
                                  ],
                                ),
                              );
                            }
                          },
                          child: TextButton(
                            child: Text(
                              "Salvar",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _addPessoa();
                            },
                          )),
                    ),
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
    _editoraController = TextEditingController();
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
    if (_editoraController.text.isEmpty && _datasController.text.isEmpty) {
      print('Textos vazios');
      return;
    }
    _showTitulo('Adicionando editora');
    Servicos.addPessoa(
      _editoraController.text,
      _datasController.text,
    ).then((result) {
      _getRegistros();
      _showTitulo(widget.title);

      _editoraController.text = "";
      _datasController.text = "";
    });
  }

  _deletePessoa(VideoAula videoaula) {
    _showTitulo('Deletando editora');
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
              'Editora',
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
                        videoaula.editoras,
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
