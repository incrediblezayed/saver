import 'dart:async';
import 'dart:convert';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the Saver plugin.
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

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
        break;
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
      {List<dynamic> bytes, String name, String type, String ext}) async {
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

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = window.navigator.userAgent;
    return Future.value(version);
  }
}
