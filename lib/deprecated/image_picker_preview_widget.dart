import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerPreviewWidget extends StatefulWidget {
  final Function(File?) onImagePicked;

  const ImagePickerPreviewWidget({Key? key, required this.onImagePicked})
      : super(key: key);

  @override
  _ImagePickerPreviewWidgetState createState() => _ImagePickerPreviewWidgetState();
}

class _ImagePickerPreviewWidgetState extends State<ImagePickerPreviewWidget> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // 打印
        final imageTemp = File(pickedFile.path);
        final imageBytes = imageTemp.readAsBytesSync();
        print("Image Size: ${imageBytes.length / 1024} KB");

        File imageFile = File(pickedFile.path);

        // 打印文件路径
        print("Image Path: ${imageFile.path}");

        // 打印文件名
        print("Image Name: ${path.basename(imageFile.path)}");

        // 打印文件大小
        print("Image Size: ${await imageFile.length()} bytes");

        // 获取并打印图片尺寸
        var compressedImage = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 1920,
          minHeight: 1080,
          quality: 88,
        );
        print("Image Dimensions: ${compressedImage!.length} (compressed)");

        // 打印MIME类型（简单判断）
        String mimeType =
            'image/${path.extension(imageFile.path).replaceFirst('.', '')}';
        print("Content Type: $mimeType");

        setState(() {
          _image = File(pickedFile.path);
          widget.onImagePicked(_image);
        });
      } else {
        widget.onImagePicked(null);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: _image != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.check_circle,
                          color: Colors.green, size: 24),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _image = null;
                          widget.onImagePicked(null);
                        });
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Text('Tap here to pick an image'),
              ),
      ),
    );
  }
}
