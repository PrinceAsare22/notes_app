import 'package:flutter/material.dart';
import 'package:notes_app/components/dialog/confirmation_dialog.dart';
import 'package:notes_app/components/dialog/dialog_card.dart';
import 'package:notes_app/components/dialog/message_dialog.dart';
import 'package:notes_app/components/dialog/new_tag_dialog.dart';

Future<String?> showNewTagDialog({
  required BuildContext context,
  String? tag,
}) {
  return showDialog<String?>(
    context: context,
    builder: (context) => DialogCard(
      child: NewTagDialog(tag: tag),
    ),
  );
}

Future<bool?> showConfirmationDialog(
    {required BuildContext context, required String title}) {
  return showDialog<bool?>(
      context: context, builder: (_) => ConfirmationDialog(title: title));
}

Future<bool?> showMessageDialog(
    {required BuildContext context, required String message}) {
  return showDialog<bool?>(
      context: context, builder: (_) => MessageDialog(message: message));
}
