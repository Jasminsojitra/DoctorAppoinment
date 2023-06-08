import 'package:doctorappoimentadmin/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../entities/restaurant.dart';
import 'AddHospitalDialog.dart';

class HospitalList extends StatefulWidget {
  final List<Hospital> hospitaltList;

  const HospitalList({
    Key? key,
    required this.hospitaltList,
  }) : super(key: key);

  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20),
        height: 250,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: widget.hospitaltList.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Material(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.yellow.withOpacity(0.2),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddHospitalDialog();
                        },
                      ).then((value) => setState(() {

                      }));
                    },
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    child: Container(
                      height: 260,
                      width: 220,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 180,
                              child: AspectRatio(
                                aspectRatio: 1.8,
                                child: Image.asset(
                                  "assets/images/family_bean.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Add A Hospital!",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Share a hospital refrence that you like to everyone",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 45,
                              width: 45,
                              alignment: Alignment.center,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: HospitalCard(
                onTap: () {},
                backgroundColor:
                Colors.primaries[index % Colors.primaries.length],
                restaurant: widget.hospitaltList[index - 1],
              ),
            );
          },
        ),
      ),
    );
  }
}

// return Container(
//       margin: EdgeInsets.only(left: 60),
//       height: 260,
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: restaurantList.length + 1,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           if (index == 0) {
//             return Padding(
//               padding: const EdgeInsets.only(right: 30.0),
//               child: Material(
//                 borderRadius: BorderRadius.circular(
//                   10.0,
//                 ),
//                 color: Colors.yellow.withOpacity(0.2),
//                 child: InkWell(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return MyDialog();
//                       },
//                     );
//                   },
//                   borderRadius: BorderRadius.circular(
//                     10.0,
//                   ),
//                   child: Container(
//                     height: 260,
//                     width: 220,
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Container(
//                             width: 180,
//                             child: AspectRatio(
//                               aspectRatio: 1.8,
//                               child: Image.asset(
//                                 "assets/images/lureme.jpg",
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Text(
//                           "Add A Restaurant!",
//                           style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           "Share a restaurant that you like to everyone",
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.montserrat(
//                             fontSize: 10,
//                             color: Colors.grey.shade500,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Material(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(50),
//                           child: Container(
//                             height: 45,
//                             width: 45,
//                             alignment: Alignment.center,
//                             child: Icon(Icons.add),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.only(right: 30.0),
//             child: RestaurantCard(
//               onTap: () {},
//               backgroundColor:
//                   Colors.primaries[index % Colors.primaries.length],
//               restaurant: restaurantList[index - 1],
//             ),
//           );
//         },
//       ),
//     );