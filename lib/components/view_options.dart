import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/components/buttons/icon_button.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/enums/order_options.dart';
import 'package:provider/provider.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Consumer<NotesProvider>(
      builder: (_, notesProvider, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CustomIconButton(
              icon: notesProvider.isDescending
                  ? FontAwesomeIcons.arrowDown
                  : FontAwesomeIcons.arrowUp,
              onPressed: () {
                setState(() {
                  notesProvider.isDescending = !notesProvider.isDescending;
                });
              },
              size: 18,
            ),
            const SizedBox(width: 16),
            DropdownButton<OrderOption>(
              dropdownColor: isDark ? theme.colorScheme.surface : white,
              value: notesProvider.orderBy,
              icon: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: FaIcon(
                  FontAwesomeIcons.arrowDownWideShort,
                  size: 18,
                  color: isDark ? white : gray700,
                ),
              ),
              underline: const SizedBox.shrink(),
              borderRadius: BorderRadius.circular(16),
              isDense: true,
              items: OrderOption.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(e.name),
                          if (e == notesProvider.orderBy) ...[
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(Icons.check),
                          ]
                        ],
                      ),
                    ),
                  )
                  .toList(),
              selectedItemBuilder: (context) =>
                  OrderOption.values.map((e) => Text(e.name)).toList(),
              onChanged: (newValue) {
                setState(() {
                  notesProvider.orderBy = newValue!;
                });
              },
            ),
            const Spacer(),
            CustomIconButton(
              icon: notesProvider.isGrid
                  ? FontAwesomeIcons.tableCellsLarge
                  : FontAwesomeIcons.bars,
              onPressed: () {
                setState(() {
                  notesProvider.isGrid = !notesProvider.isGrid;
                });
              },
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
