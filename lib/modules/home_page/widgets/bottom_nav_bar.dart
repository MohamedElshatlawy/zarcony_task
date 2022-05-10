import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../providers/grocery_provider.dart';
import '../../../utils/colors.dart';

// Bottom Nave Bar for Home
class BottomNavBarWidget extends ConsumerStatefulWidget {
  const BottomNavBarWidget({
    Key? key,
    required this.onPress,
    required this.currentIndex,
  }) : super(key: key);
  final Function(int) onPress;
  final int currentIndex;

  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends ConsumerState<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    final grocery = ref.watch(groceryProvider);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 80.h,
          color: whiteColor,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 53.h,
              clipBehavior: Clip.hardEdge,
              margin:
                  EdgeInsets.only(right: 2.w, left: 2.w, bottom: 5.w, top: 2.w),
              decoration: BoxDecoration(
                color: whiteColor,
              ),
              // Bottom navigation bar
              child: BottomNavigationBar(
                onTap: widget.onPress,
                backgroundColor: lightBlueColor,
                currentIndex: widget.currentIndex,
                selectedItemColor: primaryColor,
                unselectedItemColor: faddenGreyColor,
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontSize: 8.sp,
                ),
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: primaryColor,
                  fontSize: 8.sp,
                ),
                type: BottomNavigationBarType.fixed,
                elevation: 2,
                // pages
                items: [
                  // Home Page
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/Group 16093.png",
                      color: widget.currentIndex == 0
                          ? primaryColor
                          : faddenGreyColor,
                      scale: 4,
                    ),
                    label: 'Grocery',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/Group 16107.png",
                      color: widget.currentIndex == 1
                          ? primaryColor
                          : faddenGreyColor,
                      scale: 4,
                    ),
                    label: "News",
                  ),
                  // Profile Page
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      "assets/Group 16103.png",
                      color: widget.currentIndex == 2
                          ? primaryColor
                          : faddenGreyColor,
                      scale: 4,
                    ),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/Group 22867.svg",
                      color: widget.currentIndex == 3
                          ? primaryColor
                          : faddenGreyColor,
                    ),
                    label: 'Cart',
                  ),
                ],
              ),
            ),
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              child: SvgPicture.asset(
                "assets/Group 22866.svg",
              ),
            ),
            if (grocery.totalCard != 0.0) ...[
              Padding(
                padding: EdgeInsets.only(bottom: 15.h, right: 7.w),
                child: Text(
                  '\$ ${grocery.totalCard.toString()}',
                  style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp),
                ),
              ),
            ]
          ],
        )
      ],
    );
  }
}
