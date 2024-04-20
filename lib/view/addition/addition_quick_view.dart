import 'package:flutter/material.dart';

double _btnHeight = 60;
double _borderWidth = 2;

class AdditionQuickView extends StatefulWidget {
  final String title;
  final String cancelBtnTitle;
  final String okBtnTitle;
  final VoidCallback cancelBtnTap;
  final VoidCallback okBtnTap;
  final TextEditingController vc;

  AdditionQuickView(
      {required this.title,
      this.cancelBtnTitle = "Cancel",
      this.okBtnTitle = "Ok",
      required this.cancelBtnTap,
      required this.okBtnTap,
      required this.vc});

  @override
  State<AdditionQuickView> createState() => _AdditionQuickViewState();
}

class _AdditionQuickViewState extends State<AdditionQuickView> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: 200,
      width: 10000,
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.grey),
              )),
          Spacer(),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
              style: TextStyle(color: Colors.black87),
              controller: widget.vc,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )),
            ),
          ),
          Container(
            // color: Colors.red,
            height: _btnHeight,
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                Container(
                  // 按钮上面的横线
                  width: double.infinity,
                  color: Colors.blue,
                  height: _borderWidth,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.vc.text = "";
                        widget.cancelBtnTap();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        widget.cancelBtnTitle,
                        style: TextStyle(fontSize: 22, color: Colors.blue),
                      ),
                    ),
                    Container(
                      // 按钮中间的竖线
                      width: _borderWidth,
                      color: Colors.blue,
                      height: _btnHeight - _borderWidth - _borderWidth,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.okBtnTap();
                        Navigator.of(context).pop();
                        widget.vc.text = "";
                      },
                      child: Text(
                        widget.okBtnTitle,
                        style: TextStyle(fontSize: 22, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
