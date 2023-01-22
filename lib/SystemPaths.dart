import 'dart:ffi';
import 'dart:io';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:ffi/ffi.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:win32/win32.dart';

class SystemPaths {
  static const unLen = 256;

  String getUsername() {
    return using<String>((arena) {
      final buffer = arena.allocate<Utf16>(sizeOf<Uint16>() * (unLen + 1));
      final bufferSize = arena.allocate<Uint32>(sizeOf<Uint32>());
      bufferSize.value = unLen + 1;
      final result = GetUserName(buffer, bufferSize);
      if (result == 0) {
        GetLastError();
        throw Exception(
            'Failed to get win32 username: error 0x${result.toRadixString(16)}');
      }
      return buffer.toDartString();
    });
  }

  path() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    // the downloads folder path
    if (Platform.isAndroid) {
      Directory? tempDir = await DownloadsPathProvider.downloadsDirectory;
      return tempDir!.path;
    } else if (Platform.isWindows) {
      String username = getUsername();
      String pcDownloadPath = "C:\\Users\\$username\\Downloads";
      return pcDownloadPath;
    }
  }
}
