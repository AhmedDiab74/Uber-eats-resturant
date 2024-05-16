import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/controller/provider/mobile_auth_provider/mobile_auth_provider.dart';
import 'package:ubereatsresturant/controller/services/auth_services/mobile_auth_services.dart';
import 'package:ubereatsresturant/utils/colors.dart';
import 'package:ubereatsresturant/utils/textStyles.dart';
import 'package:ubereatsresturant/view/auth_screen/otp_screen.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  String selectedCountry = "+20";
  TextEditingController mobileController = TextEditingController();
  bool receiveOTP = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        receiveOTP = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      children: [
        SizedBox(
          height: 3.h,
        ),
        Text(
          "Enter your mobile number",
          style: AppTextStyles.body16,
        ),
        SizedBox(
          height: 3.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountry = country.flagEmoji;
                      });
                      print('Select country: ${country.displayName}');
                    });
              },
              child: Container(
                alignment: Alignment.center,
                height: 6.h,
                width: 25.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    4.sp,
                  ),
                  border: Border.all(color: grey),
                  // color: greyShade3,
                ),
                child: Text(
                  selectedCountry,
                  style: AppTextStyles.body14.copyWith(
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 65.w,
              child: TextField(
                controller: mobileController,
                cursorColor: black,
                style: AppTextStyles.textFieldTextStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 2.w),
                  hintText: "Mobile number",
                  // filled: true,
                  // fillColor: greyShade3,
                  hintStyle: AppTextStyles.textFieldHintTextStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: black),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: grey),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 3.h,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                receiveOTP = true;
              });
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         child: const OTPScreen(),
              //         type: PageTransitionType.rightToLeft));
              context.read<MobileAuthProvider>().updateMobileNumber(
                  '$selectedCountry ${mobileController.text.trim()}');
              MobileAuthServices.receiveOTP(
                  context: context,
                  phoneNumber:
                      '$selectedCountry${mobileController.text.trim()}');
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: black, minimumSize: Size(90.w, 6.h)),
            child: receiveOTP
                ? CircularProgressIndicator(
                    color: white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 9.w,
                      ),
                      Text(
                        "Next",
                        style: AppTextStyles.body16.copyWith(color: white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: white,
                        size: 4.h,
                      )
                    ],
                  )),
        SizedBox(
          height: 3.w,
        ),
        Text(
          "By proceeding, you consent to get calls, Whatsapp or SMS messages, including by automated means, from uber and its affiliates to the number provided.",
          style: AppTextStyles.small12.copyWith(
            color: grey,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Row(
          children: [
            Expanded(
                child: Divider(
              color: grey,
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Text(
                "or",
                style: AppTextStyles.small12.copyWith(color: grey),
              ),
            ),
            Expanded(
                child: Divider(
              color: grey,
            ))
          ],
        ),
        SizedBox(
          height: 2.h,
        ),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: white,
              minimumSize: Size(90.w, 6.h),
              elevation: 2,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Continue with google',
                    style: AppTextStyles.body16,
                  ),
                ),
                Positioned(
                  left: 2.w,
                  child: FaIcon(
                    FontAwesomeIcons.google,
                    color: black,
                    size: 3.h,
                  ),
                )
              ],
            ))
      ],
    ));
  }
}
