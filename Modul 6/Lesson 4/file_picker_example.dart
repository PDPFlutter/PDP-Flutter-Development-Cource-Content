import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

abstract class FileUploadDataSource {
  Future<MapEntry<String, Uint8List>?> pickFile({String? dialogTitle, List<String> allowedExtensions});
  Future<MapEntry<String, Uint8List>?> pickImage({String? dialogTitle});
}

class FileUploadDataSourceImpl implements FileUploadDataSource {
  final FilePicker filePicker;
  const FileUploadDataSourceImpl({required this.filePicker});

  @override
  Future<MapEntry<String, Uint8List>?> pickFile({
    String? dialogTitle,
    List<String> allowedExtensions = const ['doc'],
  }) async {
    try {
      final result = await filePicker.pickFiles(
        dialogTitle: dialogTitle,
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (status) => log("On file loading status: $status", name: "FileUploadDataSource"),
        allowedExtensions: allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.first.bytes;
        final filename = result.files.first.name;
        final MapEntry<String, Uint8List> file = MapEntry(filename, fileBytes!);

        log(result.names.toString(), name: "Upload File Names");
        return file;
      }
    } catch (e) {
      log(e.toString(), name: "Upload File Error");
    }

    return null;
  }

  @override
  Future<MapEntry<String, Uint8List>?> pickImage({String? dialogTitle}) async {
    try {
      final result = await filePicker.pickFiles(
        dialogTitle: dialogTitle,
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (status) => log("On file loading status: $status", name: "FileUploadDataSource"),
        allowedExtensions: ['jpg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.first.bytes;
        final filename = result.files.first.name;
        final MapEntry<String, Uint8List> file = MapEntry(filename, fileBytes!);

        log(result.names.toString(), name: "Upload File Names");
        log(result.files.toString(), name: "Upload File Datas");

        return file;
      }
    } catch (e) {
      log(e.toString(), name: "Upload File Error");
    }

    return null;
  }
}
