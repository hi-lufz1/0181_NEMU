import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/components/custom_outline_button.dart';
import 'package:nemu_app/core/components/custom_text_field.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/model/request/auth/login_req_model.dart';
import 'package:nemu_app/presentation/bloc/auth/login/login_bloc.dart';
import 'package:nemu_app/presentation/screens/auth/components/custom_password_field.dart';
import 'package:nemu_app/presentation/screens/shared/feed/feed_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password wajib diisi')),
      );
      return;
    }

    context.read<LoginBloc>().add(
      LoginSubmitted(reqModel: LoginReqModel(email: email, password: password)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.responseModel.message ?? 'Login gagal'),
              ),
            );
          } else if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.responseModel.message ?? 'Login berhasil'),
              ),
            );

            // Navigasi ke halaman laporan
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FeedScreen()),
            );
          }
        },

        builder: (context, state) {
          return Padding(
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
                    'Silakan login untuk melanjutkan',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                  const SizedBox(height: 32),

                  // Email
                  CustomTextField(
                    hintText: "E-Mail",
                    icon: Icons.email,
                    controller: emailController,
                  ),

                  const SizedBox(height: 16),
                  CustomPasswordField(
                    hintText: "Password",
                    controller: passwordController,
                  ),
                  const SizedBox(height: 8),

                  // Remember me
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
                  const SizedBox(height: 16),

                  // Button
                  state is LoginLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                        label: "Sign In",
                        onPressed: () => _onLoginPressed(context),
                      ),

                  const SizedBox(height: 12),

                  CustomOutlineButton(
                    label: "Create Account",
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    borderColor: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
