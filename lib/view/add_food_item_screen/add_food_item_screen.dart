import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturant/constant/constant.dart';
import 'package:ubereatsresturant/controller/provider/add_food_provider/add_food_provider.dart';
import 'package:ubereatsresturant/controller/services/food_data_crud_services/food_data_crud_services.dart';
import 'package:ubereatsresturant/model/add_food_model/add_food_model.dart';
import 'package:ubereatsresturant/utils/colors.dart';
import 'package:ubereatsresturant/utils/textStyles.dart';
import 'package:ubereatsresturant/widgets/common_elevated_button.dart';
import 'package:ubereatsresturant/widgets/custom_text_field.dart';

class AddFoodItemScreen extends StatefulWidget {
  const AddFoodItemScreen({super.key});
  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController foodDescriptionController =
      TextEditingController();
  final TextEditingController foodPriceController = TextEditingController();
  bool foodIsPureVegetarian = true;
  bool pressedAddFoodItemButton = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeftLong),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Consumer<AddFoodProvider>(
                builder: (context, addFoodProvider, child) {
              return InkWell(
                onTap: () async {
                  await addFoodProvider.pickFoodImageFromGallery(context);
                },
                child: Container(
                    height: 20.h,
                    width: 94.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        color: greyShade3),
                    child: Builder(
                      builder: (context) {
                        if (addFoodProvider.foodImage != null) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Image(
                              image: FileImage(addFoodProvider.foodImage!),
                              fit: BoxFit.contain,
                            ),
                          );
                        } else {
                          return Column(
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
                          );
                        }
                      },
                    )),
              );
            }),
            SizedBox(
              height: 4.h,
            ),
            CustomTextfield(
              controller: foodNameController,
              title: "Name",
              hintText: "Food Name",
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomTextfield(
              controller: foodDescriptionController,
              title: "Description",
              hintText: "Food Description",
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomTextfield(
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
            ),
            SizedBox(
              height: 4.h,
            ),
            CummonElevatedButton(
              onPressed: () async {
                setState(() {
                  pressedAddFoodItemButton = true;
                });
                await context
                    .read<AddFoodProvider>()
                    .uploadImageAndGetImageURL(context);
                String foodID = uuid.v1().toString();
                AddFoodModel data = AddFoodModel(
                  foodID: foodID,
                  resturantUID: auth.currentUser!.uid,
                  uplaodTime: DateTime.now(),
                  name: foodNameController.text.trim(),
                  description: foodDescriptionController.text.trim(),
                  foodImageURL: context.read<AddFoodProvider>().foodImageUrl!,
                  isVegetrian: foodIsPureVegetarian,
                  price: foodPriceController.text.trim(),
                );
                FoodDataCRUDSetvices.uploadFoodData(context, data);
              },
              child: pressedAddFoodItemButton
                  ? CircularProgressIndicator(
                      color: white,
                    )
                  : Text(
                      "Add Food",
                      style: AppTextStyles.body16Bold.copyWith(
                        color: white,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
