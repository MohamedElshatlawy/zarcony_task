import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/product_model.dart' as product;
import '../../providers/grocery_provider.dart';
import '../../utils/colors.dart';
import '../../utils/widgets/app_button.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final product.Data productDetails;
  const ProductDetailsScreen({Key? key, required this.productDetails})
      : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
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
          '${widget.productDetails.name}',
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
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 17.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomRoundedButton(
                backgroundColor: primaryColor,
                borderColor: primaryColor,
                pressed: () {
                  grocery.card.add(widget.productDetails);
                  setState(() {});
                  if (grocery.card.isNotEmpty) {
                    grocery.card.forEach((element) {
                      if (element.id == widget.productDetails.id) {
                        element.amount = element.amount! + 1;
                      }
                    });
                    widget.productDetails.onSale == true
                        ? grocery.totalCard = grocery.totalCard +
                            widget.productDetails.salePrice!.toDouble()
                        : grocery.totalCard = grocery.totalCard +
                            widget.productDetails.regularPrice!.toDouble();
                  }
                  setState(() {});
                  grocery.notify();
                },
                text: 'Add To Card',
                textColor: Colors.white,
                elevation: 0,
                home: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
