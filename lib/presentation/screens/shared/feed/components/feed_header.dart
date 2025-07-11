import 'package:flutter/material.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Row(
                spacing: 4,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications, size: 28),
                  ),
                  Image.asset(
                    'assets/images/logotext.png',
                    height: 20,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   child: Container(
              //     padding: const EdgeInsets.all(4),
              //     decoration: const BoxDecoration(
              //       color: Colors.red,
              //       shape: BoxShape.circle,
              //     ),
              //     child: const Text(
              //       '',
              //       style: TextStyle(color: Colors.white, fontSize: 10),
              //     ),
              //   ),
              // ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.logout, size: 28, color: Colors.black),
            onPressed: () {
              //logout
            },
          ),
        ],
      ),
    );
  }
}
