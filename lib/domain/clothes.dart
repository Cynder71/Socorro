class Clothes {
  static const String clothesTable = "contactTable";
  static const String idColumn = "idColumn";
  static const String imgColumn = "imgColumn";
  static const String tagsColumn = "tagsColumn";
  static const String nickNameColumn = "nickNameColumn";

  int id = 0;
  String img = '';
  List<String> tags = [];
  String nickName = '';

  Clothes();

  Clothes.fromMap(Map map) {
    id = map[idColumn];
    img = map[imgColumn];
    tags = map[tagsColumn];
    nickName = map[nickNameColumn];
  }

  Map<String, Object?> toMap() {
    Map<String, Object?> map = {
      imgColumn: img,
      tagsColumn: tags,
      nickNameColumn: nickName,
    };
    if (id != 0) map[idColumn] = id;

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, nickname: $nickName, categorias: $tags, img: $img)";
  }
}
