import 'package:flutter/material.dart';
import '../../../../core/theme/stacks_colors.dart';

class StacksLogoBig extends StatelessWidget {
  const StacksLogoBig({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Logo placeholder ───────────────────
        // Replace this Container with your Image.asset('assets/logo.png')
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: StacksColors.borderSubtle, width: 1.5),
          ),
          child: const Center(
            child: Text('LOGO', style: TextStyle(fontSize: 10, color: StacksColors.textHint, letterSpacing: 1)),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'stacks',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: -0.03),
        ),
        const SizedBox(height: 4),
        Text(
          'your personal library',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: StacksColors.textHint),
        ),
      ],
    );
  }
}

class StacksLogoSmall extends StatelessWidget {
  const StacksLogoSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Replace with Image.asset('assets/logo.png', width: 28, height: 28)
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: StacksColors.borderSubtle),
          ),
          child: const Center(
            child: Text('S', style: TextStyle(fontSize: 10, color: StacksColors.textHint)),
          ),
        ),
        const SizedBox(width: 8),
        Text('stacks', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
