import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/new_note_controller.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/components/dialog/dialogs.dart';
import 'package:notes_app/components/notes/note_tag.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/new_or_edit_note_page.dart';
import 'package:notes_app/utils/utils.dart';
import 'package:provider/provider.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    super.key,
    required this.isInGrid,
    required this.note,
  });

  final Note note;
  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => NewNoteController()..note = note,
              child: const NewOrEditNotePage(
                isNewNote: false,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(isDark ? 0.3 : 0.5),
              offset: const Offset(4, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.title != null) ...[
              Text(
                note.title!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
            ],
            if (note.tags != null) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    note.tags!.length,
                    (index) => NoteTag(label: note.tags![index]),
                  ),
                ),
              ),
              const SizedBox(height: 4),
            ],
            if (note.content != null)
              isInGrid
                  ? Expanded(
                      child: Text(
                        note.content!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  : Text(
                      note.content!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
            if (isInGrid) const Spacer(),
            Row(
              children: [
                Text(
                  toShortDate(note.dateModified),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final shouldDelete = await showConfirmationDialog(
                            context: context,
                            title: 'Do you want to delete this note?') ??
                        false;

                    if (shouldDelete && context.mounted) {
                      context.read<NotesProvider>().deleteNote(note);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    color: theme.textTheme.bodySmall?.color,
                    size: 16,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
