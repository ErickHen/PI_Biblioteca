import '../conexao/videoaula.dart';
import '../conexao/servicos.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TabelaDemo9 extends StatefulWidget {
  TabelaDemo9() : super();
  final String title = 'Nesta página voce irá fazer uma reserva';

  @override
  TabelaDemoState createState() => TabelaDemoState();
}

class TabelaDemoState extends State<TabelaDemo9> {
  TextEditingController _livroController;
  TextEditingController _nomeController;
  TextEditingController _dataController;
  List categoryLivroList = List();
  List<VideoAula> _videoaula;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String _titulo;
  var timer;

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Criar reserva'),
          actions: <Widget>[
            SizedBox(
              width: 600,
            ),
            TextButton(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Insira o leitor"),
                      controller: _nomeController,
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Insira o livro"),
                      controller: _livroController,
                      style: TextStyle(color: Colors.black),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "dia/mês/ano"),
                      controller: _dataController,
                      style: TextStyle(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_nomeController.text == "" ||
                              _livroController.text == "" ||
                              _dataController.text == "") {
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
                          } else {
                            _addRegistro();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Reserva"),
                                content: Text("Reserva feita com sucesso !"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK")),
                                ],
                              ),
                            );

                            //AndroidAlarmManager.oneShot(Duration(days: 1), alarmId, _showIcone(IconButton(icon: Icon(Icons.access_time_filled),)));
                          }
                        },
                        child: Text("Reservar"),
                      ),
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
    _titulo = widget.title;
    _scaffoldKey = GlobalKey();
    _nomeController = TextEditingController();
    _dataController = TextEditingController();
    _livroController = TextEditingController();
  }

/*_addPessoa(){
  if(_nomeController.text.isEmpty){
    print('Textos vazios');
    return;
  }
  _showTitulo('Adicionando pessoa');
  Servicos.addPessoa(_nomeController.text).then((result){
    _getRegistros();
    _showTitulo(widget.title);
    _nomeController.text = "";
  });
}
*/

  _deletePessoa(VideoAula videoaula) {
    _showTitulo('Deletando pessoa');
    Servicos.deletePessoa(videoaula.id).then((result) {
      _getRegistros();
      _showTitulo(widget.title);
    });
  }

  @override
  _addRegistro() {
    Servicos.insereRegistro(
            _nomeController.text, _livroController.text, _dataController.text)
        .then((result) {
      _nomeController.text = "";
      _livroController.text = "";
      _dataController.text = "";
      _getRegistros();
    });
  }

  _showTitulo(String msg) {
    setState(() {
      _titulo = msg;
    });
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
              'Livro',
              style: TextStyle(color: Colors.black),
            )),
            DataColumn(
                label: Text(
              'Data-Limite',
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
                        videoaula.nome,
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
                        videoaula.periodo,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deletePessoa(videoaula);
                      },
                    )),
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
