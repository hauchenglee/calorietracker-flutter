import 'dart:io';

import 'package:calorie_tracker_app/util/app_string.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerUtil {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    /// 由外部处理错误
    // try {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // 日志打印，可选保留或在生产代码中删除
      final imageBytes = imageFile.readAsBytesSync();
      print("图片大小: ${imageBytes.length / 1024} KB");
      print("图片路径: ${imageFile.path}");
      print("图片名称: ${path.basename(imageFile.path)}");
      print("图片大小: ${await imageFile.length()} 字节");

      // 压缩图片并打印尺寸信息
      var compressedImage = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 1920,
        minHeight: 1080,
        quality: 88,
      );
      print("图片尺寸: ${compressedImage!.length} (压缩后)");
      String mimeType =
          'image/${path.extension(imageFile.path).replaceFirst('.', '')}';
      print("内容类型: $mimeType");

      return imageFile; // 返回图片文件对象
    } else {
      /// 用户没有选择图片或发生错误
      throw Exception(SELECTED_IMAGE_ERR_MSG); // 抛出一个异常
    }
    // } catch (e) {
    //   print('选择图片出错: $e');
    //   return null;
    // }
  }
}

/// // 假设你在一个 StatefulWidget 中，并希望在选择图片后设置状态
//
// File? _image;
//
// void _selectImage() async {
//   ImagePickerUtil imagePickerUtil = ImagePickerUtil();
//   File? selectedImage = await imagePickerUtil.pickImage();
//   setState(() {
//     _image = selectedImage; // 设置选中的图片
//   });
// }

/// with try catch:
///
/// void _selectImage() async {
//   ImagePickerUtil imagePickerUtil = ImagePickerUtil();
//
//   try {
//     File? selectedImage = await imagePickerUtil.pickImage();
//     setState(() {
//       _image = selectedImage;
//     });
//   } catch (e) {
//     print('选择图片时发生错误: $e');
//     // 这里可以添加更多错误处理的代码，比如显示一个错误信息的弹窗
//   }
// }
