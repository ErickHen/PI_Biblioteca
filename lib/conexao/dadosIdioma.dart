class VideoAula {
  String id;
  String datas;
  String nome;
  String idiomas;

  VideoAula({this.id, this.datas, this.idiomas});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      datas: json['datas'] as String,
      idiomas: json['idiomas'] as String,
    );
  }
}
