import 'package:flutter/material.dart';

class StacksTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffix;

  const StacksTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffix,
  });

  @override
  State<StacksTextField> createState() => _StacksTextFieldState();
}

class _StacksTextFieldState extends State<StacksTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: widget.hint,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      size: 18,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : widget.suffix,
          ),
        ),
      ],
    );
  }
}
