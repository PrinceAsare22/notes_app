import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {
  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().loadOrderSettings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Consumer<NotesProvider>(
      builder: (_, notesProvider, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: FaIcon(
                notesProvider.isDescending
                    ? FontAwesomeIcons.arrowDown
                    : FontAwesomeIcons.arrowUp,
                size: 18,
              ),
              onPressed: () {
                notesProvider.toggleDescending();
              },
            ),
            const SizedBox(width: 16),
            DropdownButton<OrderOption>(
              dropdownColor: isDark ? theme.colorScheme.surface : Colors.white,
              value: notesProvider.orderBy,
              icon: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: FaIcon(
                  FontAwesomeIcons.arrowDownWideShort,
                  size: 18,
                  color: isDark ? Colors.white : Colors.grey[700],
                ),
              ),
              underline: const SizedBox.shrink(),
              borderRadius: BorderRadius.circular(16),
              isDense: true,
              items: OrderOption.values
                  .map(
                    (e) => DropdownMenuItem<OrderOption>(
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
              onChanged: (OrderOption? newValue) {
                if (newValue != null) {
                  notesProvider.setOrderBy(newValue);
                }
              },
            ),
            const Spacer(),
            IconButton(
              icon: FaIcon(
                notesProvider.isGrid
                    ? FontAwesomeIcons.tableCellsLarge
                    : FontAwesomeIcons.bars,
                size: 18,
              ),
              onPressed: () {
                notesProvider.toggleView();
              },
            ),
          ],
        ),
      ),
    );
  }
}
