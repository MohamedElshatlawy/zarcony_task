import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class DealsOfTheDay extends StatelessWidget {
  String? name;
  String? color;
  int? regularPrice;
  bool? onSale;
  int? salePrice;
  bool? isFavourite;
  bool? isFavLoading;
  void Function()? addFav;
  DealsOfTheDay({
    Key? key,
    this.name,
    this.color,
    this.regularPrice,
    this.onSale,
    this.salePrice,
    this.isFavourite,
    this.isFavLoading,
    this.addFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            color: whiteColor,
            child: Row(
              children: [
                Container(
                  width: 90.h,
                  height: 90.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(int.parse(color!)),
                  ),
                ),
                SizedBox(width: 13.w),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp),
                      ),
                      Text(
                        'Pieces 5',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/Group 22867.png',
                            color: textColor,
                            scale: 7,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          // Icon(Icons.location_on, size: 15.sp),
                          Text(
                            '15 Minutes Away',
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp),
                          ),
                        ],
                      ),
                      if (onSale == true) ...[
                        Row(
                          children: [
                            Text(
                              '\$ ${salePrice.toString()}',
                              style: TextStyle(
                                  color: orangeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '\$ ${regularPrice.toString()}',
                              style: TextStyle(
                                  color: faddenGreyColor,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: faddenGreyColor,
                                  fontSize: 13.sp),
                            ),
                          ],
                        )
                      ],
                      if (onSale == false) ...[
                        Row(
                          children: [
                            Text(
                              '\$ ${regularPrice.toString()}',
                              style: TextStyle(
                                  color: orangeColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp),
                            ),
                          ],
                        )
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: addFav,
            child: Container(
              width: 26.h,
              height: 26.h,
              padding: EdgeInsets.only(bottom: 3.h),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
              child: isFavLoading == true
                  ? Icon(
                      Icons.favorite,
                      size: 15.sp,
                      color: redColor,
                    )
                  : Image.asset(
                      "assets/Group 16103.png",
                      color: faddenGreyColor,
                      scale: 6,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
