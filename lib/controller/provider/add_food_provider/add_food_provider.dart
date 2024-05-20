import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ubereatsresturant/controller/services/images_services/images_services.dart';

class AddFoodProvider extends ChangeNotifier {
  File? foodImage;
  String? foodImageUrl;

  pickFoodImageFromGallery(BuildContext context) async {
    foodImage = await ImagesServices.pickSingleImage(
      context: context,
    );
    notifyListeners();
  }

  uploadImageAndGetImageURL(BuildContext context) async {
    List<String> url =
        await ImagesServices.uploadImagesToFirebaseStorageNGetUrl(
      images: [foodImage!],
      context: context,
    );
    if (url.isNotEmpty) {
      foodImageUrl = url[0];
      log(foodImageUrl!);
    }
    notifyListeners();
  }
}
