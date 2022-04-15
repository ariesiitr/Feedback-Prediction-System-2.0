import 'package:flutter_sound/flutter_sound.dart';
import 'package:FPS2/speechtoText/speechtoText.dart';
import 'package:FPS2/fileSystem/fileSystem.dart';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitiated = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    await askPermissions();
    await _audioRecorder!.openRecorder();
    _isRecorderInitiated = true;
  }

  void dispose() {
    if (!_isRecorderInitiated) return;
    _audioRecorder!.closeRecorder();
    _audioRecorder = null;
    _isRecorderInitiated = false;
  }

  Future _record(String projectName) async {
    if (!_isRecorderInitiated) return;
    final String pathToSaveAudio = pathToAudio(projectName);
    //print(pathToSaveAudio);
    await _audioRecorder!.startRecorder(
      codec: Codec.defaultCodec,
      toFile: pathToSaveAudio,
      sampleRate: 16000,
    );
  }

  Future _stop(String projectName) async {
    if (!_isRecorderInitiated) return;

    await _audioRecorder!.stopRecorder();
    speechToText(projectName);
  }

  Future toggleRecording(String projectName) async {
    if (_audioRecorder!.isStopped) {
      await _record(projectName);
    } else {
      await _stop(projectName);
    }
  }
}
