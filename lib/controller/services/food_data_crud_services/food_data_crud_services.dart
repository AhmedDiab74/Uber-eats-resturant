import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:ubereatsresturant/constant/constant.dart';
import 'package:ubereatsresturant/controller/services/toas_services/toas_services.dart';
import 'package:ubereatsresturant/model/add_food_model/add_food_model.dart';

class FoodDataCRUDSetvices {
  static uploadFoodData(BuildContext context, AddFoodModel data) async {
    try {
      await firebaseFirestore
          .collection(collectionFood)
          .doc(data.foodID)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pop(context);
        ToastService.sendScaffoldAlert(
            msg: "Food Added Succesful",
            toastStatus: 'SUCCESS',
            context: context);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
