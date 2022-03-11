import 'package:contacts_app/models/contacts.dart';
import 'package:contacts_app/pages/add_contacts_page.dart';
import 'package:contacts_app/services/authentication_service.dart';
import 'package:contacts_app/services/upload_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/sign_in_page.dart';
import 'services/download_service.dart';

Future<void> main() async {
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
        ChangeNotifierProvider<AuthenticationService>(
            create: (context) => AuthenticationService(FirebaseAuth.instance)),
        Provider<UploadService>(create: (context) => UploadService()),
        Provider<DownloadService>(create: (context) => DownloadService()),
        Provider<Contact>(
          create: (context) => Contact(),
        ),
        StreamProvider<User?>(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // fontFamily:
        ),
        home: Consumer<User?>(builder: (context, value, child) {
          final firebaseUser = context.watch<User?>();
          if (firebaseUser != null) {
            return const AddContacts();
          } else {
            return const SignIn();
          }
        }),
      ),
    );
  }
}
