import 'dart:convert';
import 'dart:io';
import 'package:macam_macam_widget/nested_model/model.dart';
import 'package:path_provider/path_provider.dart';

class JsonStorage {
  static Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/parent_data.json';
  }

  static Future<List<ParentModel>> readData() async {
    final path = await _getFilePath();
    final file = File(path);

    if (!await file.exists()) return [];

    final contents = await file.readAsString();
    final List<dynamic> jsonData = json.decode(contents);
    return jsonData.map((e) => ParentModel.fromJson(e)).toList();
  }

  static Future<void> writeData(List<ParentModel> data) async {
    final path = await _getFilePath();
    final file = File(path);
    final jsonString = json.encode(data.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  static Future<void> insertParentIfHasChildren(
      DateTime tanggal, List<ChildModel> children) async {
    if (children.isEmpty) return;
    final list = await readData();
    list.add(ParentModel(tanggal: tanggal, children: children));
    await writeData(list);
  }
}
