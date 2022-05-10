import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

class AddressWidget extends StatelessWidget {
  final Color? addressColor;
  final String? addressTitle;
  final String? address;
  const AddressWidget(
      {Key? key, this.addressColor, this.address, this.addressTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 7.h,
        horizontal: 7.w,
      ),
      // width: 167.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: newBorderColor,
          )),
      child: Row(
        children: [
          Container(
            width: 38.h,
            height: 38.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: addressColor,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$addressTitle',
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 88.w,
                child: Text(
                  '$address',
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 9.sp),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
