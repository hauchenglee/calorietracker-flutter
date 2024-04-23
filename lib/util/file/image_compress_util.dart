import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerCompressUtil {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    // 选择图片，不限制选取时的大小和尺寸，但限制文件格式为JPG(JPEG)或PNG
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100, // 使用最高质量选取图片
    );

    if (pickedFile != null) {
      // 检查文件格式
      String extension = path.extension(pickedFile.path).toLowerCase();
      if (extension != '.jpg' && extension != '.jpeg' && extension != '.png') {
        throw Exception("Selected file is not in JPG, JPEG, or PNG format.");
      }

      File originalFile = File(pickedFile.path);
      String dir = path.dirname(pickedFile.path);
      String filename = path.basenameWithoutExtension(pickedFile.path);
      String newFileName =
          "$filename-${DateTime.now().millisecondsSinceEpoch}$extension";
      final targetPath = path.join(dir, newFileName);

      // 调整尺寸并压缩图片文件大小
      File? compressedFile =
          await _compressAndResizeImage(originalFile, targetPath);

      return compressedFile; // 返回压缩后的图片文件对象
    } else {
      throw Exception("No image selected.");
    }
  }

  Future<File?> _compressAndResizeImage(File file, String targetPath) async {
    int quality = 90;
    File? result;
    while (quality > 50) {
      // 设定压缩质量不低于10
      result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        minWidth: 1024,
        minHeight: 1024,
        quality: quality,
      );

      if (result != null && await result.length() <= 1024 * 1024) {
        return result; // 如果文件大小小于1MB，则返回结果
      }

      quality -= 10; // 如果文件大小仍然超过1MB，降低压缩质量
    }

    return result; // 返回最终压缩的结果，即使它可能仍超过1MB
  }
}
