import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/modules/cart/widgets/cart_widget.dart';

import '../../providers/grocery_provider.dart';
import '../../utils/colors.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final grocery = ref.watch(groceryProvider);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.h, vertical: 25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        Icon(
                          Icons.location_on,
                          size: 15.sp,
                          color: whiteColor,
                        ),
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
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Cart',
                style: TextStyle(
                    color: grayColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext, index) {
                    return CartWidget(
                      name: grocery.card[index].name,
                      color: Color(int.parse(grocery.card[index].color!)),
                      amount: grocery.card[index].amount,
                      price: grocery.card[index].onSale == true
                          ? grocery.card[index].salePrice
                          : grocery.card[index].regularPrice,
                      amountDetails: grocery.card[index].amountDetails,
                      decAmount: () {
                        print('');
                        if (grocery.card[index].amount! > 0) {
                          setState(() {
                            grocery.card[index].amount =
                                grocery.card[index].amount! - 1;
                            grocery.card[index].onSale == true
                                ? grocery.totalCard = grocery.totalCard -
                                    grocery.card[index].salePrice!.toDouble()
                                : grocery.totalCard = grocery.totalCard -
                                    grocery.card[index].regularPrice!
                                        .toDouble();
                            grocery.notify();
                          });
                        } else {
                          return;
                        }
                      },
                      incAmount: () {
                        setState(() {
                          grocery.card[index].amount =
                              grocery.card[index].amount! + 1;
                          grocery.card[index].onSale == true
                              ? grocery.totalCard = grocery.totalCard +
                                  grocery.card[index].salePrice!.toDouble()
                              : grocery.totalCard = grocery.totalCard +
                                  grocery.card[index].regularPrice!.toDouble();
                          grocery.notify();
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext, index) {
                    return SizedBox(
                      height: 22.w,
                    );
                  },
                  itemCount: grocery.card.length),
            ],
          ),
        ),
      ),
    );
  }
}
