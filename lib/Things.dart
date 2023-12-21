
import 'main.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

///Things contains all the methods and variables that are used in the app
///
///Also contains the basics [Functions]
class Things {
  ///
  /// [SnackBar] is used to show Message in the bottom of the screen
  ///
  /// Only one param [message] is required
  void eatItSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 43, 224, 248),
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

  ///@permission()
  ///
  /// [Permission] is used to ask for permission to access the storage
  ///
  /// And also to check if the permission is granted or not
  ///
  /// If the permission is not granted then it will ask for permission
  ///
  /// And if the permission is granted then it will do nothing
  ///
  /// And if the permission is denied then it will ask for permission
  ///
  /// And if the permission is denied permanently then it will show a message
  ///
  /// That the permission is denied permanently
  ///
  /// And if the permission is restricted then it will show a message
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
      debugPrint(statuses[Permission.location].toString());
    }
    // You can can also directly ask the permission about its status.
    if (await Permission.storage.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      eatItSnackBar(
          "The OS restricts access, for example because of parental controls.");
    }
  }

  String output = "C:\\Users\\Driftyy_777\\Downloads\\muxed.mp4";

  Future<String> combineAudioVideo(String audio, String video) async {
   
    return output;
  }
}
