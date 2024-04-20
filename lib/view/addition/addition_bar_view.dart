import 'package:calorie_tracker_app/view/addition/addition_quick_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widget/rename_dialog.dart';

class AdditionBarContent extends StatelessWidget {
  final TextEditingController _vc = TextEditingController();

  final renderOverlay = true;
  final switchLabelPosition = false;
  final extend = false;
  final customDialRoot = false;
  final closeManually = false;
  final isDialOpen = ValueNotifier<bool>(false);
  final speedDialDirection = SpeedDialDirection.up;
  final buttonSize = const Size(56.0, 56.0);
  final childrenButtonSize = const Size(56.0, 56.0);
  final selectedfABLocation = FloatingActionButtonLocation.centerDocked;
  final items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];

  AdditionBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent, // 显式设置Scaffold背景为透明
        floatingActionButtonLocation: selectedfABLocation,
        floatingActionButton: SpeedDial(
          // animatedIcon: AnimatedIcons.menu_close,
          // animatedIconTheme: IconThemeData(size: 22.0),
          // / This is ignored if animatedIcon is non null
          // child: Text("open"),
          // activeChild: Text("close"),
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          // dialRoot: customDialRoot
          //     ? (ctx, open, toggleChildren) {
          //         return ElevatedButton(
          //           onPressed: toggleChildren,
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.blue[900],
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 22, vertical: 18),
          //           ),
          //           child: const Text(
          //             "Custom Dial Root",
          //             style: TextStyle(fontSize: 17),
          //           ),
          //         );
          //       }
          //     : null,
          buttonSize: buttonSize,
          // it's the SpeedDial size which defaults to 56 itself
          // iconTheme: IconThemeData(size: 22),
          label: extend ? const Text("Open") : null,
          // The label of the main button.
          /// The active label of the main button, Defaults to label if not specified.
          activeLabel: extend ? const Text("Close") : null,

          /// Transition Builder between label and activeLabel, defaults to FadeTransition.
          // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
          /// The below button size defaults to 56 itself, its the SpeedDial childrens size
          childrenButtonSize: childrenButtonSize,
          direction: speedDialDirection,
          switchLabelPosition: switchLabelPosition,

          /// If true user is forced to close dial manually
          closeManually: closeManually,

          /// If false, backgroundOverlay will not be rendered.
          renderOverlay: renderOverlay,
          // overlayColor: Colors.black,
          // overlayOpacity: 0.5,
          onOpen: () => debugPrint('OPENING DIAL'),
          onClose: () => debugPrint('DIAL CLOSED'),
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          // foregroundColor: Colors.black,
          // backgroundColor: Colors.white,
          // activeForegroundColor: Colors.red,
          // activeBackgroundColor: Colors.blue,
          elevation: 8.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          shape: customDialRoot
              ? const RoundedRectangleBorder()
              : const StadiumBorder(),
          // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [
            SpeedDialChild(
              child: const Icon(FontAwesomeIcons.rocket),
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              label: '快速添加',
              onTap: () => {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return RenameDialog(
                      contentWidget: AdditionQuickView(
                        title: "請輸入飲食記錄",
                        okBtnTap: () {
                          print(
                            "输入框中的文字为:${_vc.text}",
                          );
                        },
                        vc: _vc,
                        cancelBtnTap: () {},
                      ),
                    );
                  },
                ),
              },
            ),
            SpeedDialChild(
              child: const Icon(FontAwesomeIcons.chartBar),
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              label: '新建食物',
              onTap: () => {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return RenameDialog(
                      contentWidget: AdditionQuickView(
                        title: "請輸入食物數據",
                        okBtnTap: () {
                          print(
                            "输入框中的文字为:${_vc.text}",
                          );
                        },
                        vc: _vc,
                        cancelBtnTap: () {},
                      ),
                    );
                  },
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
