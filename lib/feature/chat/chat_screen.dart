import 'dart:io';

import 'package:calorie_tracker_app/feature/chat/chat_service.dart';
import 'package:calorie_tracker_app/util/api_response.dart';
import 'package:calorie_tracker_app/util/app_theme.dart';
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _calorieController = TextEditingController();
  final TextEditingController _carbohydrateController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  void _clearFields() {
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
      ApiResponse response1 = await ChatService().uploadImage(imageFile: imageFile); // 等待图片上传
      if (!mounted) return;
      ApiResponse response2 = await ChatService().chatVersion(imageName: response1.data); // 等待版本检查
      if (!mounted) return;

      // 假设response2.data是一个Map<String, dynamic>类型，其中包含了ChatModel的所有字段
      Map<String, dynamic> chatData = response2.data;

      CustomDialog().showCustomDialog(context, response2.message);

      // 将获取到的数据填充到TextField的控制器中
      _nameController.text = chatData['name'] ?? '';
      _calorieController.text = chatData['calorie']?.toString() ?? '';
      _carbohydrateController.text = chatData['carbohydrate']?.toString() ?? '';
      _proteinController.text = chatData['protein']?.toString() ?? '';
      _fatController.text = chatData['fat']?.toString() ?? '';
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
                      color: AppTheme.iceBlue1,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25), // 深色阴影，半透明
                          offset: Offset(0, 2), // 阴影偏移量，轻微向下
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1), // 浅色高光，增强深度感
                          offset: Offset(0, -2), // 阴影偏移量，轻微向上
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: _image == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.add_photo_alternate_outlined, size: 50),
                              const SizedBox(height: 10), // Add some space between the container and the buttons
                              Text('Select Your Image'),
                            ],
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(_image!, fit: BoxFit.cover), // 展示选择的图片
                              Container(
                                color: AppTheme.autumnRed1.withOpacity(0.5), // 绿色蒙版，透明度50%
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
                  padding: EdgeInsets.all(5.0), // 为CancelBtn增加5像素的边距
                  child: CancelBtn(
                    onPressed: _clearImage,
                    message: "取消選取",
                    widthScale: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0), // 为CancelBtn增加5像素的边距
                  child: ConfirmBtn(
                    onPressed: () {
                      if (_image != null) {
                        _onPressChat(context, _image!);
                      } else {
                        CustomDialog().showCustomDialog(context, "請選擇圖片");
                      }
                    },
                    message: "詢問 AI",
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
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name / 名稱'),
          ),
          TextField(
            controller: _calorieController,
            decoration: InputDecoration(labelText: 'Calorie / 卡路里'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _carbohydrateController,
            decoration: InputDecoration(labelText: 'Carbohydrate / 碳水化合物'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _proteinController,
            decoration: InputDecoration(labelText: 'Protein / 蛋白質'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _fatController,
            decoration: InputDecoration(labelText: 'Fat / 脂肪'),
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
              padding: const EdgeInsets.all(8.0),
              child: CancelBtn(
                onPressed: _clearFields,
                message: "清空",
                widthScale: 1,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConfirmBtn(
                onPressed: _submitData,
                message: "儲存結果",
                widthScale: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
