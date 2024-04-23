import 'dart:io';

import 'package:calorie_tracker_app/util/file/image_compress_util.dart';
import 'package:calorie_tracker_app/widget/submit_btn.dart';
import 'package:flutter/material.dart';

class AdditionFormScreen extends StatefulWidget {
  @override
  _AdditionFormScreenState createState() => _AdditionFormScreenState();
}

class _AdditionFormScreenState extends State<AdditionFormScreen> {
  File? _selectedImage;

  void _selectImage() async {
    ImagePickerCompressUtil imagePickerUtil = ImagePickerCompressUtil();
    File? selectedImage = await imagePickerUtil.pickImage();
    setState(() {
      _selectedImage = selectedImage; // 设置选中的图片
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addition Form'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _selectImage,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _selectedImage != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          _selectedImage!,
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
                                _selectedImage = null;
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
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SubmitBtn(
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
