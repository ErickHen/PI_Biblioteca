class VideoAula {
  String id;
  String datas;
  String categoria;

  VideoAula({this.id, this.datas, this.categoria});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      datas: json['datas'] as String,
      categoria: json['categoria'] as String,
    );
  }
}
