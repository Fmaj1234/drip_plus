import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  void signInWithEmail(BuildContext context) {
    Routemaster.of(context).push('/login/');
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isFromLogin = true;
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 221, 221),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Login or Signup',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Login to your existing account or sign up to create a new account',
                style: TextStyle(fontSize: 16, color: Colors.black45),
              ),
            ),
            const SizedBox(height: 42),
            ElevatedButton.icon(
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
            const SizedBox(height: 12),
            ElevatedButton.icon(
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
            const SizedBox(height: 12),
            ElevatedButton.icon(
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
            const SizedBox(height: 12),
            ElevatedButton.icon(
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
            const SizedBox(height: 12),
            ElevatedButton.icon(
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
            const Spacer(),
            const Text(
              'By continuing, you agree to our Terms of Service and acknowledge that you have read our Privacy Policy to learn how to collect, use and share your data',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
