import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trippify/utils/colors.dart';

String montserrat = 'Montserrat';

String primaryFont = montserrat;

class AppStyles {
  static TextStyle get tsFS70CPW600shadowsIntoLight =>
      GoogleFonts.shadowsIntoLight(
          fontSize: 70, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle get tsFS50CPW600shadowsIntoLight =>
      GoogleFonts.shadowsIntoLight(
          fontSize: 50, fontWeight: FontWeight.w600, color: color00000000);

  static TextStyle get tsFS12CPW500 => GoogleFonts.montserrat(
        color: primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get tsFS12CBCW500 => GoogleFonts.montserrat(
        color: borderColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get tsFS12CGrey600W600 => GoogleFonts.montserrat(
        color: Colors.grey.shade600,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get tsFS12CFFW600 => GoogleFonts.montserrat(
        color: colorFFFFFFFF,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get tsFS12C00W600 => GoogleFonts.montserrat(
        color: color00000000,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get tsFS18C00W700 => GoogleFonts.montserrat(
        color: color00000000,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get tsFS20C00W700 => GoogleFonts.montserrat(
        color: color00000000,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get tsFS16CGrey600W300 => GoogleFonts.montserrat(
        color: Colors.grey.shade600,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      );

  static TextStyle get tsFS16CGreyW400 => GoogleFonts.montserrat(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get tsFS14CGreyW400 => GoogleFonts.montserrat(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get tsFS16CFFW400 => GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get tsFS16CFFW600 => GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get tsFS16C00W400 => GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get tsFS18C00W400 => GoogleFonts.montserrat(
        color: color00000000,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get tsFS23C00W400 => GoogleFonts.montserrat(
        color: color00000000,
        fontSize: 23,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get tsFS24C00W300 => GoogleFonts.montserrat(
        color: color00000000,
        fontSize: 22,
        fontWeight: FontWeight.w300,
      );
}
