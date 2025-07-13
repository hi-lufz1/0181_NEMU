import 'package:flutter/material.dart';
import 'package:nemu_app/core/utils/logout_helper.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + Notif
          Row(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/notifikasi');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications, size: 28),
                    ),
                  ),
                  // Uncomment ini jika nanti ingin badge merah kecil
                  // Positioned(
                  //   top: 2,
                  //   right: 2,
                  //   child: Container(
                  //     width: 10,
                  //     height: 10,
                  //     decoration: const BoxDecoration(
                  //       color: Colors.red,
                  //       shape: BoxShape.circle,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/logotext.png',
                height: 20,
                fit: BoxFit.fill,
              ),
            ],
          ),

          // Tombol Logout
          IconButton(
            icon: const Icon(Icons.logout, size: 28, color: Colors.black),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text('Konfirmasi Logout'),
                      content: const Text('Yakin ingin keluar dari akun ini?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
              );

              if (confirm == true) {
                logoutUser(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
