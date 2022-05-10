import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../providers/grocery_provider.dart';
import '../../utils/colors.dart';
import '../grocery/widgets/deals_of_the_day_widget.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favProducts = ref.watch(groceryProvider).favProducts;
    final products = ref.watch(groceryProvider).products;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Favorites',
          style: TextStyle(
              color: grayColor, fontWeight: FontWeight.w700, fontSize: 15.sp),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
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
                    child: DealsOfTheDay(
                      name: favProducts[index].name,
                      color: favProducts[index].color,
                      onSale: favProducts[index].onSale,
                      salePrice: favProducts[index].salePrice,
                      regularPrice: favProducts[index].regularPrice,
                      isFavourite: favProducts[index].isFavourite,
                      isFavLoading: favProducts[index].isFavLoading,
                      addFav: () {
                        products!.data!.forEach((element) {
                          if (element.id == favProducts[index].id) {
                            element.isFavLoading = false;
                          }
                        });
                        favProducts.remove(favProducts[index]);
                        setState(() {});
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext, index) {
                  return SizedBox(
                    width: 27.h,
                  );
                },
                itemCount: favProducts.length),
          ],
        ),
      ),
    );
  }
}
