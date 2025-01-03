import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/components/buttons/icon_button_outlined.dart';

class NoteBackButton extends StatelessWidget {
  const NoteBackButton({
    super.key,
  });

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return IconButtonOutlined(
        icon: FontAwesomeIcons.chevronLeft,
        onPressed: () {
          Navigator.maybePop(context);
          _dismissKeyboard(context);
        });
  }
}
