import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/main_page.dart';
import 'package:notes_app/pages/registration_page.dart';
import 'package:notes_app/services/auth_services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegistrationController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes 📙',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.light(
            primary: primary,
            surface: white,
            onSurface: gray900,
          ),
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          appBarTheme: const AppBarTheme(
            backgroundColor: background,
            titleTextStyle: TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
            primary: primary, // Dark background
            surface: gray900,
            onSurface: white,
          ),
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF121212),
            titleTextStyle: TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        themeMode: ThemeMode.system, // This will follow system settings
        home: StreamBuilder<User?>(
          stream: AuthServices.userStream,
          builder: (context, snapshot) {
            return snapshot.hasData && AuthServices.isEmailVerified
                ? const MainPage()
                : const RegistrationPage();
          },
        ),
      ),
    );
  }
}
