import 'package:cpims_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {

  const CustomButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.color = kPrimaryColor,
      this.isLoading = false})
      : super(key: key);

  final String text;
  final Function? onTap;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Material(
        borderRadius: BorderRadius.circular(5.w),
        child: Container(
          height: 49.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.w),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
