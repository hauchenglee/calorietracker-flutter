import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerWidget extends StatefulWidget {
  final Function(File?) onImagePicked;

  const ImagePickerWidget({Key? key, required this.onImagePicked}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? _imageName;

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {


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
        String mimeType = 'image/${path.extension(imageFile.path).replaceFirst('.', '')}';
        print("Content Type: $mimeType");


        setState(() {
          _selectedImage = File(pickedFile.path);
          _imageName = path.basename(_selectedImage!.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.file_upload),
            label: Text("Upload File"),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                _imageName ?? '',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
