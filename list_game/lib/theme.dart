import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

Color kPrimaryColor = const Color(0xff4141A4);
Color kWhiteColor = const Color(0xffFFFFFF);
Color kGreyColor = const Color(0xffB3B5C4);
Color kBlackColor = const Color(0xff272C2F);
Color kGreenColor = Colors.white;
Color gr = HexColor("#324A59");
Color kSemiBlackColor = HexColor('#EFECEC');

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

TextStyle kBlackTextStyle = GoogleFonts.poppins(
  color: kBlackColor,
);

TextStyle kWhiteTextStyle = GoogleFonts.poppins(
  color: kWhiteColor,
);

TextStyle kGreyTextStyle = GoogleFonts.poppins(
  color: kGreyColor,
);
const kDefaultDuration = Duration(milliseconds: 250);
