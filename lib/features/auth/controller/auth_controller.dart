import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:drip_plus/features/auth/repository/auth_repository.dart';
import 'package:drip_plus/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false); // loading

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  // Future<UserModel> currentUser() => _authRepository.currentUserAccount();

  Future<UserModel?> currentUser() async {
    UserModel? user = await _authRepository.currentUserAccount();
    return user;
  }

  void signInWithGoogle(BuildContext context, bool isFromLogin) async {
    state = true;
    final user = await _authRepository.signInWithGoogle(isFromLogin);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  void signInAsGuest(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInAsGuest();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logout() async {
    _authRepository.logOut();
  }

  //old drip plus controller

  void loginUser(
      BuildContext context, String emailLogin, String passwordLogin) {
    _authRepository.loginUser(context, emailLogin, passwordLogin);
  }

  void saveUserDataToFirebase(
    BuildContext context,
    String userNameSignin,
    String emailSignin,
    String passwordSignin,
    String lowerCaseUserName,
  ) async {
    state = true;
    final res = await _authRepository.saveUserDataToFirebase(userNameSignin,
        emailSignin, passwordSignin, lowerCaseUserName);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'User created successfully!');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    });
  }

  Stream<UserModel> userDataById(String userId) {
    return _authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    _authRepository.setUserState(isOnline);
  }
}
