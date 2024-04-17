import 'dart:io';

String readFileAsString(String filepath) {
  return File(filepath).readAsStringSync();
}
