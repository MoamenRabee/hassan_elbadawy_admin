import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    this.textColor,
    this.color,
    this.width,
    this.height,
    this.onPressed,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.isloading,
    this.elevation,
  });

  double? width;
  double? height;
  double? fontSize;
  String text;
  Color? textColor;
  Color? color;
  FontWeight? fontWeight;
  void Function()? onPressed;
  BorderRadiusGeometry? borderRadius;
  bool? isloading = false;
  double? elevation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 240,
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: onPressed == null ? const Color(0x2b2b6db4) : color,
          elevation: elevation ?? 2,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(6.0),
            side: const BorderSide(width: 0, color: Colors.transparent),
          ),
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: onPressed == null ? Colors.grey : textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontFamily: 'Alexandria',
          ),
        ),
      ),
    );
  }
}

class CustomButtonLoading extends StatelessWidget {
  CustomButtonLoading({
    super.key,
    this.textColor,
    this.color,
    this.width,
    this.height,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
  });

  double? width;
  double? height;
  double? fontSize;
  Color? textColor;
  Color? color;
  FontWeight? fontWeight;
  BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 240,
      height: height ?? 40,
      child: ElevatedButton(
        onPressed: null,
        style: TextButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(6.0),
            side: const BorderSide(width: 0, color: Colors.transparent),
          ),
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        child: CircularProgressIndicator(
          color: textColor,
        ),
      ),
    );
  }
}
