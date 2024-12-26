import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/constants.dart';
import 'package:provider/provider.dart';

class MySearchField extends StatefulWidget {
  const MySearchField({
    super.key,
  });

  @override
  State<MySearchField> createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> {
  late final NotesProvider notesProvider;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    notesProvider = context.read<NotesProvider>(); // Specify the type
    searchController = TextEditingController()
      ..addListener(() {
        notesProvider.searchTerm = searchController.text;
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10), // Add const
      child: TextField(
        controller: searchController, // Use the defined controller
        decoration: InputDecoration(
          hintText: 'Search notes...',
          hintStyle: const TextStyle(fontSize: 12, color: gray500),
          prefixIcon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: isDark ? white : black,
            size: 16, // Add appropriate size for the icon
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: searchController,
            builder: (context, value, child) {
              return Visibility(
                visible: value.text.isNotEmpty,
                child: GestureDetector(
                  onTap: () {
                    searchController.clear();
                  },
                  child: Icon(
                    FontAwesomeIcons.xmark,
                    color: isDark ? white : black,
                    size: 16, // Add appropriate size for the icon
                  ),
                ),
              );
            },
          ),
          fillColor: theme.colorScheme.surface,
          filled: true,
          isDense: true,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 42, minHeight: 42),
          suffixIconConstraints:
              const BoxConstraints(minWidth: 42, minHeight: 42),
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: primary),
          ),
        ),
      ),
    );
  }
}
