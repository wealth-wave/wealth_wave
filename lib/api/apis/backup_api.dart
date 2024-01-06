import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class BackupApi {
  final AppDatabase _db;

  BackupApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<void> importDatabase() async {
    final file = await _pickFile();
    if (file == null) {
      return Future.error('No file selected');
    }

    final json = await _readJsonFromFile(file);

    if (json == null) {
      return Future.error('Not a json file');
    }

    await _db.loadBackup(json);
  }

  Future<void> exportDatabase() async {
    final result = await _db.getBackup();

    final jsonString = json.encode(result);

    final blob = Blob([Uint8List.fromList(utf8.encode(jsonString))]);

    final anchor = AnchorElement(href: Url.createObjectUrlFromBlob(blob))
      ..target = 'blank'
      ..download = 'wealth_app_data.json';

    // Trigger a click event to prompt the user to download the file
    document.body?.append(anchor);
    anchor.click();
    // Clean up
    Url.revokeObjectUrl(anchor.href!);
  }

  Future<File?> _pickFile() async {
    final input = FileUploadInputElement()..accept = 'application/json';
    input.click();

    await input.onChange.first;
    return input.files?.isNotEmpty == true ? input.files![0] : null;
  }

  Future<Map<String, List<Map<String, dynamic>>>?> _readJsonFromFile(
      File file) async {
    try {
      final reader = FileReader();
      reader.readAsText(file);

      await reader.onLoad.first;

      final jsonString = reader.result as String;
      final jsonMap = json.decode(jsonString);
      final Map<String, List<Map<String, dynamic>>> map = {};
      jsonMap.forEach((key, value) {
        map[key] = List<Map<String, dynamic>>.from(value
            .map((e) => Map<String, dynamic>.from(e as Map<dynamic, dynamic>)));
      });
      return map;
    } catch (e) {
      Logger().e(e.toString());
      return null;
    }
  }
}
