import 'package:chart_ganga/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFeedCard extends StatelessWidget {
  const ShimmerFeedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColors.purpleLight,
      highlightColor: CustomColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 280,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColors.white),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: CustomColors.white),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: CustomColors.white),
                ),
                SizedBox(
                  width: 6,
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: CustomColors.white),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: CustomColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
