import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorappoimentadmin/widgets/DoctorList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../constants.dart';
import '../../entities/restaurant.dart';
import '../../widgets/HospitalList.dart';
import '../../widgets/category_icon_with_text.dart';
import '../../widgets/counter_with_text.dart';
import '../../widgets/custom_circle_button.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/restaurant_list.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double valueKm = 0;
  List<Doctor>? doctorList;

  @override
  void initState() {
    super.initState();
    getAllDoctorList();
  }

  Future<List<Doctor>> getAllDoctor() async {
    QuerySnapshot qShot =
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('doctor').get();
    // QuerySnapshot qShots =
    // await FirebaseFirestore.instance
    //     .collection("users").get();
    //  final allData = qShots.docs.map((doc) => doc.data()).toList();
    //  print(allData);
    try{
      var d=qShot.docs.map(
              (doc) => Doctor(
            id:doc['id'],
            description: doc['description'],
            name:doc['name'],
                  latitude:  doc['latitude'],
                  longitude: doc['longitude'],
            location:doc['location'],
            specialist: doc['specialist'],
            reviews: doc['reviews'],
            appoiment: doc['Appointment'],
                imageUrl: doc['image']
          )
      ).toList();
    }
    catch(e)
    {
      print(e);
    }
    return qShot.docs.map(
            (doc) => Doctor(
            id:doc['id'],
            imageUrl: "https:/",
            name:doc['name'],
              latitude:  doc['latitude'],
              longitude: doc['longitude'],
              description: doc['description'],
            location:doc['location'],
              specialist: doc['specialist'],
              reviews: doc['reviews'],
              appoiment: doc['Appointment'],)
    ).toList();
  }

  getAllDoctorList() async {
    await getAllDoctor().then((value) => doctorList=value);
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getAllDoctorList();
    return Scaffold(
      key: _scaffoldKey,
      drawer: new drawer_screen(),
      body: GestureDetector(
        onTap: () {
          //* ----------------------------------------------------
          //* This help to unfocus searchfield when click outside
          //* ----------------------------------------------------
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all( 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        (size.width < 900)
                            ? Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(45),
                          child: InkWell(
                            onTap: () {_scaffoldKey.currentState!.openDrawer();},
                            borderRadius: BorderRadius.circular(45),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              alignment: Alignment.center,
                              child: Icon(Icons.menu, color: Colors.white),
                            ),
                          ),
                        )
                            : Container(
                          width: 350,
                          child: TextField(
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              hintText: "Enter your search request...",
                              prefixIcon: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.search,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        // CustomCircleButton(
                        //   icon: FontAwesomeIcons.slidersH,
                        //   onTap: () {},
                        // ),
                        // const SizedBox(width: 10),
                        // CustomTextButton(
                        //   onTap: () {},
                        //   text: "Go to Premium",
                        // ),
                      ],
                    ),
                    //* ---------------------------------
                    //* ---------------------------------
                    //* ---------------------------------
                    const SizedBox(height: kdefaultPadding),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Find the best Doctor",
                              style: largestText,
                            ),
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(text: "249 Doctor, ",style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),),
                                  TextSpan(
                                    text: "choose yours",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        // if (size.width > 590) SpecialAndCategoriesCounter(),
                      ],
                    ),
                    // if (size.width <= 590) ...[
                    //   SizedBox(height: 30),
                    //   SpecialAndCategoriesCounter(),
                    // ],
                    //* --------------------------------------------
                    //* Categories Section
                    //* --------------------------------------------
                    //const SizedBox(height: 40),
                    //CategoryIconWithText(),
                    const SizedBox(height: 30),
                    //*------------------------------------------
                    //* New Restaurant Section
                    //*------------------------------------------
                    Row(
                      children: [
                        Text(
                          "New Doctor",
                          style: largeText,
                        ),
                        Spacer(),
                        // Slider(
                        //   divisions: 10,
                        //   value: valueKm,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       valueKm = value;
                        //     });
                        //   },
                        //   min: 0,
                        //   max: 10,
                        //   activeColor: Colors.black,
                        //   inactiveColor: Colors.black,
                        //   label: "$valueKm Km",
                        // ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              //* --------------------------------
              //* List of New Restaurant
              //* --------------------------------
              DoctorList(
                doctorList: (doctorList!=null && doctorList!.length>0)?doctorList! : cachedDoctorList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SpecialAndCategoriesCounter extends StatelessWidget {
//   const SpecialAndCategoriesCounter({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CounterWithText(number: 94, text: "Specials"),
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 20),
//           width: 1,
//           height: 50,
//           color: Colors.grey.shade300,
//         ),
//         CounterWithText(number: 23, text: "Doctor"),
//       ],
//     );
//   }
// }
