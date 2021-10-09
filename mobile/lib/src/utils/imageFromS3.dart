import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

class ImageFromS3 {
  Future<void> getDownloadUrl(String key) async {
    try {
      final GetUrlResult result = await Amplify.Storage.getUrl(key: key);
      return result.url;
    } on StorageException catch (e) {
      print('Error getting download URL: $e');
    }
  }

  Future<String> getDownloadUrlReturn(String key) async {
    String url = '';
    try {
      final GetUrlResult result = await Amplify.Storage.getUrl(key: key);
      url = result.url;
    } on StorageException catch (e) {
      print('Error getting download URL: $e');
    }
    return url;
  }
}
