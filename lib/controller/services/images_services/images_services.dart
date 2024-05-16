import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubereatsresturant/constant/constant.dart';

class ImagesServices {
  static getImagesFromGallery({required BuildContext context}) async {
    List<File> selectedImages = [];
    final pickedFile = await picker.pickMultiImage(imageQuality: 100);

    List<XFile> filePick = pickedFile;
    if (filePick.isNotEmpty) {
      for (var image in filePick) {
        selectedImages.add(File(image.path));
      }
    } else {
      //Show toast message
    }
    log('The Images are\n ${selectedImages.toList().toString()}');
    return selectedImages;
  }

  static uploadImagesToFirebaseStorageNGetUrl(
      {required List<File> images, required BuildContext context}) async {
    List<String> imagesUrl = [];
    String sellerUID = auth.currentUser!.uid;
    await Future.forEach(images, (image) async {
      String imageName = '$sellerUID${uuid.v1().toString()}';
      Reference ref =
          storage.ref().child("ResturantBannerImages").child(imageName);
      await ref.putFile(File(image.path));
      String imageUrl = await ref.getDownloadURL();
      imagesUrl.add(imageUrl);
    });
    return imagesUrl;
  }
}
