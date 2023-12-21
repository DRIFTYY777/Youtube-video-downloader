import 'dart:io';

import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:yt_video/CustomDialogBox.dart';
import 'package:yt_video/main.dart';

class DownloadVideo {
  //
  var tempVideoOutput, tempAudioOutput, finishedOutput;
  bool isHighQuality = false;
  late final BuildContext context;
  DownloadVideo(this.context);
  late File downloadedPath;
  CustomDialogBox dialogBox = CustomDialogBox();

  void Tusu(String url, Function(int progressbar) updatingProgresbar) async {
    //
    final yt = YoutubeExplode();
    //

    String filter = url
        .replaceAll(" ", "")
        .replaceAll("?feature=share", "")
        .split("?t=")[0];
    //
    String tempDir = await systemPath.pathProvider();
    try {
      await _download(filter, tempDir, updatingProgresbar);
      if (isHighQuality == true) {
        finishedOutput =
            things.combineAudioVideo(tempAudioOutput, tempVideoOutput);
      }
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
      } else if (e.toString().contains("Bad state: No element")) {
        things
            .eatItSnackBar("Video not available in this quality! Try another");
      } else {
        print(e);
        things.eatItSnackBar(e.toString());
      }
    }
  }

  Future<void> _download(
      String id, String dir, Function(int progress) update) async {
    // Create a new instance of YoutubeExplode.
    final yt = YoutubeExplode();

    var streams, file;

    // Get video metadata.
    var video = await yt.videos.get(id);

    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(id);

    switch (dropdownValue) {
      case "Audio only":
        streams = manifest.audioOnly;
        isAudio = true;
        break;

      case "Low 144p":
        streams = manifest.muxed;
        break;

      case "Low 240p":
        streams = manifest.muxed
            .where((element) => element.videoQuality == VideoQuality.low240)
            .toList();
        break;

      case "Medium 360p":
        streams = manifest.muxed
            .where((element) => element.videoQuality == VideoQuality.medium360)
            .toList();
        break;

      case "Medium 480p SD":
        streams = manifest.muxed
            .where((element) => element.videoQuality == VideoQuality.medium480)
            .toList();
        break;

      case "High 720p HD":
        streams = manifest.muxed
            .where((element) => element.videoQuality == VideoQuality.high720)
            .toList();
        break;

      case "High 1080p FHD":
        streams = manifest.videoOnly
            .where((element) =>
                element.videoQuality == VideoQuality.high1080 &&
                element.container.name == "webm")
            .toList();
        isHighQuality = true;
        break;

      case "High 1440p QHD/2K":
        streams = manifest.videoOnly
            .where((element) =>
                element.videoQuality == VideoQuality.high1440 &&
                element.container.name == "webm")
            .toList();
        isHighQuality = true;
        break;

      case "High 2160p UHD/4K":
        streams = manifest.videoOnly
            .where((element) =>
                element.videoQuality == VideoQuality.high2160 &&
                element.container.name == "webm")
            .toList();
        isHighQuality = true;
        break;

      case "High 2880p 5K":
        streams = manifest.videoOnly
            .where((element) =>
                element.videoQuality == VideoQuality.high2880 &&
                element.container.name == "webm")
            .toList();
        isHighQuality = true;
        break;

      case "High 3072p 6K":
        streams = manifest.videoOnly
            .where((element) =>
                element.videoQuality == VideoQuality.high3072 &&
                element.container.name == "webm")
            .toList();
        isHighQuality = true;
        break;

      case "High 4320p 8K":
        streams = manifest.videoOnly
            .where((element) =>
                element.videoQuality == VideoQuality.high4320 &&
                element.container.name == "webm")
            .toList();
        isHighQuality = true;
        break;

      default:
        // Handle the case when the dropdownValue doesn't match any of the cases
        break;
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
      file = File('$dir/$fileName.mp3');
    } else {
      file = File('$dir/$fileName');
    }

    print(file.path);
    downloadedPath = file;

    // Delete the file if exists.
    if (file.existsSync()) {
      //file.deleteSync();
      yt.close();
      things.eatItSnackBar("File already downloaded");
    }

    file.createSync();

    // Open the file in writeAppend.
    tempVideoOutput = file.openWrite(mode: FileMode.writeOnlyAppend);

    // Track the file download status.
    var len = audio.size.totalBytes;
    var count = 0;

    // Create the message and set the cursor position.
    var msg = 'Downloading ${video.title}.${audio.container.name}';
    videoName = '${video.title}.${audio.container.name}';
    print(msg);

    await Future.wait([
      (() async {
        await for (final data in videoStream) {
          count += data.length;
          progressBar_G = ((count / len) * 100).ceil();
          tempVideoOutput.add(data);
          print("Progress   $progressBar_G");
          update(progressBar_G);
        }
      })(),
      _downloadSong(id)
    ]);
    await tempVideoOutput.flush();
    await tempVideoOutput.close();
  }

/////////////////////////////////////////////
  ///
  ///
  ///
/////////////////////////////////////////////
  Future<String?> _downloadSong(String id) async {
    if (isHighQuality == false) {
      return null;
    }
    String tempDir = await systemPath.pathProvider();
    final yt = YoutubeExplode();
    var streams, file;
    // Get video metadata.
    var video = await yt.videos.get(id);
    // Get the video manifest.
    var manifest = await yt.videos.streamsClient.getManifest(id);
    streams = manifest.audioOnly;
    // Get the audio track with the highest bitrate.
    var audio = streams.first;
    var videoStream = yt.videos.streamsClient.get(audio);
    // Compose the file name removing the unallowed characters in windows.
    var fileName = '${video.title}.${audio.container.name}'
        .replaceAll(".mp4", "")
        .replaceAll(r'\', '')
        .replaceAll('/', '')
        .replaceAll('*', '')
        .replaceAll('?', '')
        .replaceAll('"', '')
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('|', '');
    file = File('$tempDir/$fileName.mp3');
    print(file.path);
    downloadedPath = file;
    // Delete the file if exists.
    if (file.existsSync()) {
      file.deleteSync();
    }
    file.createSync();
    // Open the file in writeAppend.
    tempAudioOutput = file.openWrite(mode: FileMode.writeOnlyAppend);
    await for (final data in videoStream) {
      tempAudioOutput.add(data);
    }
    //await output.close();
    await tempAudioOutput.flush();
    await tempAudioOutput.close();
    print(tempAudioOutput);
    isHighQuality == true;
    return tempAudioOutput;
  }

  void downloadCancel() {
    YoutubeExplode? yt = YoutubeExplode();
    progressBar_G = 0;
    yt.close();
    yt = null;
    url_bae = "";
    controller.text = "";
    videoName = "";
    isAudio = false;
    if (tempVideoOutput != null) {
      tempVideoOutput.flush();
      //output.close();
    }
    thumbnails = thumb2;
  }
}
