class VideoAula {
  String id;
  String datas;
  String editoras;
  String idiomas;

  VideoAula({this.id, this.editoras, this.datas});

  factory VideoAula.fromjson(Map<String, dynamic> json) {
    return VideoAula(
      id: json['id'] as String,
      editoras: json['editoras'] as String,
      datas: json['datas'] as String,
    );
  }
}
