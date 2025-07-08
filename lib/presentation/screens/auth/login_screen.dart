import 'package:flutter/material.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/components/custom_outline_button.dart';
import 'package:nemu_app/core/constants/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Image.asset("assets/images/logo.png", height: 126),
              const Text(
                'Welcome back,',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'blablablabla',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 32),

              // Email input
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'E-Mail',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password input
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => obscurePassword = !obscurePassword);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Remember me + forgot
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged:
                            (val) => setState(() => rememberMe = val ?? false),
                      ),
                      const Text("Remember Me"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              CustomButton(label: "Sign In", onPressed: () {}),
              const SizedBox(height: 12),

              CustomOutlineButton(
                label: "Create Account",
                onPressed: () {Navigator.pushNamed(context, '/register');},
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
