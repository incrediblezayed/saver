# Saver

This plugin package is not much but only for saving files in Android, iOS and Web.
The main reason I built this plugin was to avoid using html only for downloading files.
The plugin is pretty simple and saves the file in Documents folder in android and iOS
and directly downloads the file in Web.

## Getting Started

The plugin itself is pretty easy to use.
Just create an object of Saver()

```dart
Saver saver = new Saver();
```

and call the saveFile() with respective parameter.
This saveFile() method takes 4 Positional Arguments.
_String name_, _List<dynamic> bytes_, _MimeType type_, _String extension_
MimeType is also included in my Package, I've included types for **Sheets, Presentation, Word, Plain Text, and Optional Octect Stream for other Types of files** 


```dart
saver.saveFile("File", bytes, MimeType.EXCEL, xlsx);
```

### And You're done

# Thank You For Reading this far :)