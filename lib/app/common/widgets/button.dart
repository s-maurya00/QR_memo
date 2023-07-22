import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.label,
    required this.onTap,
    this.color,
    this.textStyle,
  });

  final String label;
  final Function()? onTap;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: color == Colors.transparent
              ? Border.all(
                  width: 2,
                  color: Colors.grey.withOpacity(0.2),
                )
              : null,
          color: color ?? primaryClrMaterial,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: whiteClr,
            ).merge(textStyle),
          ),
        ),
      ),
    );
  }
}
