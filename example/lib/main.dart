import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:saver/saver.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Saver saver = Saver();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Saver'),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      labelText: "Name",
                      hintText: "Something",
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Excel execl = Excel.createExcel();
                for (int i = 0; i < 10; i++)
                  execl.insertRowIterables("Sheet 1", ['a', i], i);
                List<int> sheets = await execl.encode();
                MimeType type = MimeType.EXCEL;
                saver.saveFile(
                    textEditingController?.text == ""
                        ? "File"
                        : textEditingController.text,
                    sheets,
                    type,
                    ".xls");
              },
              child: Text("Generate Excel And Download"),
            )
          ],
        ),
      ),
    );
  }
}
