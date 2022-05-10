import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/app_theme.dart';

class PlayButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool backgroudBlur;
  const PlayButton({
    Key? key,
    required this.backgroudBlur,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: backgroudBlur ? EdgeInsets.all(10.sp) : EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0, 0.4],
          colors: [
            Colors.yellow.withOpacity(0.1),
            Colors.yellow.withOpacity(0.7),
          ],
        ),
        border: Border.all(
          color: backgroudBlur ? Colors.white70 : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(
          80.sp,
        ),
        color: backgroudBlur ? Colors.transparent : Colors.yellow,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: backgroudBlur ? 16.sp : 20.sp,
            color: backgroudBlur
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.secondaryVariant,
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            text,
            style: MyTextStyle.movieCardSubtitle(context).copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
