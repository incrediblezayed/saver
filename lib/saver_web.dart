import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class SaverWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'saver',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = SaverWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'saveFile':
        String json = call.arguments;
        Map data = jsonDecode(json);
        return downloadFile(
            bytes: data['bytes'],
            name: data['name'],
            ext: data['ext'],
            type: data['type']);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'saver for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  void downloadFile(
      {List<int> bytes, String name, String type, String ext}) async {
    String url;
    AnchorElement anchor;
    try {
      url = Url.createObjectUrlFromBlob(Blob([bytes], type));
      HtmlDocument htmlDocument = document;
      print(url);
      anchor = htmlDocument.createElement('a') as AnchorElement;
      anchor.href = url;
      anchor.style.display = name;
      anchor.download = name + '.' + ext;
      document.body.children.add(anchor);
      anchor.click();
      document.body.children.remove(anchor);
    } catch (e) {
      print(e);
    }
  }
}
