// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:ubereatsresturant/constant/constant.dart';
import 'package:ubereatsresturant/controller/provider/mobile_auth_provider/mobile_auth_provider.dart';
import 'package:ubereatsresturant/view/auth_screen/mobile_login_screen.dart';
import 'package:ubereatsresturant/view/auth_screen/otp_screen.dart';
import 'package:ubereatsresturant/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ubereatsresturant/view/resturant_registration_screen/resturant_registration_screen.dart';
import 'package:ubereatsresturant/view/sign_in_logic_screen/sign_in_logic_screen.dart';

class MobileAuthServices {
  static checkRestaurantRegistration({required BuildContext context}) async {
    bool restaurantRegistration = false;
    try {
      await firebaseFirestore
          .collection(collectionRestuarant)
          .where(collectionRestaurantUID, isEqualTo: auth.currentUser!.uid)
          .get()
          .then((value) {
        value.size > 0
            ? restaurantRegistration = true
            : restaurantRegistration = false;
        log('Resturant is Registerd = $restaurantRegistration');
        if (restaurantRegistration) {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: const BottomNavigationBarUberEats(),
                type: PageTransitionType.rightToLeft,
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                child: const ResturantRegistrationScreen(),
                type: PageTransitionType.rightToLeft,
              ),
              (route) => false);
        }
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static bool checkAuthentication(BuildContext context) {
    User? user = auth.currentUser;
    if (user == null) {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const MobileLoginScreen(),
            type: PageTransitionType.rightToLeft,
          ),
          (route) => false);
      return false;
    } else {
      checkRestaurantRegistration(context: context);
      return true;
    }
  }

  static receiveOTP(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+201099527790',
        verificationCompleted: (PhoneAuthCredential credentials) {
          log(credentials.toString());
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
          throw (e);
        },
        codeSent: (String verficationID, int? resendToken) {
          context
              .read<MobileAuthProvider>()
              .updateVerificationID(verficationID);
          Navigator.push(
              context,
              PageTransition(
                  child: const OTPScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        codeAutoRetrievalTimeout: (String verficationID) {},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static verifyOTP(
      {required BuildContext context, required String smsCode}) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: context.read<MobileAuthProvider>().verificationID!,
        smsCode: smsCode,
      );

      await auth.signInWithCredential(credential);
      Navigator.push(
          context,
          PageTransition(
              child: const SignInLogicScreen(),
              type: PageTransitionType.rightToLeft));
    } catch (e) {
      log(e.toString());
    }
  }
}
