import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/components/buttons/icon_button_outlined.dart';

class NoteBackButton extends StatelessWidget {
  const NoteBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButtonOutlined(
        icon: FontAwesomeIcons.chevronLeft,
        onPressed: () {
          Navigator.maybePop(context);
        });
  }
}
