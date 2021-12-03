class VideoAula {
  String id;
  String nome;
  String livro;
  String periodo;

  VideoAula({this.id, this.nome, this.livro, this.periodo});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      nome: json['nome'] as String,
      livro: json['livro'] as String,
      periodo: json['periodo'] as String,
    );
  }
}
