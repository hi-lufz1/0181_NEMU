import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemu_app/core/components/custom_button.dart';
import 'package:nemu_app/core/components/custom_text_field.dart';
import 'package:nemu_app/core/constants/colors.dart';
import 'package:nemu_app/data/model/request/auth/register_req_model.dart';
import 'package:nemu_app/presentation/bloc/auth/register/register_bloc.dart';
import 'package:nemu_app/presentation/screens/auth/components/custom_password_field.dart';

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

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    waController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Anda harus menyetujui ketentuan")),
      );
      return;
    }

    final reqModel = RegisterReqModel(
      nama: namaController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      konfirmasiPassword: confirmPasswordController.text,
      kontakWa: waController.text.trim(),
    );

    context.read<RegisterBloc>().add(RegisterSubmitted(reqModel: reqModel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.responseModel.message ?? 'Pendaftaran berhasil',
                  ),
                ),
              );
              Navigator.pop(context);
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.responseModel.message ?? 'Gagal mendaftar',
                  ),
                ),
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Let’s create your account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      hintText: "Full Name",
                      icon: Icons.person,
                      controller: namaController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: "E-Mail",
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: "WhatsApp Number",
                      icon: Icons.phone,
                      controller: waController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    CustomPasswordField(
                      hintText: "Password",
                      controller: passwordController,
                    ),
                    const SizedBox(height: 16),
                    CustomPasswordField(
                      hintText: "Confirm Password",
                      controller: confirmPasswordController,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: agreeToTerms,
                          onChanged:
                              (val) =>
                                  setState(() => agreeToTerms = val ?? false),
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Saya bersedia untuk ',
                              children: [
                                TextSpan(
                                  text: 'dihubungi melalui WhatsApp',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                TextSpan(
                                  text:
                                      ' oleh pengguna lain terkait laporan barang hilang atau ditemukan yang saya buat.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    state is RegisterLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                          label: "Create Account",
                          onPressed: _submitForm,
                        ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
