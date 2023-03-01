import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:yt_video/Download.dart';

import 'Things.dart';
import 'SystemPaths.dart';

Things things = Things();
SystemPaths systemPath = SystemPaths();

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await things.permission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      title: 'Youtube Video Downloader',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 42, 240, 190),
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Youtube Video Downloader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const List<String> list = <String>[
  'Low 144p',
  'Low 240p',
  'Medium 360p',
  'Medium 480p SD',
  'High 720p HD',
  // 'High 1080p FHD',
  // 'High 1440p QHD/2K',
  // 'High 2160p UHD/4K',
  // 'High 2880p 5K',
  // 'High 3072p 6K',
  // 'High 4320p 8K',
  'Audio only'
];

String thumbnails = 'https://cdn-icons-png.flaticon.com/512/1384/1384028.png';
String thumb2 = 'https://cdn-icons-png.flaticon.com/512/1384/1384028.png';
String videoName = '';
int progressBar_G = 0;
String url_bae = '';
String dropdownValue = list.first;
bool isAudio = false;
TextEditingController controller = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  ///
  late DownloadVideo downloadVideo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReceiveSharingIntent.getTextStream().listen(
      (String value) {
        setState(() {
          url_bae = value;
        });
        controller.text = value;
      },
      onError: (err) {
        things.eatItSnackBar("Try again!");
        print("getLinkStream error: $err");
      },
    );
    downloadVideo = DownloadVideo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                backgroundImage: Image.network(thumbnails).image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                videoName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 43, 224, 248),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  label: Text('ENTER URL'),
                ),
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: Color.fromARGB(255, 43, 224, 248),
                ),
                cursorWidth: 2,
                cursorHeight: 25,
                onChanged: (value) {
                  setState(() {
                    url_bae = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                value: progressBar_G / 100,
                backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                color: const Color.fromARGB(255, 43, 224, 248),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                progressBar_G == 0 ? "" : "$progressBar_G%",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 43, 224, 248),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                    hoverColor: const Color.fromARGB(0, 42, 240, 190),
                    icon: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(0, 42, 240, 190),
                    ),
                    onPressed: () {
                      things.eatItSnackBar("Just for padding");
                    },
                  ),
                ),
                CupertinoButton(
                  onPressed: () async {
                    if (url_bae.isEmpty) {
                      things.eatItSnackBar("Please Enter Url");
                    } else {
                      downloadVideo.Tusu(url_bae, (p) {
                        setState(() {
                          progressBar_G = p;
                        });
                      });
                    }

                    ///
                    //things.changeVideoFormat(
                    //    'C:\\Users\\Driftyy_777\\Downloads\\Not_Working.mp4',
                    //    'C:\\Users\\Driftyy_777\\Downloads\\Working.mp4');
                  },
                  color: const Color.fromARGB(255, 43, 224, 248),
                  child: const Text('Download Video'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 43, 224, 248),
                    ),
                    tooltip: 'Cancel Download / Clear',
                    onPressed: () {
                      //progressBar_G = 0;
                      //final yt = YoutubeExplode();
                      //yt.close();
                      // url_bae = "";
                      // controller.text = "";
                      // videoName = "";
                      // isAudio = false;
                      //thumbnails = thumb2;
                      downloadVideo.downloadCancel();
                      setState(() {});
                      print("Cancel Download");
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                ),
                borderRadius: BorderRadius.circular(8),
                dropdownColor: Color.fromARGB(255, 0, 0, 0),
                underline: Container(
                  height: 2,
                  color: Color.fromARGB(255, 43, 224, 248),
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                    print(dropdownValue);
                  });
                },
                items: list.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
