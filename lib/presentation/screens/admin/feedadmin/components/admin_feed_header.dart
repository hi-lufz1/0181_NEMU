import 'package:flutter/material.dart';
import 'package:nemu_app/core/utils/logout_helper.dart';

class AdminFeedHeader extends StatelessWidget {
  const AdminFeedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + Label Admin
          Row(
            children: [
              Image.asset(
                'assets/images/logotext.png',
                height: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 8),
              const Text(
                'Admin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
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
