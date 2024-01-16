part of './../services.dart';

class ShareServiceImp extends ShareService {
  @override
  Future<bool> shareFilesAndText(List<String> files,
      {String? message, String? subject}) async {
    try {
      final convertToXFile = files.map((e) => XFile(e)).toList();
      final result = await Share.shareXFiles(
        convertToXFile,
        text: message,
        subject: subject,
      );

      return result.status == ShareResultStatus.success;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> shareOnlyText(String text) async {
    try {
      final result = await Share.shareWithResult(text);
      return result.status == ShareResultStatus.success;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
