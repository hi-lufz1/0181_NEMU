import 'package:flutter/material.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/constants/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final waController = TextEditingController();
  bool agreeToTerms = false;
  bool hidePassword = true;
  bool hideConfirm = true;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    waController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Let’s create your account",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Full Name
                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Email
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

                // WhatsApp Contact
                TextField(
                  controller: waController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'WhatsApp Number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed:
                          () => setState(() => hidePassword = !hidePassword),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password
                TextField(
                  controller: confirmPasswordController,
                  obscureText: hideConfirm,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        hideConfirm ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed:
                          () => setState(() => hideConfirm = !hideConfirm),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged:
                          (val) => setState(() => agreeToTerms = val ?? false),
                    ),
                    const Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'I agree to ',
                          children: [
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Terms of use',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Button
                CustomButton(
                  label: "Create Account",
                  onPressed: () {
                    final data = {
                      "nama": namaController.text.trim(),
                      "email": emailController.text.trim(),
                      "password": passwordController.text,
                      "konfirmasi_password": confirmPasswordController.text,
                      "kontak_wa": waController.text.trim(),
                    };
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
