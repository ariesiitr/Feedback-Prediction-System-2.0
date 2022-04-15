import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_speech/config/recognition_config.dart';
import 'package:google_speech/config/recognition_config_v1.dart';
import 'package:google_speech/speech_client_authenticator.dart';
import 'package:google_speech/speech_to_text.dart';
import 'package:FPS2/fileSystem/fileSystem.dart';

Future speechToText(String projectName) async {
  final String? _pathToAudio = pathToAudio(projectName);
  String text = await recognize(_pathToAudio);

  final String? _pathToSpeech = pathToSpeech(projectName);
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
