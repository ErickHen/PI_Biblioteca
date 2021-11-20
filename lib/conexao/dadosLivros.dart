class VideoAula {
  String id;
  String codigo;
  String livro;
  String autor;
  String localizacao;
  String disponibilidade;

  VideoAula(
      {this.id,
      this.codigo,
      this.livro,
      this.autor,
      this.localizacao,
      this.disponibilidade});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      codigo: json['codigo'] as String,
      livro: json['livro'] as String,
      autor: json['autor'] as String,
      localizacao: json['localizacao'] as String,
      disponibilidade: json['disponibilidade'] as String,
    );
  }
}
