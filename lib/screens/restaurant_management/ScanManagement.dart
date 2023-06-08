import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../constants.dart';
import '../../entities/restaurant.dart';
import '../../main.dart';
import '../home/drawer_screen.dart';
import 'custom_dialog.dart';
import 'edit_dialog.dart';

class ScanManagement extends StatefulWidget {
  const ScanManagement() : super();

  @override
  _ScanManagementState createState() => _ScanManagementState();
}

class _ScanManagementState extends State<ScanManagement> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('scan').snapshots();
    Size size = MediaQuery.of(context).size;
    print(MediaQuery.of(context).size.width);
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawer_screen(),
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          decoration: BoxDecoration(color: Colors.white),
          child: Padding(
              padding: const EdgeInsets.all( 15.0),child:
          ListView(
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
              const SizedBox(height: kdefaultPadding),
              Text(
                "Scan Center Management",
                style: largestText,
              ),
              const SizedBox(height: kdefaultPadding),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _usersStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(width: size.width,height: size.height/2,
                              child: Center(child: CircularProgressIndicator()));
                        }
                        return
                          DataTable(
                            columnSpacing: 10,
                            rows: [
                              ...snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Container(
                                        width: 100,
                                        child: Text(
                                          data['name'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        width: 160,
                                        child: Text(
                                          data['location'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        width: 160,
                                        child: Text(
                                          data['department'],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          ActionButton(
                                            text: "View",
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (contexts) {
                                                  return CustomDialogHospital(
                                                    hospital: Hospital(
                                                        name: data['name'],
                                                        latitude:  data['latitude'],
                                                        longitude: data['longitude'],
                                                        department: data['department'],
                                                        location: data['location'],
                                                        imageUrl: data['image']
                                                    ),
                                                    dialogTitle: "Scan Center Details",
                                                    buttonText: "Confirm",
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            color: Colors.blue,
                                          ),
                                          ActionButton(
                                            text: "Edit",
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return EditDialogHospital(
                                                    hospital: Hospital(
                                                        id:data['id'],
                                                        name: data['name'],
                                                        latitude:  data['latitude'],
                                                        longitude: data['longitude'],
                                                        department: data['department'],
                                                        location: data['location'],
                                                        imageUrl: data['image']
                                                    ),
                                                    type: "scan",
                                                  );
                                                },
                                              );
                                            },
                                            color: Colors.green[400]!,
                                          ),
                                          ActionButton(
                                            text: "Delete",
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CustomDialogHospital(
                                                    hospital: Hospital(
                                                        id:data['id'],
                                                        name: data['name'],
                                                        department: data['department'],
                                                        latitude:  data['latitude'],
                                                        longitude: data['longitude'],
                                                        location: data['location'],
                                                        imageUrl:data['image']
                                                    ),
                                                    dialogTitle: "Delete Scan Center",
                                                    buttonText: "Delete",
                                                    onTap: () {
                                                      FirebaseStorage.instance.refFromURL(data['image']).delete().then((value){
                                                        print("Deleted Image");
                                                      });
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(FirebaseAuth.instance.currentUser!.uid)
                                                          .collection('scan')
                                                          .doc(data['id']).delete().then((result){//pop dialog
                                                        ShowSuccessToast('Succesfully Deleted');

                                                        Navigator.pop(context);
                                                      });

                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              })
                            ],
                            dataRowHeight: 70,
                            columns: [
                              ...tableTitle
                                  .map(
                                    (title) =>
                                    DataColumn(
                                      label: Text(
                                        title,
                                        style: largeText.copyWith(fontSize: 18),
                                      ),
                                    ),
                              )
                                  .toList(),
                              DataColumn(
                                label: Text(
                                  "Actions",
                                  style: largeText.copyWith(fontSize: 18),
                                ),
                                onSort: (columnIndex, ascending) {},
                              ),
                            ],
                          );
                        //   ListView(
                        //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        //     return
                        //       DataTable(
                        //         rows: [
                        //           DataRow(
                        //             cells: [
                        //               DataCell(
                        //                 Text(
                        //                   data['name'],
                        //                   maxLines: 3,
                        //                   overflow: TextOverflow.ellipsis,
                        //                 ),
                        //               ),
                        //               DataCell(
                        //                 Text(
                        //                   data['location'],
                        //                   maxLines: 3,
                        //                   overflow: TextOverflow.ellipsis,
                        //                 ),
                        //               ),
                        //               DataCell(
                        //                 Text(
                        //                   data['department'],
                        //                   maxLines: 3,
                        //                   overflow: TextOverflow.ellipsis,
                        //                 ),
                        //               ),
                        //               DataCell(
                        //                 Row(
                        //                   children: [
                        //                     ActionButton(
                        //                       text: "View",
                        //                       onTap: () {
                        //                         // showDialog(
                        //                         //   context: context,
                        //                         //   builder: (context) {
                        //                         //     return CustomDialog(
                        //                         //       restaurant: restaurant,
                        //                         //       dialogTitle: "Restaurant Details",
                        //                         //       buttonText: "Confirm",
                        //                         //       onTap: () {
                        //                         //         Navigator.pop(context);
                        //                         //       },
                        //                         //     );
                        //                         //   },
                        //                         // );
                        //                       },
                        //                       color: Colors.blue,
                        //                     ),
                        //                     ActionButton(
                        //                       text: "Edit",
                        //                       onTap: () async {
                        //                         // await showDialog(
                        //                         //   context: context,
                        //                         //   builder: (context) {
                        //                         //     return EditDialog(
                        //                         //       restaurant: restaurant,
                        //                         //     );
                        //                         //   },
                        //                         // );
                        //                       },
                        //                       color: Colors.green[400]!,
                        //                     ),
                        //                     ActionButton(
                        //                       text: "Delete",
                        //                       onTap: () {
                        //                         // showDialog(
                        //                         //   context: context,
                        //                         //   builder: (context) {
                        //                         //     return CustomDialog(
                        //                         //       restaurant: restaurant,
                        //                         //       dialogTitle: "Delete Restaurant",
                        //                         //       buttonText: "Delete",
                        //                         //       onTap: () {
                        //                         //         restaurantService.deleteRestaurant(
                        //                         //             restaurant.id!);
                        //                         //         Navigator.pop(context);
                        //                         //       },
                        //                         //     );
                        //                         //   },
                        //                         // );
                        //                       },
                        //                       color: Colors.red,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ],
                        //           )
                        //         ], dataRowHeight: 70,
                        //         columns: [
                        //           ...tableTitle
                        //               .map(
                        //                 (title) => DataColumn(
                        //               label: Text(
                        //                 title,
                        //                 style: largeText.copyWith(fontSize: 18),
                        //               ),
                        //             ),
                        //           )
                        //               .toList(),
                        //           DataColumn(
                        //             label: Text(
                        //               "Actions",
                        //               style: largeText.copyWith(fontSize: 18),
                        //             ),
                        //             onSort: (columnIndex, ascending) {},
                        //           ),
                        //         ],
                        //       );
                        //     //   ListTile(
                        //     //   title: Text(data['full_name']),
                        //     //   subtitle: Text(data['company']),
                        //     // );
                        //   }).toList(),
                        // );
                      },
                    ),
                  ))
            ],
          )
          ),
        ));
  }
}
