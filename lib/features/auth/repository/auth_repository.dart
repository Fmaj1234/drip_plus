import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drip_plus/constants/constants.dart';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/core/failure.dart';
import 'package:drip_plus/core/type_defs.dart';
import 'package:drip_plus/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drip_plus/core/utils.dart';
import 'package:drip_plus/models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<UserModel?> currentUserAccount() async {
    var userData =
        await _firestore.collection('users').doc(_auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  FutureEither<UserModel> signInWithGoogle(bool isFromLogin) async {
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        if (isFromLogin) {
          userCredential = await _auth.signInWithCredential(credential);
        } else {
          userCredential =
              await _auth.currentUser!.linkWithCredential(credential);
        }
      }

      UserModel userModel;

      var timeAdded = DateTime.now();

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          username: userCredential.user!.displayName ?? 'No Name',
          lowerCaseUsername: userCredential.user!.displayName!.toLowerCase(),
          profilePic: userCredential.user!.photoURL ?? AssetsConstants.avatarDefault,
          banner: AssetsConstants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          email: userCredential.user!.email ?? 'No Email',
          followers: [],
          following: [],
          followersCount: 0,
          followingCount: 0,
          totalLikesCount: 0,
          password: "",
          bio: "",
          isOnline: true,
          privacy: true,
          merchant: true,
          isVerifiedBlue: false,
          phoneNumber: "",
          provider: "",
          status: "",
          website: "",
          interest: "",
          location: "",
          timeAdded: timeAdded,
          groupId: [],
          groupIdCount: 0,
        );
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signInAsGuest() async {
    try {
      var userCredential = await _auth.signInAnonymously();

      var timeAdded = DateTime.now();

      UserModel userModel = UserModel(
        username: 'Guest',
        lowerCaseUsername: 'Lowercase Name',
        profilePic: AssetsConstants.avatarDefault,
        banner: AssetsConstants.bannerDefault,
        uid: userCredential.user!.uid,
        isAuthenticated: false,
        email: 'No Email',
        followers: [],
        following: [],
        followersCount: 0,
        followingCount: 0,
        totalLikesCount: 0,
        password: "",
        bio: "",
        isOnline: true,
        privacy: true,
        merchant: true,
        isVerifiedBlue: false,
        phoneNumber: "",
        provider: "",
        status: "",
        website: "",
        interest: "",
        location: "",
        timeAdded: timeAdded,
        groupId: [],
        groupIdCount: 0,
      );

      await _users.doc(userCredential.user!.uid).set(userModel.toMap());

      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

// old drip plus repository

  void loginUser(
      BuildContext context, String emailLogin, String passwordLogin) async {
    try {
      // logging in user with email and password
      await _auth.signInWithEmailAndPassword(
        email: emailLogin,
        password: passwordLogin,
      );
      //  Routemaster.of(context).push('_');

      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   HomeScreen(),
      //   (route) => false,
      // );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  FutureVoid saveUserDataToFirebase(
    String userName,
    String email,
    String password,
    String lowerCaseUserName,
  ) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var timeAdded = DateTime.now();
      var user = UserModel(
        username: userName,
        lowerCaseUsername: lowerCaseUserName,
        uid: cred.user!.uid,
        profilePic: AssetsConstants.avatarDefault,
        banner: AssetsConstants.bannerDefault,
        email: email,
        isAuthenticated: true,
        bio: "",
        followers: [],
        following: [],
        followersCount: 0,
        followingCount: 0,
        totalLikesCount: 0,
        isOnline: true,
        privacy: true,
        merchant: true,
        isVerifiedBlue: false,
        phoneNumber: "",
        provider: "",
        status: "",
        password: password,
        website: "",
        interest: "",
        location: "",
        timeAdded: timeAdded,
        groupId: [],
        groupIdCount: 0,
      );
      return right(_users.doc(cred.user!.uid).set(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> userData(String userId) {
    return _users.doc(userId).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void setUserState(bool isOnline) async {
    await _users.doc(_auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }
}
