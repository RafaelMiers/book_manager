import 'package:flutter/material.dart';
import '../../../../core/theme/stacks_colors.dart';

class StarRating extends StatelessWidget {
  final double? rating;
  final double size;

  const StarRating({super.key, this.rating, this.size = 12});

  @override
  Widget build(BuildContext context) {
    if (rating == null) {
      return const SizedBox.shrink();
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return Icon(
          i < rating!.round() ? Icons.star : Icons.star_border,
          color: StacksColors.starColor,
          size: size,
        );
      }),
    );
  }
}
