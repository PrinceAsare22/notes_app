import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({
    super.key,
    required this.label,
    this.onClosed,
    this.onTap,
  });

  final String label;
  final VoidCallback? onClosed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: gray100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: gray700,
                fontSize: onClosed != null ? 14 : 12,
              ),
            ),
            if (onClosed != null) const SizedBox(width: 4),
            GestureDetector(
              onTap: onClosed,
              child: Icon(
                Icons.close,
                color: isDark ? gray900 : gray700,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
