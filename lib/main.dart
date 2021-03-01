import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try {
    Data.getUid();
    if (FirebaseAuth.instance.currentUser.emailVerified == false) {
      Data.showToast('Please Verify your E-Mail Address');
      Data.start = Login();
    } else {
      // Data.showToast('wait while we Logging you in...');
      // Data.start = HomeScreen();
    }
  } catch (e) {
    Data.start = Login();
  }
  runApp(MyApp());
}

// Map<int, Color> color = {
//   50: Color.fromRGBO(47, 25, 112, .1),
//   100: Color.fromRGBO(47, 25, 112, .2),
//   200: Color.fromRGBO(47, 25, 112, .3),
//   300: Color.fromRGBO(47, 25, 112, .4),
//   400: Color.fromRGBO(47, 25, 112, .5),
//   500: Color.fromRGBO(47, 25, 112, .6),
//   600: Color.fromRGBO(47, 25, 112, .7),
//   700: Color.fromRGBO(47, 25, 112, .8),
//   800: Color.fromRGBO(47, 25, 112, .9),
//   900: Color.fromRGBO(47, 25, 112, 1),
// };
// MaterialColor colorCustom = MaterialColor(0xFF2F1970, color);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BRTS ONLINE',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      initialRoute: '/', //this is an starting point of our application
      routes: routes, //all routes are stored in file 'Data.dart'
    );
  }
}
