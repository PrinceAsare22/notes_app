import 'package:flutter/material.dart';
import 'package:notes_app/components/buttons/note_button.dart';
import 'package:notes_app/components/notes/note_form_field.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({
    super.key,
    this.tag,
  });

  final String? tag;

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late final TextEditingController controller;

  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.tag);
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Add Tag',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 24),
        NoteFormField(
          controller: controller,
          key: tagKey,
          hintText: 'Add Tag (< 16 characters)',
          validator: (value) {
            if (value!.trim().isEmpty) {
              return 'No tags added';
            } else if (value.trim().length > 16) {
              return 'Tag should not exceed 16 characters';
            }
            return null;
          },
          onChanged: (value) {
            tagKey.currentState?.validate();
          },
          autofocus: true,
        ),
        const SizedBox(height: 24),
        NoteButton(
          child: const Text('Add'),
          onPressed: () {
            if (tagKey.currentState?.validate() ?? false) {
              Navigator.pop(context, controller.text.trim());
            }
          },
        ),
      ],
    );
  }
}
