import 'package:doctorappoimentadmin/screens/home/hospital_screen.dart';
import 'package:doctorappoimentadmin/screens/sign_in/sign_in_screen.dart';
import 'package:doctorappoimentadmin/widgets/MyCustomScrollBehavior.dart';
import 'package:doctorappoimentadmin/widgets/side_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

int currentSelectedIndex = 0;
bool isHovered = false;
int? currentHoveredIndex;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
        GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
      ),
      // home: MainScreen(),
      home: SignInScreen(),
    );
  }

  Future<Widget> checkWhetherUserHaveJwtToken() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      return SignInScreen();
    } else {
      return HospitalScreen();
    }
  }
}



class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const ActionButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              text,
              style: normalText.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
