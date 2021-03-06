import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/authentication.dart';
import 'package:flutter_note_app/screens/add_note_screen.dart';
import 'package:flutter_note_app/screens/dashboard_screen.dart';
import 'package:flutter_note_app/screens/register_screen.dart';
import 'package:flutter_note_app/screens/splash_screen.dart';
import 'package:flutter_note_app/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/note_queries.dart';
import 'models/notes.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthQueries>(
          create: (_) => AuthQueries(),
        ),
        Provider<NoteStore>(
          create: (_) => NoteStore(),
        ),
        StreamProvider(
          create: (_) => AuthQueries().isAuthenticated,
          initialData: null,
        ),
        StreamProvider<List<Note>>(
          create: (_) => NoteStore().getNotes,
          initialData: const [],
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/register': (context) => const RegisterScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const Dashboard(),
          '/add_note': (context) =>
              const AddNoteScreen(body: '', head: '', type: ''),
          '/wrapper': (context) => const Wrapper(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
