import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'main.dart';

class CustomDialogBox {
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
                debugPrint("open");
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
                debugPrint("cancel");
                final yt = YoutubeExplode();
                yt.close();
                isAudio = false;
                progressBar_G = 0;
                url_bae = "";
                controller.text = "";
                videoName = "";
                thumbnails = thumb2;
                debugPrint("Cancel Download");
                // setState(() {}); /////////////////////////////
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            )
          ],
        );
      },
    );
  }
}
