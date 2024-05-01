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
import 'package:ubereatsresturant/view/auth_sceen/mobile_login_screen.dart';
import 'package:ubereatsresturant/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ubereatsresturant/view/sign_in_logic_screen/sign_in_logic_screen.dart';

class MobileAuthServices {
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
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const BottomNavigationBarUberEats(),
            type: PageTransitionType.leftToRight,
          ),
          (route) => false);
      return true;
    }
  }

  static receiveOTP(
      {required BuildContext context, required String phoneNumber}) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+911234567893",
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
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         child: const OTPScreen(),
          //         type: PageTransitionType.rightToLeft));
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
