import 'dart:convert';

LeafData leafDataFromJson(String str) => LeafData.fromJson(json.decode(str));

String leafDataToJson(LeafData data) => json.encode(data.toJson());

class LeafData {
  LeafData({
    required this.name,
    required this.disname,
    required this.desc,
    required this.imagePath,
    required this.treatment,
    required this.uses,
  });

  String name;
  String disname;
  String desc;
  String imagePath;
  List<String> treatment;
  List<dynamic> uses;

  factory LeafData.fromJson(Map<String, dynamic> json) => LeafData(
        name: json["name"],
        disname: json["disname"],
        desc: json["desc"],
        imagePath: json["image_path"],
        treatment: List<String>.from(json["treatment"].map((x) => x)),
        uses: List<dynamic>.from(json["uses"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "desname": disname,
        "desc": desc,
        "image_path": imagePath,
        "treatment": List<dynamic>.from(treatment.map((x) => x)),
        "uses": List<dynamic>.from(uses.map((x) => x)),
      };
}
