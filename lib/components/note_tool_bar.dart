import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/constants.dart';

class NoteToolBar extends StatelessWidget {
  const NoteToolBar({
    super.key,
    required this.quillController,
  });

  final QuillController quillController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: black,
          border: Border.all(
              color: primary, strokeAlign: BorderSide.strokeAlignOutside),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: primary,
              offset: Offset(4, 4),
            ),
          ]),
      child: QuillSimpleToolbar(
        controller: quillController,
        configurations: QuillSimpleToolbarConfigurations(
          color: theme.colorScheme.surface,
          multiRowsDisplay: false,
          showFontFamily: false,
          showFontSize: false,
          showInlineCode: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showAlignmentButtons: false,
          showDirection: false,
          showHeaderStyle: false,
          showListCheck: false,
          showCodeBlock: false,
          showQuote: false,
          showIndent: false,
          showLink: false,
          showClipboardCut: false,
          showClipboardCopy: false,
          showClipboardPaste: false,
          buttonOptions: const QuillSimpleToolbarButtonOptions(
              undoHistory: QuillToolbarHistoryButtonOptions(
                iconData: FontAwesomeIcons.rotateLeft,
              ),
              redoHistory: QuillToolbarHistoryButtonOptions(
                iconData: FontAwesomeIcons.rotateRight,
              ),
              bold: QuillToolbarToggleStyleButtonOptions(
                iconData: FontAwesomeIcons.bold,
              ),
              italic: QuillToolbarToggleStyleButtonOptions(
                iconData: FontAwesomeIcons.italic,
              ),
              underLine: QuillToolbarToggleStyleButtonOptions(
                iconData: FontAwesomeIcons.strikethrough,
              ),
              strikeThrough: QuillToolbarToggleStyleButtonOptions(
                iconData: FontAwesomeIcons.bold,
              ),
              color: QuillToolbarColorButtonOptions(
                iconData: FontAwesomeIcons.palette,
              ),
              backgroundColor: QuillToolbarColorButtonOptions(
                iconData: FontAwesomeIcons.fill,
              ),
              clearFormat: QuillToolbarClearFormatButtonOptions(
                iconData: FontAwesomeIcons.textSlash,
              ),
              listNumbers: QuillToolbarToggleStyleButtonOptions(
                iconData: FontAwesomeIcons.listOl,
              ),
              listBullets: QuillToolbarToggleStyleButtonOptions(
                iconData: FontAwesomeIcons.listUl,
              ),
              search: QuillToolbarSearchButtonOptions(
                iconData: FontAwesomeIcons.magnifyingGlass,
              )),
        ),
      ),
    );
  }
}
