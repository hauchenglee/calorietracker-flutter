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

  Future<String> _onPressChat(BuildContext context, File imageFile) async {
    try {
      ApiResponse response1 = await ChatService().uploadImage(imageFile); // 等待图片上传
      ApiResponse response2 = await ChatService().chatVersion(response1.data); // 等待版本检查
      return response2.data.toString();
    } catch (e) {
      return "Error processing image and version: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _selectImage, // 点击容器时触发图片选择
            child: Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.iceBlue2,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(-4.0, -4.0), blurRadius: 5.0, spreadRadius: 1.0),
                  BoxShadow(color: Colors.white.withOpacity(0.6), offset: Offset(4.0, 4.0), blurRadius: 5.0, spreadRadius: 1.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_isLoading) CircularProgressIndicator(), // 如果正在加载，则显示加载动画
              CancelBtn(
                onPressed: () {
                  _clearImage();
                },
              ),
              ConfirmBtn(
                onPressed: () async {
                  if (_image != null) {
                    setState(() {
                      _isLoading = true; // 开始加载，显示加载动画
                    });
                    String response = await _onPressChat(context, _image!);
                    if (!mounted) return;
                    setState(() {
                      _isLoading = false; // 加载完成，隐藏加载动画
                    });
                    CustomDialog().showCustomDialog(context, response);
                  } else {
                    CustomDialog().showCustomDialog(context, "请选取图片！");
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
