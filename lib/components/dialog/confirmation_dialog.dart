import 'package:flutter/material.dart';
import 'package:notes_app/components/buttons/note_button.dart';
import 'package:notes_app/components/dialog/dialog_card.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            NoteButton(
                isOutlined: true,
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('No')),
            const SizedBox(width: 8),
            NoteButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
          ])
        ],
      ),
    );
  }
}
