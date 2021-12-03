class VideoAula {
  String id;
  String datas;
  String categoria;

  VideoAula({this.id, this.categoria, this.datas});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      categoria: json['categoria'] as String,
      datas: json['datas'] as String,
    );
  }
}
