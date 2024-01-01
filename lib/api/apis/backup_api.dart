import 'dart:convert';
import 'dart:html' as html;


import 'package:flutter/services.dart';
import 'package:wealth_wave/api/db/app_database.dart';

class BackupApi {
  final AppDatabase _db;

  BackupApi({final AppDatabase? db}) : _db = db ?? AppDatabase.instance;

  Future<void> exportDatabase() async {
    final result = await _db.getBackup();

    final jsonString = json.encode(result);

    final blob = html.Blob([Uint8List.fromList(utf8.encode(jsonString))]);

    final anchor = html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
      ..target = 'blank'
      ..download = 'wealth_app_data.json';

    // Trigger a click event to prompt the user to download the file
    html.document.body?.append(anchor);
    anchor.click();
    // Clean up
    html.Url.revokeObjectUrl(anchor.href!);
  }
}
