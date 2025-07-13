import 'package:flutter/material.dart';
import 'package:nemu_app/core/constants/colors.dart';

class AdminBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AdminBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavIcon(Icons.home_rounded, 0),
              _buildNavIcon(Icons.search_rounded, 1),
              _buildNavIcon(Icons.bar_chart_rounded, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
          if (isSelected)
            Positioned(
              bottom: 0,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
