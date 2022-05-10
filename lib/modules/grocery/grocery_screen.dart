import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/modules/grocery/products_screen.dart';
import 'package:grocery/modules/grocery/widgets/address_widget.dart';
import 'package:grocery/modules/grocery/widgets/deals_of_the_day_widget.dart';

import '../../providers/grocery_provider.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/custom_textfield.dart';

class GroceryScreen extends ConsumerStatefulWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  _GroceryScreenState createState() => _GroceryScreenState();
}

class _GroceryScreenState extends ConsumerState<GroceryScreen> {
  void getCategories() async {
    await ref.read(groceryProvider).getCategories();
  }

  void getProducts() async {
    await ref.read(groceryProvider).getProducts();
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(groceryProvider).categories;
    final products = ref.watch(groceryProvider).products;
    final grocery = ref.watch(groceryProvider);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: categories == null || categories.data!.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 17.w, right: 17.w, top: 25.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 34.h,
                          width: 123.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              topRight: Radius.circular(50),
                            ),
                            color: orangeColor,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset(
                                'assets/Group 22867.png',
                                color: whiteColor,
                                scale: 4,
                              ),
                              // Icon(
                              //   Icons.location_on,
                              //   size: 15.sp,
                              //   color: whiteColor,
                              // ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Mustafa St.',
                                style: TextStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 34.h,
                          width: 34.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: borderColor)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 17.w, vertical: 25.h),
                    child: CustomTextField(
                      hint: 'Search in thousands of categories',
                      filledColor: textFieldFilledColor,
                      onFieldSubmitted: (v) {},
                      icon: Icon(
                        Icons.search,
                        size: 25.sp,
                        color: textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddressWidget(
                          addressTitle: 'Home Address',
                          address: 'Mustafa St. No:2 Street x12',
                          addressColor: borderColor,
                        ),
                        AddressWidget(
                          addressTitle: 'Office Address',
                          address: 'Axis Istanbul, B2 Blok Floor 2, Office 11',
                          addressColor: borderColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Explore by Category',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp),
                        ),
                        Text(
                          'See All (${categories.data!.length})',
                          style: TextStyle(
                              color: hintTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 17.w),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext, index) {
                          return InkWell(
                            onTap: () {
                              grocery.getProductsOfCategory(
                                  categoryId:
                                      categories.data![index].categoryId!);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ProductScreen()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 56.h,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(int.parse(
                                        categories.data![index].color!)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  categories.data![index].name!,
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext, int) {
                          return SizedBox(
                            width: 22.w,
                          );
                        },
                        itemCount: categories.data!.length),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
                    child: Row(
                      children: [
                        Text(
                          'Deals of the day',
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 17.w),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext, index) {
                          return DealsOfTheDay(
                            name: products!.data![index].name,
                            color: products.data![index].color,
                            onSale: products.data![index].onSale,
                            salePrice: products.data![index].salePrice,
                            regularPrice: products.data![index].regularPrice,
                            isFavourite: products.data![index].isFavourite,
                            isFavLoading: products.data![index].isFavLoading,
                            addFav: () {
                              if (products.data![index].isFavLoading == false) {
                                grocery.favProducts.add(products.data![index]);
                                products.data![index].isFavLoading = true;
                                setState(() {});
                              } else {
                                grocery.favProducts
                                    .remove(products.data![index]);
                                products.data![index].isFavLoading = false;
                                setState(() {});
                              }
                            },
                          );
                        },
                        separatorBuilder: (BuildContext, index) {
                          return SizedBox(
                            width: 27.w,
                          );
                        },
                        itemCount: products!.data!.length),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 122.h,
                    margin: EdgeInsets.symmetric(
                      horizontal: 17.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: roseColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mega',
                                      style: TextStyle(
                                          color: orangeColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'WHOPP',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: blueColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 31.sp),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'E',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: orangeColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 31.sp),
                                          ),
                                          TextSpan(
                                            text: 'R',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: blueColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 31.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$ 17',
                                      style: TextStyle(
                                          color: orangeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Text(
                                      '\$ 32',
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.w400,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: whiteColor,
                                          fontSize: 18.sp),
                                    ),
                                  ],
                                ),
                                Text(
                                  '* Available until 24 December 2020',
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 9.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
