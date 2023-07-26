import 'dart:io';
import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/screens/login_screen.dart';
import 'package:drip_plus/features/auth/widgets/auth_field.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/core/utils.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _nameController.dispose();
  }

  void storeUserData() async {
    String userName = _usernameController.text.trim();
    String lowerCaseUserName = userName.toLowerCase();
    String email = _emailController.text.trim();

    String password = _passwordController.text.trim();

    if (userName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      ref.read(authControllerProvider.notifier).saveUserDataToFirebase(
            context,
            userName,
            email,
            password,
            lowerCaseUserName,
          );
    } else {
      showSnackBar(context, 'Fill out all the fields');
    }
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
    // Routemaster.of(context).push('/login/');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loader()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthField(
                        controller: _usernameController,
                        hintText: 'Enter Username',
                        icons: Icons.person,
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(height: 24),
                      AuthField(
                        controller: _nameController,
                        hintText: 'Enter Name',
                        icons: Icons.person_pin_sharp,
                        textInputType: TextInputType.name,
                      ),
                      const SizedBox(height: 24),
                      AuthField(
                        controller: _emailController,
                        hintText: 'Enter Email',
                        icons: Icons.email,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 24),
                      AuthField(
                        controller: _passwordController,
                        hintText: 'Enter Password',
                        icons: Icons.lock,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 24),
                      RoundedStretchButton(
                        onTap: () => storeUserData(),
                        label: 'Sign Up',
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(top: 12, bottom: 12),
        child: RichText(
          text: TextSpan(
            text: "Already have an account?",
            style: const TextStyle(fontSize: 16, color: Pallete.greyColor),
            children: [
              TextSpan(
                text: ' Login',
                style: const TextStyle(color: Pallete.blueColor, fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    navigateToLoginScreen(context);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
