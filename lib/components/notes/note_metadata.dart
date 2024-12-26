import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/components/buttons/icon_button.dart';
import 'package:notes_app/components/dialog/dialogs.dart';
import 'package:notes_app/components/notes/note_tag.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/utils/utils.dart';
import 'package:provider/provider.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({
    super.key,
    required this.note,
  });

  final Note? note;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();

    newNoteController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Last Modified',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray300),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dateModified),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 3,
                child: Text(
                  'Created',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray300),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dateCreated),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const Text(
                    'Tags',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: gray300),
                  ),
                  const SizedBox(width: 8),
                  CustomIconButton(
                    icon: FontAwesomeIcons.circlePlus,
                    onPressed: () async {
                      final String? tag =
                          await showNewTagDialog(context: context);
                      if (tag != null) {
                        newNoteController.addTag(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<NewNoteController, List<String>>(
                  selector: (_, NewNoteController) => newNoteController.tags,
                  builder: (_, tags, __) => tags.isEmpty
                      ? const Text(
                          'No tags added',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                tags.length,
                                (index) => NoteTag(
                                      label: tags[index],
                                      onClosed: () {
                                        newNoteController.removeTag(index);
                                      },
                                      onTap: () async {
                                        final String? tag =
                                            await showNewTagDialog(
                                                context: context,
                                                tag: tags[index]);
                                        if (tag != null && tag != tags[index]) {
                                          newNoteController.updateTag(
                                              tag, index);
                                        }
                                      },
                                    )),
                          ),
                        )),
            ),
          ],
        ),
      ],
    );
  }
}
