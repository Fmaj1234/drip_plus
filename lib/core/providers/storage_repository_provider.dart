import 'dart:io';
import 'package:drip_plus/core/providers/firebase_providers.dart';
import 'package:drip_plus/core/failure.dart';
import 'package:drip_plus/core/type_defs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:video_compress/video_compress.dart';

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: ref.watch(storageProvider),
  ),
);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFileToFirebase({
    required String path,
    required String id,
    required File? file,
    required Uint8List? webFile,
  }) async {
    try {
      final ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask;

      if (kIsWeb) {
        uploadTask = ref.putData(webFile!);
      } else {
        uploadTask = ref.putFile(file!);
      }

      final snapshot = await uploadTask;

      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<List<String>> uploadImagesToStorage({
    required String path,
    required String id,
    required List<File> files,
  }) async {
    List<String> imageLinks = [];
    try {
      await Future.forEach(files, (image) async {
        final ref = _firebaseStorage.ref().child('posts/${image.path}');
        final UploadTask uploadTask = ref.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        final url = await taskSnapshot.ref.getDownloadURL();
        imageLinks.add(url);
      });
      return right(imageLinks);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<String> storeAnotherFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  FutureEither<String> uploadVideoToStorage({
    required String id,
    required String videoPath,
  }) async {
    try {
      Reference ref = _firebaseStorage.ref().child('videos').child(id);

      UploadTask uploadTask = ref.putFile(await compressVideo(videoPath));
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();

      return right(downloadUrl);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  pickPostThumbNail(File thumbPostFile) async {
    String thumbPostPath = thumbPostFile.path;
    final postThumbnailUpload =
        await VideoCompress.getFileThumbnail(thumbPostPath);
    return postThumbnailUpload;
  }

  getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> uploadImageThumbnailToStorage(
      String id, String videoPath) async {
    Reference ref = _firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
