// Expanded(
//             child: StreamBuilder<List<Note>>(
//               stream: notesService.getUserNotes(userId),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator(color: Colors.amber));
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 final notes = snapshot.data ?? [];

//                 if (notes.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       'No notes yet',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   padding: EdgeInsets.all(16),
//                   itemCount: notes.length,
//                   itemBuilder: (context, index) {
//                     final note = notes[index];
//                     return NoteTile(note: note);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),




//       if (notes.isNotEmpty) ...[
//                         const ViewOptions(),
//                         Expanded(
//                           child: notesProvider.isGrid
//                               ? NotesGrid(notes: notes)
//                               : NotesList(notes: notes),
//                         ),
//                       ] else
//                         const Expanded(
//                           child: Center(
//                             child: Text(
//                               'No notes found for your search query!',
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         )