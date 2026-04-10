import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/import.dart';

class MediaService extends GetxService {
  static MediaService get instance => Get.find<MediaService>();

  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage({
    required BuildContext context,
    required ImageSource source,
    bool crop = true,
    CropAspectRatio? aspectRatio,
  }) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile == null) return null;

      if (crop) {
        if (!context.mounted) return null;
        return await cropImage(
          pickedFile.path,
          context: context,
          aspectRatio: aspectRatio,
        );
      }

      return File(pickedFile.path);
    } catch (e) {
      kLog(content: 'Error picking image: $e', title: 'MediaService');
      return null;
    }
  }

  Future<List<File>> pickMultiImage({int limit = 9}) async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
        limit: limit,
      );

      return pickedFiles.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      kLog(content: 'Error picking multi-images: $e', title: 'MediaService');
      return [];
    }
  }

  Future<File?> pickVideo({required ImageSource source}) async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(source: source);
      if (pickedFile == null) return null;
      return File(pickedFile.path);
    } catch (e) {
      kLog(content: 'Error picking video: $e', title: 'MediaService');
      return null;
    }
  }

  Future<File?> cropImage(
    String filePath, {
    required BuildContext context,
    CropAspectRatio? aspectRatio,
  }) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: context.loc.cropImage,
            toolbarColor: AppColor.kPrimary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: context.loc.cropImage,
            aspectRatioLockEnabled: false,
          ),
        ],
      );
      if (croppedFile == null) return null;
      return File(croppedFile.path);
    } catch (e) {
      kLog(content: 'Error cropping image: $e', title: 'MediaService');
      return null;
    }
  }

  void showMediaPicker({
    required BuildContext context,
    required Function(List<File> files) onMediaSelected,
    bool allowVideo = false,
    bool allowMultiple = false,
    bool crop = true,
    int imageLimit = 2,
    CropAspectRatio? aspectRatio,
  }) {
    final List<AdaptiveAction> actions = [
      AdaptiveAction(
        label: context.loc.camera,
        icon: Icons.camera_alt_rounded,
        clickName: AppClick.sourceCamera,
        onPressed: () async {
          final file = await pickImage(
            context: context,
            source: ImageSource.camera,
            crop: crop,
            aspectRatio: aspectRatio,
          );
          if (!context.mounted) return;
          if (file != null) onMediaSelected([file]);
        },
      ),
      AdaptiveAction(
        label: context.loc.gallery,
        icon: Icons.photo_library_rounded,
        clickName: AppClick.sourceGallery,
        onPressed: () async {
          if (allowMultiple) {
            final files = await pickMultiImage(limit: imageLimit);
            if (files.isNotEmpty) onMediaSelected(files);
          } else {
            final file = await pickImage(
              context: context,
              source: ImageSource.gallery,
              crop: crop,
              aspectRatio: aspectRatio,
            );
            if (!context.mounted) return;
            if (file != null) onMediaSelected([file]);
          }
        },
      ),
    ];

    if (allowVideo) {
      actions.add(
        AdaptiveAction(
          label: context.loc.video,
          icon: Icons.videocam_rounded,
          clickName: 'source_video',
          onPressed: () async {
            final file = await pickVideo(source: ImageSource.gallery);
            if (file != null) onMediaSelected([file]);
          },
        ),
      );
    }

    showAdaptiveActionSheet(
      context: context,
      title: context.loc.selectMedia,
      actions: actions,
    );
  }
}
