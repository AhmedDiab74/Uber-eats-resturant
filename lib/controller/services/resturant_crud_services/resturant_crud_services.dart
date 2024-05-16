import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubereatsresturant/constant/constant.dart';
import 'package:ubereatsresturant/model/restaurant_mode.dart';
import 'package:ubereatsresturant/view/sign_in_logic_screen/sign_in_logic_screen.dart';

class ResturantCrudServices {
  static registerResturant(RestaurantModel data, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection(collectionRestuarant)
          .doc(auth.currentUser!.uid)
          .set(data.toMap())
          .whenComplete(() {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const SignInLogicScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
