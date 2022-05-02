import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/config/recognition_config.dart';
import 'package:google_speech/config/recognition_config_v1.dart';
import 'package:google_speech/speech_client_authenticator.dart';
import 'package:google_speech/speech_to_text.dart';
import 'package:FPS2/fileSystem/fileSystem.dart';
import '../connectDatabase/connectDatabase.dart' as db;
import '../main.dart';

Future speechToText(db.Project project, String visitorName) async {
  final String? _pathToAudio = pathToAudio(project.title);
  String text = await recognize(_pathToAudio);
  if(text=="")
    {
      showMyDialog();
      return;
    }
  db.Feedback feedback =
      db.Feedback(null, project.id!, visitorName, text, null);
  await db.createFeedback(feedback);
  final String? _pathToSpeech = pathToSpeech(project.title);
  final File file = File(_pathToSpeech!);
  file.writeAsString(text);
}

Future<String> recognize(filePath) async {
  String text = '';
  final serviceAccount = ServiceAccount.fromString(
      (await rootBundle.loadString('assets/test_service_account.json')));
  final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
  final config = _getConfig();
  final audio = await _getAudioContent(filePath);

  await speechToText.recognize(config, audio).then((value) {
    text = value.results.map((e) => e.alternatives.first.transcript).join('\n');
  });
  return text;
}

RecognitionConfig _getConfig() => RecognitionConfig(
    encoding: AudioEncoding.LINEAR16,
    model: RecognitionModel.basic,
    enableAutomaticPunctuation: true,
    sampleRateHertz: 16000,
    languageCode: 'en-US');

Future<List<int>> _getAudioContent(String path) async {
  return File(path).readAsBytesSync().toList();
}


void showMyDialog() {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () => Navigator.pop(navigatorKey.currentContext!, 'OK'),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: const Text("Speech is empty"),
    actions: [
      okButton,
    ],
  );
  showDialog(
      context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}