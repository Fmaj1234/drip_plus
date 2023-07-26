import 'package:drip_plus/common/common.dart';
import 'package:drip_plus/features/auth/screens/signup_screen.dart';
import 'package:drip_plus/features/auth/widgets/auth_field.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() {
    String emailLogin = _emailController.text.trim();
    String passwordLogin = _passwordController.text.trim();
    if (emailLogin.isNotEmpty && passwordLogin.isNotEmpty) {
      ref
          .read(authControllerProvider.notifier)
          .loginUser(context, emailLogin, passwordLogin);
    } else {
      showSnackBar(context, 'Fill out all the fields');
    }
  }

  void navigateToSignupScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
    // Routemaster.of(context).push('/signup/');
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                        onTap: loginUser,
                        label: 'Log in',
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
            text: "Don't have an account?",
            style: const TextStyle(fontSize: 16, color: Pallete.greyColor),
            children: [
              TextSpan(
                text: ' Sign up',
                style: const TextStyle(color: Pallete.blueColor, fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    navigateToSignupScreen(context);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
