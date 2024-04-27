import 'dart:io';

import 'package:calorie_tracker_app/feature/chat/chat_service.dart';
import 'package:calorie_tracker_app/util/api_response.dart';
import 'package:calorie_tracker_app/util/app_color.dart';
import 'package:calorie_tracker_app/util/file/image_compress_util.dart';
import 'package:calorie_tracker_app/widget/cancel_btn.dart';
import 'package:calorie_tracker_app/widget/confirm_btn.dart';
import 'package:calorie_tracker_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  File? _image;
  bool _isLoading = false; // 加载状态标志

  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _calorieController = TextEditingController();
  final TextEditingController _carbohydrateController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  void _clearFields() {
    _messageController.clear();
    _nameController.clear();
    _calorieController.clear();
    _carbohydrateController.clear();
    _proteinController.clear();
    _fatController.clear();
  }

  void _selectImage() async {
    ImagePickerCompressUtil imagePickerUtil = ImagePickerCompressUtil();
    File? selectedImage = await imagePickerUtil.pickImage();
    setState(() {
      _image = selectedImage;
    });
  }

  void _clearImage() {
    setState(() {
      _image = null; // 清空图片
    });
  }

  void _onPressChat(BuildContext context, File imageFile) async {
    setState(() {
      _isLoading = true;
    });
    try {
      ApiResponse response1 = await ChatService().uploadImage(imageFile); // 等待图片上传
      if (!mounted) return;
      ApiResponse response2 = await ChatService().chatVersion(response1.data); // 等待版本检查
      if (!mounted) return;
      CustomDialog().showCustomDialog(context, response2.data.toString());
    } catch (e) {
      CustomDialog().showCustomDialog(context, e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _submitData() {
    // 这里只是简单地打印出“ok”，在实际应用中可以进行更复杂的数据处理
    print("ok");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: _selectImage,
                  child: Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.iceBlue2,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(-4, -4), blurRadius: 5, spreadRadius: 1),
                        BoxShadow(color: Colors.white.withOpacity(0.6), offset: Offset(4, 4), blurRadius: 5, spreadRadius: 1),
                      ],
                    ),
                    child: _image == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.image, size: 50),
                              Text('Select Your Image'),
                            ],
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(_image!, fit: BoxFit.cover), // 展示选择的图片
                              Container(
                                color: AppTheme.green1.withOpacity(0.5), // 绿色蒙版，透明度50%
                              ),
                              Center(
                                // 在画面中央增加一个重新选取的图标
                                child: Icon(
                                  Icons.refresh, // 使用刷新图标作为重新选取的概念
                                  size: 80, // 图标大小
                                  color: AppTheme.iceBlue6.withOpacity(0.9), // 图标颜色和透明度与蒙版相同
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20), // Add some space between the container and the buttons
                Padding(
                  padding: EdgeInsets.all(2.0), // 为CancelBtn增加5像素的边距
                  child: CancelBtn(
                    onPressed: _clearImage,
                    message: "Cancel",
                    widthScale: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.0), // 为CancelBtn增加5像素的边距
                  child: ConfirmBtn(
                    onPressed: _image != null
                        ? () {
                            _onPressChat(context, _image!);
                          }
                        : null, // 当_image为null时，onPressed设置为null，按钮禁用
                    message: "Ask AI",
                    widthScale: 1,
                  ),
                ),
                chatForm(),
                bottomBtn(),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget chatForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _messageController,
            decoration: InputDecoration(labelText: 'Message'),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _calorieController,
            decoration: InputDecoration(labelText: 'Calorie'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _carbohydrateController,
            decoration: InputDecoration(labelText: 'Carbohydrate'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _proteinController,
            decoration: InputDecoration(labelText: 'Protein'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _fatController,
            decoration: InputDecoration(labelText: 'Fat'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget bottomBtn() {
    return Align(
      // 定位到底部的按钮
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _clearFields,
                child: Text('Clear'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.autumnRed5),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.iceBlue4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
