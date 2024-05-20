import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/utils/colors.dart';

class CummonElevatedButton extends StatelessWidget {
  const CummonElevatedButton({super.key, required this.child, this.onPressed});
  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: black,
        minimumSize: Size(90.w, 6.h),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
