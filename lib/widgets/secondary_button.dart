import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    this.onPressed,
    required this.label,
  }) : super(key: key);

  final Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0.0,
      onPressed: onPressed,
      textColor: const Color(0xFF0085FF),
      child: Text(label),
    );
  }
}
