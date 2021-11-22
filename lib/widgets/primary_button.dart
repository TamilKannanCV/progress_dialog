import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
      color: const Color(0xFF0085FF),
      onPressed: onPressed,
      textColor: Colors.white,
      child: Text(label),
    );
  }
}
