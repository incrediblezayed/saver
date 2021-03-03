# Saver

This plugin package is not much but only for saving files in Android, iOS and Web.
The package depends on path_provider for Android and iOS and basic html anchor for Web
The main reason I built this plugin was to avoid using html only for downloading files.
The plugin is pretty simple and saves the file in Documents folder in android and iOS
and directly downloads the file in Web.

## Getting Started

The plugin itself is pretty easy to use.
Just create an object of Saver()

```dart
Saver saver = new Saver();
```

and call saveFile() with respective parameter.
This saveFile() method takes 4 Positional Arguments.
_String name_ which takes the name of the file, _List<dynamic> bytes_ which will be your actual encoded file, _MimeType type_ which will be your file type, _String ext_ this will be your file extension.
MimeType is also included in my Package, I've included types for **Sheets, Presentation, Word, Plain Text, and Optional Octect Stream for other Types of files** 


```dart
saver.saveFile("File", bytes, MimeType.EXCEL, 'xlsx');
```

#### And You're done

## Thank You For Reading this far :)