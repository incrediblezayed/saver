import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum MimeType { WORD, EXCEL, PPT, TEXT, CSV, OTHER }

class Saver {
  static const MethodChannel _channel = const MethodChannel('saver');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  String _getType(MimeType type) {
    switch (type) {
      case MimeType.EXCEL:
        return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8";
        break;
      case MimeType.PPT:
        return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
        break;
      case MimeType.WORD:
        return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
        break;
      case MimeType.OTHER:
        return "application/octet-stream";
      case MimeType.TEXT:
        return 'text/plain';
        break;
      case MimeType.CSV:
        return 'text/csv';
        break;
      default:
        return "application/octet-stream";
    }
  }

  Future<void> saveFile(
      String name, List<int> bytes, MimeType mimeType, String ext) async {
    String mime = _getType(mimeType);
    try {
      if (kIsWeb) {
        Map<String, dynamic> data = <String, dynamic>{
          "bytes": bytes,
          "name": name,
          "ext": ext,
          "type": mime
        };
        String args = jsonEncode(data);
        await _channel.invokeMethod<void>('saveFile', args);
      } else if (Platform.isAndroid) {
        var status = await Permission.storage.isDenied;
        if (status) {
          Permission.storage.request();
        }
        Directory directory = await getDownloadsDirectory();
        final String path = directory.path + '/' + name + '.' + ext;
        final File file = File(path);
        await file.writeAsBytes(bytes);
        bool exist = await file.exists();
        if (exist) {
          print("File saved at: ${file.path}");
        }
      } else if (Platform.isIOS) {
        final Directory iosDir = await getApplicationDocumentsDirectory();
        final String path = iosDir.path + '/' + name + '.' + ext;
        final File file = File(path);
        await file.writeAsBytes(bytes);
      } else {
        throw UnimplementedError(
            "Sorry but the plugin only supports web, ios and android");
      }
    } catch (e) {
      print(e);
    }
  }
}
