import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StudnetInformationContainerShimmerEffect extends StatelessWidget {
  final Size size;

  const StudnetInformationContainerShimmerEffect(
      {super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.blueGrey.withOpacity(0.8),
      highlightColor: Colors.blueGrey,
      child: Container(
        height: size.height * 0.3,
        padding: const EdgeInsets.all(20),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.5,
              height: 35,
              color: Colors.white, // Shimmer effect placeholder
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            Container(
              width: size.width * 0.7,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Container(
              width: size.width * 0.6,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Container(
              width: size.width * 0.8,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Container(
              width: size.width * 0.7,
              height: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
