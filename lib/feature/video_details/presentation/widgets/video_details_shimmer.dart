import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VideoDetailsShimmer extends StatelessWidget {
  const VideoDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Player Aspect Ratio Placeholder
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 14.h,
                    width: 150.w,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      CircleAvatar(radius: 20.r, backgroundColor: Colors.white),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 14.h, width: 120.w, color: Colors.white),
                          SizedBox(height: 6.h),
                          Container(height: 10.h, width: 80.w, color: Colors.white),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 36.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => Container(
                        height: 40.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(height: 16.h, width: 100.w, color: Colors.white),
                  SizedBox(height: 12.h),
                  ListTile(
                    leading: CircleAvatar(radius: 16.r, backgroundColor: Colors.white),
                    title: Container(height: 12.h, width: double.infinity, color: Colors.white),
                    subtitle: Container(height: 10.h, width: 100.w, color: Colors.white),
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