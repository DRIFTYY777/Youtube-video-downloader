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
  final yt = YoutubeExplode();

  void Tusu(String url, Function(int progressbar) updatingProgresbar) async {
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

  var output;

  Future<int> download(
      String id, String dir, Function(int progress) update) async {
    final yt = YoutubeExplode();
    var streams, file;

    // Get video metadata.
    var video = await yt.videos.get(id);

    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(id);

    if (dropdownValue == "Audio only") {
      streams = manifest.audioOnly;
      isAudio = true;
    } else if (dropdownValue == 'Low 144p') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.low144);
    } else if (dropdownValue == 'Low 240p') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.low240);
    } else if (dropdownValue == 'Medium 360p') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.medium360);
    } else if (dropdownValue == 'Medium 480p SD') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.medium480);
    } else if (dropdownValue == 'High 720p HD') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.high720);
    } else if (dropdownValue == 'High 1080p FHD') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.high1080);
    } else if (dropdownValue == 'High 1440p QHD/2K') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.high1440);
    } else if (dropdownValue == 'High 2160p UHD/4K') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.high2160);
    } else if (dropdownValue == 'High 2880p 5K') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.high2880);
    } else if (dropdownValue == 'High 3072p 6K') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.high3072);
    } else if (dropdownValue == 'High 4320p 8K') {
      streams = manifest.ssss
          .where((element) => element.videoQuality == VideoQuality.high4320);
    } else if (dropdownValue == 'another') {
      print(manifest.ssss);
      return 0;
    }

    ///

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
      file = File('$dir/$fileName.mp3');
    } else {
      file = File('$dir/$fileName');
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
    output = file.openWrite(mode: FileMode.writeOnlyAppend);

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
      print("Progress   $progressBar_G");
      // setState(() {});
      update(progressBar_G);
    }
    //await output.close();
    await output.flush();
    await output.close();
    return 0;
  }

  void downloadCancel() {
    progressBar_G = 0;
    yt.close();
    url_bae = "";
    controller.text = "";
    videoName = "";
    isAudio = false;
    if (output != null) {
      output.flush();
      //output.close();
    }
    thumbnails = thumb2;
  }
}
