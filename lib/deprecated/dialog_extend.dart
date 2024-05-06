// import 'package:flutter/material.dart';
//
// double _btnHeight = 60;
// double _borderWidth = 2;
//
// class DialogExtend extends StatefulWidget {
//   final String title;
//   final String cancelBtnTitle;
//   final String okBtnTitle;
//   final VoidCallback cancelBtnTap;
//   final VoidCallback okBtnTap;
//   final TextEditingController vc;
//
//   DialogExtend(
//       {required this.title,
//       this.cancelBtnTitle = "Cancel",
//       this.okBtnTitle = "Ok",
//       required this.cancelBtnTap,
//       required this.okBtnTap,
//       required this.vc});
//
//   @override
//   State<DialogExtend> createState() => _DialogExtendState();
// }
//
// class _DialogExtendState extends State<DialogExtend> {
//   bool _isExpanded = false;
//   List<TextEditingController> _controllers = [];
//   final List<String> _fieldIds = [
//     "field_name_1", "field_name_1", "field_name_1", "field_name_1", "field_name_1",
//     "field_name_1", "field_name_1", "field_name_1", "field_name_1", "field_name_1"
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < 10; i++) {
//       _controllers.add(TextEditingController());
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   List<Widget> _buildTextFields() {
//     return List.generate(10, (index) {
//       return TextField(
//         controller: _controllers[index],
//         decoration: InputDecoration(
//           labelText: '${_fieldIds[index]} 字段',
//           border: OutlineInputBorder(),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double _containerHeight = _isExpanded ? 600 : 100;  // Adjust the container height based on expansion
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       curve: Curves.decelerate,
//       margin: const EdgeInsets.only(top: 20),
//       height: _containerHeight,
//       width: MediaQuery.of(context).size.width,
//       alignment: Alignment.topCenter,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _isExpanded = !_isExpanded; // Toggle expansion state
//                 });
//               },
//               child: Text(_isExpanded ? '收起输入框' : '展开输入框'),
//             ),
//             if (_isExpanded) ..._buildTextFields(),
//           ],
//         ),
//       ),
//     );
//   }
// }
