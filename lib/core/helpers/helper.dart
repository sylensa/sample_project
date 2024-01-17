import 'package:flutter/material.dart';

const Color dPurpleGradientLeft = Color(0xFF7A08FA);
const Color dPurpleGradientRight = Color(0xFFAD3BFC);
const Color solonGray500 = Color(0xFF757b81);
const appMainTextColor = Color(0xFF0066FF);
appWidth(context) {
  return MediaQuery.of(context).size.width;
}

appHeight(context) {
  return MediaQuery.of(context).size.height;
}

InputDecoration textDecor(
    {String hint = '',
      Widget? icon,
      String prefix = '',
      Widget? suffix,
      Widget? suffixIcon,
      bool enabled = true,
      Color? hintColor = solonGray500,
      double hintSize = 16,
      bool showBorder = true,
      double radius = 4,
      String label = '',
      EdgeInsetsGeometry padding =
      const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0)}) {
  return InputDecoration(
    prefixIcon: icon,
    prefixText: prefix,
    suffix: suffix,
    suffixIcon: suffixIcon,
    hintText: hint,
    alignLabelWithHint: true,
    isDense: true,

    floatingLabelBehavior: (label.isNotEmpty && hint.isNotEmpty)
        ? FloatingLabelBehavior.never
        : FloatingLabelBehavior.auto,
    hintStyle: appStyle(size: hintSize, col: hintColor),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[100]!, width: 1),
      borderRadius: BorderRadius.circular(radius),
    ),
    labelText: label,
    labelStyle: appStyle(size: hintSize, col: hintColor),
    contentPadding: padding,
  );
}

Widget sText(String? word,
    {double size = 14,
      FontWeight weight = FontWeight.w500,
      Color color = Colors.black,
      TextAlign align = TextAlign.left,
      int maxLines = 5,
      double? lHeight = 1.2,
      double? decorationThickness = 1,
      String family = 'Proxima',
      FontStyle style = FontStyle.normal,
      TextDecoration textDecoration = TextDecoration.none,
      int shadow = 0}) {
  return Text(
    word ?? '...',
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,


    style: TextStyle(
      decoration: textDecoration,
      decorationThickness:decorationThickness ,
      height: lHeight,
      fontStyle: style,
      color: color,
      fontFamily: family,
      fontSize: size,
      fontWeight: weight,
      shadows:
      shadow > 0 ? elevation(color: Colors.black38, elevation: shadow) : [],
    ),
  );
}

TextStyle appStyle(
    {double size = 16,
      Color? col =  Colors.black,
      FontWeight weight = FontWeight.w400,
      double? decorationThickness = 1,
      String family = 'Proxima',
      FontStyle style = FontStyle.normal,
      TextDecoration textDecoration = TextDecoration.none,
    }) {
  return TextStyle(
      fontFamily: family, fontWeight: weight, fontSize: size, color: col,decoration: textDecoration,decorationThickness: decorationThickness);
}

List<BoxShadow> elevation({required Color color, required int elevation}) {
  return [
    BoxShadow(
        color: color.withOpacity(0.6),
        offset: const Offset(0.0, 4.0),
        blurRadius: 3.0 * elevation,
        spreadRadius: -1.0 * elevation),
    BoxShadow(
        color: color.withOpacity(0.44),
        offset: const Offset(0.0, 1.0),
        blurRadius: 2.2 * elevation,
        spreadRadius: 1.5),
    BoxShadow(
        color: color.withOpacity(0.12),
        offset: const Offset(0.0, 1.0),
        blurRadius: 4.6 * elevation,
        spreadRadius: 0.0),
  ];
}

Widget dPurpleGradientButton(
    {required Widget content,
      required Function onPressed,
      double radius = 5,
      double height = 50,
      EdgeInsetsGeometry? padding,
      List<Color> colors = const [dPurpleGradientLeft, dPurpleGradientRight],
      gradientDirection = 'left_right'}) {
  return SizedBox(
    height: height,
    child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradientDirection == 'left_right'
                ? Alignment.centerLeft
                : Alignment.topCenter,
            end: gradientDirection == 'left_right'
                ? Alignment.centerRight
                : Alignment.bottomCenter,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(radius)),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//          backgroundColor: col,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        onPressed: () => onPressed(),
        child: content,
      ),
    ),
  );
}