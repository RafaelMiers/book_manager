import 'package:flutter/material.dart';
import '../../../../core/theme/stacks_colors.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const GoogleSignInButton({super.key, required this.onPressed, this.label = 'Continue with Google'});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Replace with google icon asset when available
          const Icon(Icons.g_mobiledata, color: StacksColors.textSecondary, size: 20),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
