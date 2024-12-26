import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.icon, required this.onPressed, this.size});

  final IconData icon;
  final VoidCallback onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(),
      style:
          IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      iconSize: size,
      color: isDark ? white : gray700,
    );
  }
}
