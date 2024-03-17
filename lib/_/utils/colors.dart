// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const mobileBackgroundColor = Color.fromARGB(255, 247, 246, 243);
const webBackgroundColor = Color.fromARGB(255, 241, 241, 241);
const mobileSearchColor = Color.fromARGB(255, 165, 165, 165);
const blueColor = Color.fromRGBO(0, 149, 246, 1);
const primaryColor = Color.fromARGB(255, 153, 66, 66);
const secondaryColor = Color.fromARGB(255, 83, 83, 83);
const mobileAppbarBackgroundColor = Color.fromARGB(255, 255, 255, 255);

class PalletteColors {
  static get primaryRed => Color(0xffFD5D5D);
  static get lightSkin => Color(0xffF4DED6);
  static get lightBlue => Color(0xffC8D5EB);
  static get primaryGrey => Color(0xff3A4255);
  static get g1 => Color(0xffFD5D5D);
  static get g2 => Color(0xffFCCF31);
  // sistem navigation bar renklerine yakın nav bar renkleri seçildi
  static get sysNavPriColar => Color(0xff3A4255);
  static get sysNavSecColar => Color.fromARGB(255, 167, 165, 165);
}

class MyTheme {
  MyTheme._();
  static Color kPrimaryColor = Color.fromARGB(255, 89, 88, 117);
  static Color kPrimaryColorVariant = Color(0xff686795);
  static Color kAccentColor = Color(0xffFCAAAB);
  static Color kAccentColorVariant = Color(0xffF7A3A2);
  static Color kUnreadChatBG = Color(0xffEE1D1D);

  static final TextStyle heading2 = TextStyle(
    color: Color(0xff686795),
    fontSize: 19,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static final TextStyle chatSenderName = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  static final TextStyle bodyText1 = TextStyle(
      color: Color(0xffAEABC9),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static final TextStyle bodyTextMessage =
      TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  static final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );

  static final TextStyle postFeedScreenName = TextStyle(
    color: Color.fromARGB(255, 97, 96, 150),
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.3,
  );
}
