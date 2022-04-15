import 'dart:io';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:FPS2/globals.dart' as global;

Future askPermissions() async {
  final statusM = await Permission.microphone.request();
  if (statusM != PermissionStatus.granted) {
    throw RecordingPermissionException('Microphone permission denied.');
  }
  final statusS = await Permission.storage.request();
  if (statusS != PermissionStatus.granted) {
    throw RecordingPermissionException('Storage permission denied.');
  }

  Directory? directory = await getExternalStorageDirectory();
  if (directory == null) {
    throw Exception("Directory not found");
  }
  global.directory = directory.path;
  try {
    await createDirectory();
  } catch (e) {
    throw Exception(e);
  }
}

String pathToAudio(String fileName) {
  final pathToSaveAudio =
      global.directory! + '/Recordings/' + fileName + '.wav';
  return pathToSaveAudio;
}

String pathToSpeech(String fileName) {
  final pathToSaveSpeech = global.directory! + '/Speech/' + fileName + '.txt';
  return pathToSaveSpeech;
}

Future createDirectory() async {
  String _directoryPath = global.directory! + '/Recordings';
  bool isDirectoryCreated = await Directory(_directoryPath).exists();
  if (!isDirectoryCreated) {
    try {
      Directory(_directoryPath).create();
    } catch (e) {
      throw Exception(e);
    }
  }

  _directoryPath = global.directory! + '/Speech';
  isDirectoryCreated = await Directory(_directoryPath).exists();
  if (!isDirectoryCreated) {
    try {
      Directory(_directoryPath).create();
    } catch (e) {
      throw Exception(e);
    }
  }
}
