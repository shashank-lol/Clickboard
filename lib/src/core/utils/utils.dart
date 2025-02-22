import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// List<DropdownMenuEntry<String>> semDropdownList =
//     List<int>.generate(8, (index) => index + 1)
//         .map((e) => DropdownMenuEntry(
//               value: e.toString(),
//               label: e.toString(),
//             ))
//         .toList();

enum SnackBarType {
  good(backgroundColor: Colors.green),
  error(backgroundColor: Color(0xFFCF6679));

  const SnackBarType({required this.backgroundColor});
  final Color backgroundColor;
}

showSnackBar(
    {required BuildContext context,
    required String title,
    required SnackBarType snackBarType}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        title,
        style: TextStyle(fontSize: 15),
      ),
      backgroundColor: snackBarType.backgroundColor,
    ));
}

Future<OpenResult?> openFile(String filePath) async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    return OpenFile.open(filePath);
  }
  return null;
}

Future<String?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');

      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } finally {}
  return directory?.path;
}

List<String> departments = ['CE', 'EE', 'ME', 'CSE', 'ECE', 'IT'];
