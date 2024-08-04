import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountRowCard extends StatelessWidget {
  final String title;
  final String text;
  final Function()? onTap;

  const AccountRowCard({super.key, required this.title, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.sp),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold
                      ),),
                      Text(text, style: TextStyle(
                        fontSize: 18.sp,
                      ),),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
          Container(width: double.infinity,height: 0.5, color: Colors.black,),
        ],
      ),
    );
  }
}
