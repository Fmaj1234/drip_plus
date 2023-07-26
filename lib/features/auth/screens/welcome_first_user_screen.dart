import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/auth/screens/signup_screen.dart';
import 'package:drip_plus/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class WelcomeFirstUserScreen extends ConsumerWidget {
  const WelcomeFirstUserScreen({super.key});

  void signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
    // Routemaster.of(context).push('/login/');
  }

  void signInWithPhone(BuildContext context) {
    Routemaster.of(context).push('/login/');
  }

  void signInWithFacebook(BuildContext context) {
    Routemaster.of(context).push('/login/');
  }

  void signInWithTwitter(BuildContext context) {
    Routemaster.of(context).push('/login/');
  }

  void signInWithGoogle(BuildContext context, WidgetRef ref, bool isFromLogin) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context, true);
  }

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    bool isFromLogin = true;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallete.whiteColor,
        actions: [
          TextButton(
            onPressed: () => signInAsGuest(ref, context),
            child: const Text(
              "Skip",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Login or Signup',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              'Login to your existing account or sign up to create a new account',
              style: TextStyle(fontSize: 16, color: Colors.black45),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton.icon(
                onPressed: () => signInWithEmail(context),
                icon: const Icon(
                  Icons.email,
                  size: 27,
                ),
                label: const Text(
                  'Use your Email',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton.icon(
                onPressed: () => signInWithPhone(context),
                icon: const Icon(
                  Icons.phone,
                  size: 35,
                ),
                label: const Text(
                  'Use your Phone Number',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton.icon(
                onPressed: () => signInWithGoogle(context, ref, isFromLogin),
                icon: Image.asset(
                  AssetsConstants.googlePath,
                  width: 35,
                ),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton.icon(
                onPressed: () => signInWithFacebook(context),
                icon: Image.asset(
                  AssetsConstants.facebookPath,
                  width: 35,
                ),
                label: const Text(
                  'Continue with Facebook',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: size.width * 0.75,
              child: ElevatedButton.icon(
                onPressed: () => signInWithTwitter(context),
                icon: Image.asset(
                  AssetsConstants.twitterPath,
                  width: 35,
                ),
                label: const Text(
                  'Continue with Twitter',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'By continuing, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how to collect, use and share your data',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
