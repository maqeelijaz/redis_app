import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  buildBasicShimmer({double height = 250, double width = double.infinity}) {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.grey.withOpacity(0.1),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
        ));
  }

  buildListShimmer({double height = 100, int count = 10}) {
    return ListView.builder(
      itemCount: count,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 0.0, right: 0.0, bottom: 0.0),
          child: ShimmerHelper().buildBasicShimmer(height: height),
        );
      },
    );
  }
}
