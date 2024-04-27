import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color green1 = Color(0xFFecede8);
  static const Color green2 = Color(0xFFe4e6d9);
  static const Color green3 = Color(0xFFc0cfb2);
  static const Color green4 = Color(0xFF8ba888);
  static const Color green5 = Color(0xFF49654e);
  static const Color green6 = Color(0xFF253528);

  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF3A5160);
  static const Color background = Color(0xFFF2F3F8);

  static const Color iceBlue1 = Color(0xFFf1f4fb);
  static const Color iceBlue2 = Color(0xFFd5deef);
  static const Color iceBlue3 = Color(0xFFb2caee);
  static const Color iceBlue4 = Color(0xFF89afe0);
  static const Color iceBlue5 = Color(0xFF618fca);
  static const Color iceBlue6 = Color(0xFF3a5985);

  static const Color autumnRed1 = Color(0xFFddd5d2);
  static const Color autumnRed2 = Color(0xFFdedddb);
  static const Color autumnRed3 = Color(0xFFdbc2bd);
  static const Color autumnRed4 = Color(0xFFe0576b);
  static const Color autumnRed5 = Color(0xFFc62038);
  static const Color autumnRed6 = Color(0xFFbb031d);

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color darkGrey = Color(0xFF313A44);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
