import 'package:drip_plus/features/auth/controller/auth_controller.dart';
import 'package:drip_plus/features/auth/screens/welcome_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

void navigateToWelcomeScreen(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const WelcomeScreen();
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    if (!isGuest) {
      return Center(
        child: GestureDetector(
          onTap: () => navigateToWelcomeScreen(context),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      );
    }
    return Scaffold();
  }
}
