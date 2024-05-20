// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubereatsresturant/constant/constant.dart';
import 'package:ubereatsresturant/controller/services/toas_services/toas_services.dart';

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
      ToastService.sendScaffoldAlert(
        msg: "No Images Selected",
        toastStatus: "WARNING",
        context: context,
      );
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

  static pickSingleImage({required BuildContext context}) async {
    File? selectedImages;
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    XFile? filePick = pickedFile;
    if (filePick != null) {
      selectedImages = File(filePick.path);
      return selectedImages;
    } else {
      ToastService.sendScaffoldAlert(
        msg: "No Image Selected",
        toastStatus: "WARNING",
        context: context,
      );
    }
  }
}
