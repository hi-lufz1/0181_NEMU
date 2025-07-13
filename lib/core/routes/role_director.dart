import 'package:flutter/material.dart';
import 'package:nemu_app/core/utils/token_service.dart';

class RoleRedirector extends StatefulWidget {
  const RoleRedirector({super.key});

  @override
  State<RoleRedirector> createState() => _RoleRedirectorState();
}

class _RoleRedirectorState extends State<RoleRedirector> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final role = await TokenService.getCurrentUserRole();

    await Future.delayed(const Duration(milliseconds: 300)); // bisa dikurangi kalau splash native lama

    if (!mounted) return;

    if (role == 'admin') {
      Navigator.pushReplacementNamed(context, '/admin-feed');
    } else if (role == 'umum') {
      Navigator.pushReplacementNamed(context, '/feed');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}