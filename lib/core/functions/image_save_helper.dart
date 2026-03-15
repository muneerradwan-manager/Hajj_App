import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';

/// Downloads an image from [imageUrl] and saves it to the device gallery.
/// Returns `true` on success, `false` on failure.
Future<bool> downloadImageToGallery(String imageUrl) async {
  final response = await Dio().get<List<int>>(
    imageUrl,
    options: Options(responseType: ResponseType.bytes),
  );

  final fileName = fileNameFromUrl(imageUrl);
  final result = await SaverGallery.saveImage(
    Uint8List.fromList(response.data!),
    fileName: fileName,
    androidRelativePath: 'Pictures/Hajj App',
    skipIfExists: false,
  );

  return result.isSuccess;
}

/// Downloads an image from [imageUrl] to a temp directory, then opens
/// the system share sheet.
Future<void> shareImage(String imageUrl, String title) async {
  final tempDir = await getTemporaryDirectory();
  final cacheDir = Directory('${tempDir.path}${Platform.pathSeparator}passport_share');
  await cacheDir.create(recursive: true);

  final fileName = fileNameFromUrl(imageUrl);
  final file = File('${cacheDir.path}${Platform.pathSeparator}$fileName');

  await Dio().download(
    imageUrl,
    file.path,
    options: Options(responseType: ResponseType.bytes),
    deleteOnError: true,
  );

  final shareName = _shareNameFromPath(file.path);
  await Share.shareXFiles([XFile(file.path)], text: '$shareName - $title');
}

/// Requests media/storage permission on Android and iOS.
/// Returns the resulting [PermissionStatus].
Future<PermissionStatus> requestMediaPermission() async {
  if (Platform.isIOS) {
    return Permission.photos.request();
  }

  if (Platform.isAndroid) {
    final photosStatus = await Permission.photos.request();
    if (isPermissionGranted(photosStatus)) return photosStatus;

    final storageStatus = await Permission.storage.request();
    if (isPermissionGranted(storageStatus)) return storageStatus;

    if (photosStatus.isPermanentlyDenied || photosStatus.isRestricted) {
      return photosStatus;
    }
    return storageStatus;
  }

  return PermissionStatus.granted;
}

bool isPermissionGranted(PermissionStatus status) {
  return status.isGranted || status.isLimited;
}

String fileNameFromUrl(String imageUrl) {
  try {
    final uri = Uri.parse(imageUrl);
    if (uri.pathSegments.isNotEmpty) {
      final lastSegment = uri.pathSegments.last.trim();
      if (lastSegment.isNotEmpty) return lastSegment;
    }
  } catch (_) {}
  return 'passport_${DateTime.now().millisecondsSinceEpoch}.jpg';
}

String _shareNameFromPath(String filePath) {
  final fileName = filePath.split(Platform.pathSeparator).last.trim();
  if (fileName.isEmpty) return 'Passport';
  final dotIndex = fileName.lastIndexOf('.');
  if (dotIndex <= 0) return fileName;
  final withoutExtension = fileName.substring(0, dotIndex).trim();
  return withoutExtension.isEmpty ? 'Passport' : withoutExtension;
}
