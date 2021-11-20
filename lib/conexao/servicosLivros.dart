import 'dart:convert';
import 'dadosLivros.dart';
import 'package:http/http.dart' as http;

class Servicos {
  static const URI =
      'http://192.168.100.2/ProjetoBiblioteca-main/dadosPHP/livros.php';
  static const _GET_ALL = 'GET_ALL';
  static const _ADD_PESSOA = 'ADD_PESSOA';
  static const _DELETE_PESSOA = 'DELETE_PESSOA';

  static Future<List<VideoAula>> getRegistros() async {
    try {
      var map = Map<String, dynamic>();
      map['acao'] = _GET_ALL;
      final resposta = await http.post(Uri.parse(URI), body: map);
      print('getRegistros -> Resposta :: ${resposta.body}');

      if (resposta.statusCode == 200) {
        List<VideoAula> list = respostaHttp(resposta.body);
        return list;
      } else {
        return List<VideoAula>();
      }
    } catch (e) {
      return List<VideoAula>();
    }
  }

  static List<VideoAula> respostaHttp(String resposta) {
    final temp = json.decode(resposta).cast<Map<String, dynamic>>();
    return temp.map<VideoAula>((json) => VideoAula.fromjson(json)).toList();
  }

  //add pessoa
  static Future<String> addPessoa(String codigo, String livro, String autor,
      String localizacao, String disponibilidade) async {
    try {
      var map = Map<String, dynamic>();
      map['acao'] = _ADD_PESSOA;
      map['codigo'] = codigo;
      map['livro'] = livro;
      map['autor'] = autor;
      map['localizacao'] = localizacao;
      map['disponibilidade'] = disponibilidade;

      final resposta = await http.post(Uri.parse(URI), body: map);
      print('addPESSOA -> Resposta :: ${resposta.body}');

      if (resposta.statusCode == 200) {
        return resposta.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> deletePessoa(String pessoaId) async {
    try {
      var map = Map<String, dynamic>();
      map['acao'] = _DELETE_PESSOA;
      map['pessoa_id'] = pessoaId;

      final resposta = await http.post(Uri.parse(URI), body: map);
      print('deletePessoa -> Resposta :: ${resposta.body}');

      if (resposta.statusCode == 200) {
        return resposta.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
