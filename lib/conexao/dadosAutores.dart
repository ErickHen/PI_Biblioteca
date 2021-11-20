class VideoAula {
  String id;
  String datas;
  String nome;
  String idiomas;

  VideoAula({this.id, this.nome, this.datas});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      nome: json['nome'] as String,
      datas: json['datas'] as String,
    );
  }
}
