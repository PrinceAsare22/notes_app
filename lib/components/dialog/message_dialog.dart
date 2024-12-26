import 'package:flutter/material.dart';
import 'package:notes_app/components/buttons/note_button.dart';
import 'package:notes_app/components/dialog/dialog_card.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            NoteButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ])
        ],
      ),
    );
  }
}
