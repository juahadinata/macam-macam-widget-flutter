class ChildModel {
  final String nama;
  final double nilai;

  ChildModel({required this.nama, required this.nilai});

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'nilai': nilai,
      };

  factory ChildModel.fromJson(Map<String, dynamic> json) => ChildModel(
        nama: json['nama'],
        nilai: (json['nilai'] as num).toDouble(),
      );
}

class ParentModel {
  final DateTime tanggal;
  final List<ChildModel> children;

  ParentModel({required this.tanggal, required this.children});

  Map<String, dynamic> toJson() => {
        'tanggal': tanggal.toIso8601String(),
        'children': children.map((c) => c.toJson()).toList(),
      };

  factory ParentModel.fromJson(Map<String, dynamic> json) => ParentModel(
        tanggal: DateTime.parse(json['tanggal']),
        children: (json['children'] as List)
            .map((e) => ChildModel.fromJson(e))
            .toList(),
      );
}
