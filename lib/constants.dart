import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

const Color backgroundColor2 = Color(0xFF17203A);
const Color backgroundColorLight = Color(0xFFF2F6FF);
const Color backgroundColorDark = Color(0xFF25254B);
const Color shadowColorLight = Color(0xFF4A5367);
const Color shadowColorDark = Colors.black;


const kHeadTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const kHeadSubtitleTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black87,
);
const kDefaultPadding = 20.0;

// our default Shadow
const kDefaultShadow = BoxShadow(
offset: Offset(0, 15),
blurRadius: 27,
color: Colors.black12,
);// Black coconst kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kSecondaryColor = Color(0xFFFFA41B);
const kTextColor = Color(0xFF000839);
const kTextLightColor = Color(0xFF747474);
const kBlueColor = Color(0xFF40BAD5);
const kBackgroundColor = Color(0xFFF1EFF1);


//colors
const Color kPrimaryColorr = Color(0xFF345FB4);
const Color kSecondaryColorr = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColorr = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);

//default value
const kDefaultPaddingr = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  topRight:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  bottomLeft:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

final kInputTextStyle = GoogleFonts.poppins(
    color: kTextBlackColor,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500
);

//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';