import 'package:flutter/material.dart';

class IconBorder extends StatelessWidget {
  const IconBorder({super.key, required this.icon});

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).colorScheme.primaryFixed
                : Theme.of(context).colorScheme.onSecondary),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
