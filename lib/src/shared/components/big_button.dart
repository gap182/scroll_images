import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scroll_images/src/shared/static_data/colors.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    this.onTap,
    this.child,
  });

  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120.w,
        width: 120.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: AppColors.blueLogo.withOpacity(0.2),
                spreadRadius: 1.0,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ],
        ),
        child: child,
      ),
    );
  }
}
