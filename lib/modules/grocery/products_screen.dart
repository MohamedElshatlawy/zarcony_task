import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../providers/grocery_provider.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/app_button.dart';
import '../grocery/widgets/deals_of_the_day_widget.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final grocery = ref.watch(groceryProvider);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Products',
          style: TextStyle(
              color: grayColor, fontWeight: FontWeight.w700, fontSize: 15.sp),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 15.sp,
              color: grayColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Column(
          children: [
            ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                shrinkWrap: true,
                itemBuilder: (BuildContext, index) {
                  return SizedBox(
                    height: 100.h,
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (ctx) => ProductDetailsScreen(
                        //               productDetails:
                        //                   grocery.productsOfCategory[index],
                        //             )));
                        showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: lightGrayColor.withOpacity(0.5),
                            context: context,
                            builder: (builder) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      topRight: Radius.circular(35),
                                    ),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 7.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          right: 10.w,
                                          left: 10.w,
                                          top: 10.h,
                                          bottom: 20.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (grocery
                                                            .amountOfProduct >
                                                        0) {
                                                      grocery.amountOfProduct--;
                                                    } else {
                                                      return;
                                                    }
                                                    grocery.notify();
                                                  });
                                                },
                                                child: Container(
                                                  width: 33.h,
                                                  height: 33.h,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: babyBlueColor,
                                                  ),
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                        color:
                                                            darkBabyBlueColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 30.sp),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Text(
                                                grocery.amountOfProduct
                                                    .toString(),
                                                style: TextStyle(
                                                    color: grayColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 19.sp),
                                              ),
                                              SizedBox(width: 10.w),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    grocery.amountOfProduct++;
                                                    grocery.notify();
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 33.h,
                                                  height: 33.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: babyBlueColor,
                                                  ),
                                                  child: Text(
                                                    '+',
                                                    style: TextStyle(
                                                        color:
                                                            darkBabyBlueColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 30.sp),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 25.h),
                                          CustomRoundedButton(
                                            backgroundColor: primaryColor,
                                            borderColor: primaryColor,
                                            pressed: () {
                                              setState(() {
                                                grocery.card.add(grocery
                                                    .productsOfCategory[index]);

                                                if (grocery.card.isNotEmpty) {
                                                  grocery.card
                                                      .forEach((element) {
                                                    if (element.id ==
                                                        grocery
                                                            .productsOfCategory[
                                                                index]
                                                            .id) {
                                                      element.amount = element
                                                              .amount! +
                                                          grocery
                                                              .amountOfProduct;
                                                    }
                                                  });
                                                  grocery
                                                              .productsOfCategory[
                                                                  index]
                                                              .onSale ==
                                                          true
                                                      ? grocery
                                                          .totalCard = grocery
                                                              .totalCard +
                                                          grocery
                                                                  .productsOfCategory[
                                                                      index]
                                                                  .salePrice!
                                                                  .toDouble() *
                                                              grocery
                                                                  .productsOfCategory[
                                                                      index]
                                                                  .amount!
                                                      : grocery
                                                          .totalCard = grocery
                                                              .totalCard +
                                                          grocery
                                                                  .productsOfCategory[
                                                                      index]
                                                                  .regularPrice!
                                                                  .toDouble() *
                                                              grocery
                                                                  .productsOfCategory[
                                                                      index]
                                                                  .amount!;
                                                }
                                                grocery.notify();
                                              });
                                              Navigator.pop(context);
                                            },
                                            text: 'Add To Card',
                                            textColor: Colors.white,
                                            elevation: 0,
                                            home: false,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            });
                      },
                      child: DealsOfTheDay(
                        name: grocery.productsOfCategory[index].name,
                        color: grocery.productsOfCategory[index].color,
                        onSale: grocery.productsOfCategory[index].onSale,
                        salePrice: grocery.productsOfCategory[index].salePrice,
                        regularPrice:
                            grocery.productsOfCategory[index].regularPrice,
                        isFavourite:
                            grocery.productsOfCategory[index].isFavourite,
                        isFavLoading:
                            grocery.productsOfCategory[index].isFavLoading,
                        addFav: () {
                          if (grocery.productsOfCategory[index].isFavLoading ==
                              false) {
                            grocery.favProducts
                                .add(grocery.productsOfCategory[index]);
                            grocery.productsOfCategory[index].isFavLoading =
                                true;
                            setState(() {});
                          } else {
                            grocery.favProducts
                                .remove(grocery.productsOfCategory[index]);
                            grocery.productsOfCategory[index].isFavLoading =
                                false;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext, index) {
                  return SizedBox(
                    width: 27.h,
                  );
                },
                itemCount: grocery.productsOfCategory.length),
          ],
        ),
      ),
    );
  }
}
