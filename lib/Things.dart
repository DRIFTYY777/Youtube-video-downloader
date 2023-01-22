import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'main.dart';

class Things {
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
}
