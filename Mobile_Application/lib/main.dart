import 'package:flutter/material.dart';
import '../recordAPI/soundRecorder.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../connectDatabase/connectDatabase.dart';

final navigatorKey = GlobalKey<NavigatorState>();
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
      navigatorKey: navigatorKey,
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
  List<Project>? projects;
  bool _isLoading = false;
  Project? selectedProject;
  String? visitorName;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedProject = null;
    visitorName = null;
    getProjects();
    recorder.init();
  }

  void getProjects() async {
    setState(() {
      _isLoading = true;
    });

    projects = await fetchAllProject();
    setState(() {
      _isLoading = false;
    });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 150, bottom: 15),
                child: buildDropDown(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 25),
                width: 250,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter visitor name',
                  ),
                ),
              ),
              Container(
                child: buildStart(),
              )
            ],
          ),
        ));
  }

  Widget buildStart() {
    final icon =
        recorder.isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic);
    final micText = recorder.isRecording ? 'STOP' : 'START';
    final primary = recorder.isRecording ? Colors.red : Colors.white;
    final onPrimary = recorder.isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 50),
          primary: primary,
          onPrimary: onPrimary,
        ),
        icon: icon,
        label: Text(
          micText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          if (selectedProject == null) {
            showAlertDialog(context, "Please select a project");
          }
          if (nameController.text == "") {
            showAlertDialog(context, "Please enter visitor name");
          } else {
            await recorder.toggleRecording(
                selectedProject!, nameController.text);
            setState(() {});
          }
        });
  }

  Widget buildDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.yellow,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select a Project',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: projects?.map<DropdownMenuItem<Project>>((Project value) {
          return DropdownMenuItem<Project>(
            value: value,
            child: Text(
              value.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        value: selectedProject,
        onChanged: (value) {
          setState(() {
            selectedProject = value as Project;
          });
        },
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.yellow,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: 160,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: Colors.blue,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 300,
        dropdownWidth: 220,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: Colors.blueGrey[800],
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String dialog) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () => Navigator.pop(context, 'OK'),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    //title: Text("My title"),
    content: Text(dialog),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
