import 'package:doctorappoimentadmin/screens/home/home_screen.dart';
import 'package:doctorappoimentadmin/screens/home/scan_screen.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../entities/menu.dart';
import '../../main.dart';
import '../../widgets/menu_item.dart' as m;
import '../restaurant_management/LapManagement.dart';
import '../restaurant_management/ScanManagement.dart';
import '../restaurant_management/doctorManagment.dart';
import '../restaurant_management/hospitalManagment.dart';
import '../restaurant_management/restaurant_management.dart';
import 'hospital_screen.dart';
import 'lap_screen.dart';

class drawer_screen extends StatefulWidget {
  const drawer_screen({Key? key}) : super(key: key);

  @override
  State<drawer_screen> createState() => _drawer_screenState();
}

class _drawer_screenState extends State<drawer_screen> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            // const SizedBox(height: 30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "I",
            //       style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white),
            //     ),
            //     const SizedBox(width: 5),
            //     Icon(
            //       Icons.favorite,
            //       color: Colors.white,
            //       size: 18,
            //     ),
            //     const SizedBox(width: 5),
            //     Text(
            //       "Food",
            //       style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 50),
            Container(
              height: 60,
              width: 60,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.purple,
                    Colors.pink,
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/Joaquin_Phoenix.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Welcome",
              style: TextStyle(color: kGreyColor),
            ),
            const SizedBox(height: 10),
            Text(
              "John Miles",
              style: TextStyle(
                  color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 25),
            ...menuList
                .asMap()
                .map((index, item) => MapEntry(
                index,
                m.MenuItem(
                  text: item.title,
                  icon: item.icon,
                  onTap: () {
                    currentSelectedIndex = index;
                    switch (currentSelectedIndex) {
                      case 0:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalScreen(),
                            ));
                        break;
                      case 1:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => hospitalManagement(),
                            ));
                        break;
                      case 2:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                        break;
                      case 3:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => doctorManagement(),
                            ));
                        break;
                        //lap
                      case 4:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LapScreen(),
                            ));
                        break;
                      case 5:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LapManagement(),
                            ));
                        break;
                      case 6:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanScreen(),
                            ));
                        break;
                      case 7:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanManagement(),
                            ));
                        break;
                      default:
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HospitalScreen(),
                            ));
                    }

                    // setState(() {
                    //   currentSelectedIndex = index;
                    //   context
                    //       .read<PageBloc>()
                    //       .add(ChangePageEvent(index: currentSelectedIndex));
                    // });
                    //Navigator.pop(context);
                  },
                  isSeleted: index == currentSelectedIndex,
                  onHover: (value) {
                    if (value) {
                      setState(() {
                        currentHoveredIndex = index;
                      });
                    } else {
                      setState(() {
                        currentHoveredIndex = null;
                      });
                    }
                  },
                  isHovered: currentHoveredIndex == index,
                )))
                .values
                .toList(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
