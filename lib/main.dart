import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:open_file/open_file.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  permission();
  runApp(const MyApp());
}

void eatItSnackBar(String message) {
  SnackBar snackBar = SnackBar(
    backgroundColor: const Color.fromARGB(214, 42, 240, 190),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    dismissDirection: DismissDirection.startToEnd,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    ),
    content: Text(message),
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}

Future<void> permission() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print(statuses[Permission.location]);
  }
  // You can can also directly ask the permission about its status.
  if (await Permission.storage.isRestricted) {
    // The OS restricts access, for example because of parental controls.
    eatItSnackBar(
        "The OS restricts access, for example because of parental controls.");
  }
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
  'Low Quality Video',
  'High Quality Video',
  'Audio only',
  'Video only High Quality',
  'Video only Low Quality'
];

class _MyHomePageState extends State<MyHomePage> {
  ///
  String dropdownValue = list.first;
  String url_bae = '';
  int progressBar_G = 0;
  String videoName = '';
  String thumbnails = 'https://cdn-icons-png.flaticon.com/512/1384/1384028.png';
  String thumb2 = 'https://cdn-icons-png.flaticon.com/512/1384/1384028.png';
  late File downloadedPath;
  TextEditingController _controller = TextEditingController();
  bool isAudio = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReceiveSharingIntent.getTextStream().listen(
      (String value) {
        setState(() {
          url_bae = value;
        });
        _controller.text = value;
      },
      onError: (err) {
        eatItSnackBar("Try again!");
        print("getLinkStream error: $err");
      },
    );
  }

  void Tusu(String url) async {
    final yt = YoutubeExplode();
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // the downloads folder path
    Directory? tempDir = await DownloadsPathProvider.downloadsDirectory;
    try {
      await download(
          url
              .replaceAll(" ", "")
              .replaceAll("?feature=share", "")
              .split("?t=")[0],
          tempDir!);
      yt.close();
      progressBar_G = 0;
      eatItSnackBar("Downloaded");
      showMyDialog(context, downloadedPath.path);
    } catch (e) {
      if (e.toString().contains("Invalid YouTube video ID or URL:")) {
        eatItSnackBar("Invalid YouTube video ID or URL");
      } else {
        print(e);
        eatItSnackBar(e.toString());
      }
    }
  }

  Future<void> download(String id, Directory dir) async {
    final yt = YoutubeExplode();
    var streams, file;

    // Get video metadata.
    var video = await yt.videos.get(id);

    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(id);

    if (dropdownValue == "High Quality Video") {
      streams = manifest.muxed.sortByVideoQuality();
    } else if (dropdownValue == "Low Quality Video") {
      streams = manifest.muxed;
    } else if (dropdownValue == "Audio only") {
      streams = manifest.audioOnly;
      isAudio = true;
    } else if (dropdownValue == "Video only High Quality") {
      streams = manifest.videoOnly.sortByVideoQuality();
    } else if (dropdownValue == "Video only Low Quality") {
      streams = manifest.videoOnly;
    }

    // Get the audio track with the highest bitrate.
    var audio = streams.first;
    var videoStream = yt.videos.streamsClient.get(audio);

    thumbnails = video.thumbnails.highResUrl;

    // Compose the file name removing the unallowed characters in windows.
    var fileName = '${video.title}.${audio.container.name}'
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', '');

    if (isAudio == true) {
      file = File('${dir.path}/$fileName' + '.mp3');
    } else {
      file = File('${dir.path}/$fileName');
    }

    print(file.path);
    downloadedPath = file;

    // Delete the file if exists.
    if (file.existsSync()) {
      // file.deleteSync();
      yt.close();
      eatItSnackBar("File already downloaded");
    }

    file.createSync();

    // Open the file in writeAppend.
    var output = file.openWrite(mode: FileMode.writeOnlyAppend);

    // Track the file download status.
    var len = audio.size.totalBytes;
    var count = 0;

    // Create the message and set the cursor position.
    var msg = 'Downloading ${video.title}.${audio.container.name}';
    videoName = '${video.title}.${audio.container.name}';
    print(msg);

    await for (final data in videoStream) {
      count += data.length;
      progressBar_G = ((count / len) * 100).ceil();
      output.add(data);
      print("Progress   ${progressBar_G}");
      setState(() {});
    }
    await output.close();
  }

  showMyDialog(BuildContext context, String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Video downloaded successfully"),
          content: Text(
            videoName,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Play'),
              onPressed: () {
                print("open");
                isAudio = false;
                if (filePath.contains(".mp4.mp3")) {
                  OpenFile.open(filePath, type: "audio/mp3");
                } else if (filePath.contains("mp4")) {
                  OpenFile.open(filePath, type: "video/mp4");
                } else if (filePath.contains("3gpp")) {
                  OpenFile.open(filePath, type: "video/3gpp");
                } else {
                  OpenFile.open(filePath);
                }
                Navigator.of(context).pop(true);
              },
            ),
            ElevatedButton(
              onPressed: () {
                print("cancel");
                final yt = YoutubeExplode();
                yt.close();
                isAudio = false;
                progressBar_G = 0;
                url_bae = "";
                _controller.text = "";
                videoName = "";
                thumbnails = thumb2;
                print("Cancel Download");
                setState(() {});
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
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
                controller: _controller,
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                  label: Text('Enter Url'),
                ),
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                ),
                cursorWidth: 2,
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
                color: const Color.fromARGB(255, 42, 240, 190),
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
                      eatItSnackBar("Love You Darling");
                    },
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    if (url_bae.isEmpty) {
                      eatItSnackBar("Please Enter Url");
                    } else {
                      Tusu(url_bae);
                    }
                  },
                  color: const Color.fromARGB(255, 42, 240, 190),
                  child: const Text('Download Video'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 42, 240, 190),
                    ),
                    tooltip: 'Cancel Download / Clear',
                    onPressed: () {
                      progressBar_G = 0;
                      final yt = YoutubeExplode();
                      yt.close();
                      url_bae = "";
                      _controller.text = "";
                      videoName = "";
                      isAudio = false;
                      thumbnails = thumb2;
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
                dropdownColor: const Color.fromARGB(255, 42, 240, 190),
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 42, 240, 190),
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
    //parr
  }
}
