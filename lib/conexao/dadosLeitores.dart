class VideoAula {
  String id;
  String datas;
  String telefone;
  String nome;
  String tipo;

  VideoAula({this.id, this.nome, this.telefone, this.datas, this.tipo});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      nome: json['nome'] as String,
      telefone: json['telefone'] as String,
      datas: json['datas'] as String,
      tipo: json['tipo'] as String,
    );
  }
}
