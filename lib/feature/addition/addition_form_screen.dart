import 'dart:io';

import 'package:calorie_tracker_app/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';

class AdditionFormScreen extends StatefulWidget {
  @override
  _AdditionFormScreenState createState() => _AdditionFormScreenState();
}

class _AdditionFormScreenState extends State<AdditionFormScreen> {
  File? _selectedImage;

  void _handleImageChange(File? image) {
    setState(() {
      _selectedImage = image;
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
          ImagePickerWidget(onImagePicked: _handleImageChange),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _selectedImage != null
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Upload Status'),
                          content: Text('ok'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              child: Text('Submit Image'),
            ),
          ),
        ],
      ),
    );
  }
}
