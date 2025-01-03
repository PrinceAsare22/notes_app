import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';

class MySearchField extends StatefulWidget {
  const MySearchField({super.key});

  @override
  _MySearchFieldState createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField> {
  late final NotesProvider notesProvider;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    notesProvider = context.read<NotesProvider>();
    searchController = TextEditingController()
      ..addListener(() {
        notesProvider.setSearchTerm(searchController.text);
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
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Search notes',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: isDark ? gray900 : white,
          suffixIcon: ListenableBuilder(
            listenable: searchController,
            builder: (context, clearButton) => searchController.text.isNotEmpty
                ? clearButton!
                : const SizedBox.shrink(),
            child: GestureDetector(
              onTap: () {
                searchController.clear();
              },
              child: const Icon(FontAwesomeIcons.xmark),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: primary,
            ),
          ),
        ),
      ),
    );
  }
}
