import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/controller/services/images_services/images_services.dart';
import 'package:ubereatsresturant/utils/colors.dart';
import 'package:ubereatsresturant/utils/textStyles.dart';
import 'package:ubereatsresturant/widgets/custom_text_field.dart';

class ResturantRegistrationScreen extends StatefulWidget {
  const ResturantRegistrationScreen({super.key});
  @override
  State<ResturantRegistrationScreen> createState() =>
      _ResturantRegistrationScreenState();
}

class _ResturantRegistrationScreenState
    extends State<ResturantRegistrationScreen> {
  final TextEditingController resturantNameController = TextEditingController();
  final TextEditingController resturantLicenceNumberController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () async {
                await ImagesServices.getImagesFromGallery(context: context);
              },
              child: Container(
                height: 20.h,
                width: 94.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: greyShade3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 5.h,
                      width: 5.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: black,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 3.h,
                        color: black,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "Add",
                      style: AppTextStyles.body14Bold,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            CustomTextfield(
              controller: resturantNameController,
              title: "Resturant Name",
              hintText: "Resturant Name",
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomTextfield(
              controller: resturantLicenceNumberController,
              title: "Registration Number",
              hintText: "Registration Number",
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
