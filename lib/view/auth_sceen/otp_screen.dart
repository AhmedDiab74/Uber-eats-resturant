import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/controller/provider/mobile_auth_provider/mobile_auth_provider.dart';
import 'package:ubereatsresturant/controller/services/auth_services/mobile_auth_services.dart';
import 'package:ubereatsresturant/utils/colors.dart';
import 'package:ubereatsresturant/utils/textStyles.dart';
import 'package:ubereatsresturant/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ubereatsresturant/view/home/home.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController =
      StreamController<ErrorAnimationType>();
  int resendOTPCounter = 60;
  decreaseOTPCounter() async {
    if (resendOTPCounter > 0) {
      setState(() {
        resendOTPCounter--;
      });
      await Future.delayed(const Duration(seconds: 1), () {
        decreaseOTPCounter();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      decreaseOTPCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBa(),
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 10.w,
            bottom: 3.h,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: EdgeInsets.all(2.h),
                  backgroundColor: greyShade3,
                  elevation: 2,
                ),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  size: 3.h,
                  color: black,
                )),
          ),
          Positioned(
            right: 10.w,
            bottom: 3.h,
            child: ElevatedButton(
                onPressed: () {
                  // MobileAuthServices.verifyOTP(
                  //     context: context, smsCode: otpController.text.trim());
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const BottomNavigationBarUberEats(),
                          type: PageTransitionType.leftToRight));
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  backgroundColor: greyShade3,
                  elevation: 2,
                ),
                child: Row(
                  children: [
                    Text(
                      "Next",
                      style: AppTextStyles.body14,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 3.h,
                      color: black,
                    ),
                  ],
                )),
          ),
        ],
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Enter the 4-digit code sent to you at ${context.read<MobileAuthProvider>().mobileNumber}',
              style: AppTextStyles.body16,
            ),
            SizedBox(
              height: 3.h,
            ),
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              textStyle: AppTextStyles.body14,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 50,
                inactiveColor: greyShade3,
                inactiveFillColor: greyShade3,
                selectedFillColor: white,
                selectedColor: black,
                activeColor: black,
                activeFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: otpController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.sp),
                    color: greyShade3,
                  ),
                  child: Text(
                    'I haven’t recieved a code ($resendOTPCounter)',
                    style: AppTextStyles.small10.copyWith(
                        color: resendOTPCounter > 0 ? black38 : black),
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
