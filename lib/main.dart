import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web_desktop_boilerplate/ui/SplashScreenUI.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    initializeSecondary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashScreenUI(),
    );
  }

  final String name = 'foo';
  final FirebaseOptions firebaseOptions = const FirebaseOptions(
    appId: '1:752442673795:android:a939be50e26e2f85afe9b6',
    apiKey: '',
    projectId: 'flutter-wdai',
    messagingSenderId: '752442673795',
  );

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  }

  Future<void> initializeSecondary() async {
    FirebaseApp app = await Firebase.initializeApp(name: name, options: firebaseOptions);

    assert(app != null);
    print('Initialized $app');
  }

  void apps() {
    final List<FirebaseApp> apps = Firebase.apps;
    print('Currently initialized apps: $apps');
  }

  void options() {
    final FirebaseApp app = Firebase.app(name);
    final FirebaseOptions options = app?.options;
    print('Current options for app $name: $options');
  }
}



/*class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(name: 'foo');
    assert(app != null);
    print('Initialized default app $app');
  }




}*/


