import 'package:books/ui/general/adapt.dart';
import 'package:books/ui/general/color.dart';
import 'package:flutter/material.dart';

class AppTextStyle{
  static TextStyle get displayXXLarge => TextStyle(color: AppColor.black, fontSize: Adapt.px(30.0), fontFamily: 'Montserrat', fontWeight: FontWeight.bold);
  static TextStyle get displayXLarge => TextStyle(color: AppColor.black, fontSize: Adapt.px(26.0), fontFamily: 'Montserrat');
  static TextStyle get displayLarge => TextStyle(color: AppColor.black, fontSize: Adapt.px(22.0), fontFamily: 'Montserrat');
  static TextStyle get displayLargeWhite => TextStyle(color: AppColor.white, fontSize: Adapt.px(22.0), fontFamily: 'Montserrat');
  static TextStyle get displayLargeHint => TextStyle(color: AppColor.grey, fontSize: Adapt.px(22.0), fontFamily: 'Montserrat');
  static TextStyle get displayMediumLight => TextStyle(color: AppColor.black, fontSize: Adapt.px(16.0), fontFamily: 'Montserrat');
  static TextStyle get displayMedium => TextStyle(color: AppColor.black, fontSize: Adapt.px(14.0), fontFamily: 'Montserrat', fontWeight: FontWeight.bold);
  static TextStyle get displayMediumGray => TextStyle(color: AppColor.grey, fontSize: Adapt.px(14.0), fontFamily: 'Montserrat', fontWeight: FontWeight.bold);
  static TextStyle get displaySmall => TextStyle(color: AppColor.black, fontSize: Adapt.px(12.0), fontFamily: 'Montserrat');
  static TextStyle get displayXSmall => TextStyle(color: AppColor.black, fontSize: Adapt.px(11.0), fontFamily: 'Montserrat');
  static TextStyle get menu => TextStyle(color: AppColor.black, fontSize: Adapt.px(12.0), fontFamily: 'Montserrat');
  static TextStyle get paragraph => TextStyle(color: AppColor.black, fontSize: Adapt.px(15.0), fontFamily: 'Montserrat');
  static TextStyle get search => TextStyle(color: AppColor.black, fontSize: Adapt.px(20.0), fontFamily: 'Montserrat');
  static TextStyle get searchHint => TextStyle(color: AppColor.grey, fontSize: Adapt.px(20.0), fontFamily: 'Montserrat');
}