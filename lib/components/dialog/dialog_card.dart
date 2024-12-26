import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.75,
          margin: MediaQuery.viewInsetsOf(context),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(color: black, width: 2),
            boxShadow: const [
              BoxShadow(
                offset: Offset(4, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: child,
        ),
      ),
    );
  }
}
