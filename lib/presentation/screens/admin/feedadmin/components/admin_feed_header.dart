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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text(
                        'Konfirmasi Logout',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      content: const Text(
                        'Yakin ingin keluar dari akun ini?',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      actionsPadding: const EdgeInsets.only(
                        right: 16,
                        bottom: 12,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[700],
                          ),
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
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
