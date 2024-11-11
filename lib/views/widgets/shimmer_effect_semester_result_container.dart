import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectSemesterResultContainer extends StatelessWidget {
  const ShimmerEffectSemesterResultContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Shimmer.fromColors(
        baseColor: Colors.blueGrey,
        highlightColor: Colors.blueAccent,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey,
                ),
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
