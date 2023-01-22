import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_video/CustomDialogBox.dart';
import 'package:yt_video/main.dart';

class DownloadVideo {
  late final BuildContext context;
  DownloadVideo(this.context);
  late File downloadedPath;
  CustomDialogBox dialogBox = CustomDialogBox();

  void Tusu(String url, Function(int progressbar) updatingProgresbar) async {
    final yt = YoutubeExplode();
    String tempDir = await systemPath.path();
    try {
      await download(
          url
              .replaceAll(" ", "")
              .replaceAll("?feature=share", "")
              .split("?t=")[0],
          tempDir,
          updatingProgresbar);
      yt.close();
      progressBar_G = 0;
      things.eatItSnackBar("Downloaded");

      if (Platform.isAndroid) {
        MediaScanner.loadMedia(
            path: downloadedPath.path); //update gallery after download
        dialogBox.showMyDialog(context, downloadedPath.path);
      }
    } catch (e) {
      if (e.toString().contains("Invalid YouTube video ID or URL:")) {
        things.eatItSnackBar("Invalid YouTube video ID or URL");
      } else {
        print(e);
        things.eatItSnackBar(e.toString());
      }
    }
  }

  Future<void> download(
      String id, String dir, Function(int progress) update) async {
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
      file = File('${dir}/$fileName' + '.mp3');
    } else {
      file = File('${dir}/$fileName');
    }

    print(file.path);
    downloadedPath = file;

    // Delete the file if exists.
    if (file.existsSync()) {
      // file.deleteSync();
      yt.close();
      things.eatItSnackBar("File already downloaded");
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
      // setState(() {});
      update(progressBar_G);
    }
    await output.close();
  }
}
