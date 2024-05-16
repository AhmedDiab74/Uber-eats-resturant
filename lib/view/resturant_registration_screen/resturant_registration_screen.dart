import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/controller/provider/resturant_register_provider/resturant_register_provider.dart';
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
  CarouselController controller = CarouselController();
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
            Consumer<ResturantRegisterProvider>(
                builder: (context, resturantRegisterProvider, child) {
              if (resturantRegisterProvider.resturantBannerImages.isEmpty) {
                return InkWell(
                  onTap: () async {
                    await resturantRegisterProvider
                        .getResturantBannerImages(context);
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
                );
              } else {
                List<File> bannerImages =
                    resturantRegisterProvider.resturantBannerImages;
                return Container(
                  height: 23.h,
                  width: 94.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                    border: Border.all(color: greyShade3),
                  ),
                  child: CarouselSlider(
                    carouselController: controller,
                    options: CarouselOptions(
                      height: 23.h,
                      autoPlay: true,
                      viewportFraction: 1,
                    ),
                    items: bannerImages
                        .map((image) => Container(
                              width: 94.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              }
            }),
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
