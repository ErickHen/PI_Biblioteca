// ignore_for_file: dead_code

import 'dart:html';
import 'dart:ui';

import '../conexao/dadosLeitores.dart';
import '../conexao/servicosLeitores.dart';
import 'package:flutter/material.dart';

class TabelaDemo4 extends StatefulWidget {
  TabelaDemo4() : super();
  final String title = 'Nesta página voce irá cadastrar um novo leitor';

  @override
  TabelaDemoState createState() => TabelaDemoState();
}

class TabelaDemoState extends State<TabelaDemo4> {
  List<VideoAula> _videoaula;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _nomeController;
  TextEditingController _datasController;
  TextEditingController _telefoneController;
  TextEditingController _tipoController;
  VideoAula _select;
  bool _isatualizado;
  String _titulo;

  Future<void> showInformationDialog(BuildContext context) async {}

  @override
  void initState() {
    super.initState();
    _videoaula = [];
    _isatualizado = false;
    _titulo = widget.title;
    _scaffoldKey = GlobalKey();
    _nomeController = TextEditingController();
    _datasController = TextEditingController();
    _telefoneController = TextEditingController();
    _tipoController = TextEditingController();
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
    if (_nomeController.text.isEmpty &&
        _telefoneController.text.isEmpty &&
        _tipoController.text.isEmpty &&
        _datasController.text.isEmpty) {
      print('Textos vazios');
      return;
    }
    _showTitulo('Adicionando pessoa');
    Servicos.addPessoa(
      _nomeController.text,
      _telefoneController.text,
      _tipoController.text,
      _datasController.text,
    ).then((result) {
      _getRegistros();
      _showTitulo(widget.title);
      _nomeController.text = "";
      _telefoneController.text = "";
      _tipoController.text = "";
      _datasController.text = "";
    });
  }

  _deletePessoa(VideoAula videoaula) {
    _showTitulo('Deletando pessoa');
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
              'Nome',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Telefone',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Tipo',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Datas',
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
                        videoaula.nome,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.telefone,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.tipo,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(
                      Text(
                        videoaula.datas,
                        style: TextStyle(color: Colors.black),
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
