import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFFE1E0E0),
      highlightColor: Color(0xFFA6A5A5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
