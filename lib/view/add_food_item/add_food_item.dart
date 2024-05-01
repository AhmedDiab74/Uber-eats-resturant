import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/utils/colors.dart';
import 'package:ubereatsresturant/utils/textStyles.dart';

class AddFoodItem extends StatefulWidget {
  const AddFoodItem({super.key});
  @override
  State<AddFoodItem> createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController foodDescriptionController =
      TextEditingController();
  final TextEditingController foodPriceController = TextEditingController();
  bool foodIsPureVegetarian = true;
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
            Container(
              height: 20.h,
              width: 943.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp), color: greyShade3),
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
            SizedBox(
              height: 4.h,
            ),
            FoodDetailsTextfield(
              controller: foodNameController,
              title: "Name",
              hintText: "Food Name",
            ),
            SizedBox(
              height: 2.h,
            ),
            FoodDetailsTextfield(
              controller: foodDescriptionController,
              title: "Description",
              hintText: "Food Description",
            ),
            SizedBox(
              height: 2.h,
            ),
            FoodDetailsTextfield(
              controller: foodPriceController,
              title: "Price",
              hintText: "Food Price",
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Food is Vegeterian",
              style: AppTextStyles.body16Bold,
            ),
            SizedBox(
              height: 0.8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      foodIsPureVegetarian = true;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 3.h,
                        width: 3.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: foodIsPureVegetarian
                              ? Colors.green.shade100
                              : transparent,
                          borderRadius: BorderRadius.circular(3.sp),
                          border: Border.all(
                            color: foodIsPureVegetarian ? black : grey,
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          size: 2.h,
                          color: foodIsPureVegetarian ? black : transparent,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        "Vegeterian",
                        style: AppTextStyles.body14,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      foodIsPureVegetarian = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 3.h,
                        width: 3.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !foodIsPureVegetarian
                              ? Colors.green.shade100
                              : transparent,
                          borderRadius: BorderRadius.circular(3.sp),
                          border: Border.all(
                            color: !foodIsPureVegetarian ? black : grey,
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.check,
                          size: 2.h,
                          color: !foodIsPureVegetarian ? black : transparent,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        "Non-Vegeterian",
                        style: AppTextStyles.body14,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FoodDetailsTextfield extends StatelessWidget {
  const FoodDetailsTextfield(
      {super.key,
      required this.controller,
      required this.title,
      required this.hintText,
      this.keyboardType = TextInputType.name});
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyles.body16Bold,
        ),
        SizedBox(
          height: 0.8.h,
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: black,
          style: AppTextStyles.textFieldTextStyle,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 2.w),
            hintText: hintText,
            hintStyle: AppTextStyles.textFieldHintTextStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: black,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
