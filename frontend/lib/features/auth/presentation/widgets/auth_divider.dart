import 'package:flutter/material.dart';
import '../../../../core/theme/stacks_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('or', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: StacksColors.textHint)),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
