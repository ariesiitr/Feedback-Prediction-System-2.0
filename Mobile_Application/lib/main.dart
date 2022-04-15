import 'package:flutter/material.dart';
import 'package:FPS2/recordAPI/soundRecorder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recorder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final recorder = SoundRecorder();

  @override
  void initState() {
    super.initState();
    recorder.init();

  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(MyApp.title),
        title: const Text('Recorder'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: buildStart(),
      ),
    );
  }

  Widget buildStart() {
    final icon = recorder.isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic);
    final micText = recorder.isRecording ? 'STOP' : 'START';
    final primary = recorder.isRecording ? Colors.red : Colors.white;
    final onPrimary = recorder.isRecording ? Colors.white : Colors.black;
    const String projectName = "Example";
    int projecId = 0;
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(175, 50),
          primary: primary,
          onPrimary: onPrimary,
        ),
        icon: icon,
        label: Text(
          micText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          await recorder.toggleRecording(projectName);
          setState(() {});
        });
  }
}
