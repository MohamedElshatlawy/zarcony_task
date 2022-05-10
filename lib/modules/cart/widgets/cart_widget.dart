import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class CartWidget extends StatefulWidget {
  String? name;
  String? amountDetails;
  int? price;
  int? amount;
  Color? color;
  void Function()? incAmount;
  void Function()? decAmount;

  CartWidget({
    Key? key,
    this.name,
    this.amount,
    this.price,
    this.amountDetails,
    this.decAmount,
    this.incAmount,
    this.color,
  }) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56.h,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: hintTextColor,
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.name}',
                style: TextStyle(
                    color: darkBlueColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp),
              ),
              Text(
                '${widget.amountDetails}',
                style: TextStyle(
                    color: lightGrayColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 9.sp),
              ),
              Text(
                '\$ ${widget.price}',
                style: TextStyle(
                    color: darkRedColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp),
              ),
            ],
          ),
          SizedBox(width: 25.w),
          Row(
            children: [
              InkWell(
                onTap: widget.decAmount,
                child: Container(
                  width: 33.h,
                  height: 33.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: babyBlueColor,
                  ),
                  child: Text(
                    '-',
                    style: TextStyle(
                        color: darkBabyBlueColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                widget.amount.toString(),
                style: TextStyle(
                    color: grayColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 19.sp),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: widget.incAmount,
                child: Container(
                  alignment: Alignment.center,
                  width: 33.h,
                  height: 33.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: babyBlueColor,
                  ),
                  child: Text(
                    '+',
                    style: TextStyle(
                        color: darkBabyBlueColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.sp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
