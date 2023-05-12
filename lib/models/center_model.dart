class CenterModel {
  String? id;
  String? name;

  CenterModel({
    required this.id,
    required this.name,
  });

  CenterModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
    };
  }
}
