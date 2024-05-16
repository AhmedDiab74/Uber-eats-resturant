import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ubereatsresturant/controller/services/images_services/images_services.dart';

class ResturantRegisterProvider extends ChangeNotifier {
  List<File> resturantBannerImages = [];
  List<String> resturantBannerImagesUrl = [];

  getResturantBannerImages(BuildContext context) async {
    resturantBannerImages =
        await ImagesServices.getImagesFromGallery(context: context);
    notifyListeners();
  }

  updateResturantBannerImagesUrl(BuildContext context) async {
    resturantBannerImagesUrl =
        await ImagesServices.uploadImagesToFirebaseStorageNGetUrl(
            images: resturantBannerImages, context: context);
    notifyListeners();
  }
}
