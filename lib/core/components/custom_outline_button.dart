import 'package:flutter/material.dart';
import 'package:nemu_app/core/constants/colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? borderColor;

  const CustomOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        side: BorderSide(color: borderColor ?? AppColors.primary, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: borderColor ?? AppColors.primary,
            ),
      ),
    );
  }
}
