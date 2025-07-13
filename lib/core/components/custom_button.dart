import 'package:flutter/material.dart';
import 'package:nemu_app/core/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: color ?? AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
    );
  }
}
