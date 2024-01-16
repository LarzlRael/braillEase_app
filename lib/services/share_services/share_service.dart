part of './../services.dart';

abstract class ShareService {
  Future<bool> shareOnlyText(String text);
  Future<bool> shareFilesAndText(List<String> filePaths,
      {String? message, String? subject});
}
