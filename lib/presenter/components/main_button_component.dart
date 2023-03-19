import 'package:flutter/material.dart';

class MainButtonComponent extends StatelessWidget {
  final String label;
  final Function() onTap;

  const MainButtonComponent({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.green),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(45)),
          ),
        ),
        side: MaterialStatePropertyAll(
          BorderSide(color: Colors.white),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 64),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
