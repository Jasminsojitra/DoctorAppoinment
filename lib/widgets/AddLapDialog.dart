import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import '../constants.dart';
import '../entities/menu.dart';
import '../entities/restaurant.dart';
import '../service/restaurant_service_contract.dart';
import 'custom_text_button.dart';
import 'form_title_and_field.dart';

class AddLapDialog extends StatefulWidget {
  final String? type;
  const AddLapDialog({Key? key,this.type}) : super(key: key);

  @override
  _AddLapDialogState createState() => _AddLapDialogState();
}

class _AddLapDialogState extends State<AddLapDialog> {
  String? name;
  String? latitude;
  String? longitude;
  String? department;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();



  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var rng = Random();
  FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;
  bool isSelectedImage=false;

  /// Get from Camera
  _getFromCamera() async {
    Navigator.pop(context);
    var pickedFile = await _picker.pickImage(source: ImageSource.camera,maxWidth: 1800,
      maxHeight: 1800,);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        isSelectedImage=true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // getLocation()async{
  //   var p=await _determinePosition();
  //   print(p.latitude.toString()+"long: "+p.longitude.toString() );
  //   print(p);
  //   List<Placemark> placemarks = await placemarkFromCoordinates(p.latitude, p.longitude);
  //   var d=placemarks.first;
  //   var add=d.name;
  //   locationController.text=add.toString();
  //   location=locationController.text;
  //   setState(() {
  //   });
  //   print(placemarks.first);
  // }

  String dropdownvalue = items[0];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Form(
          key: formKey,
          child: Container(
            width: 750,
            // height: 700,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add ${widget.type}",
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: kdefaultPadding),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: nameController,
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    name = value;
                                  },
                                  title: "Name",
                                  hintText: "Enter a name",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "SubCategory",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          setState(() {
                                            latitude = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          latitude = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        controller: latitudeController,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                        ),keyboardType: TextInputType.text,
                                        decoration: InputDecoration(

                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            hintText: "Enter a latitude",
                                            suffixStyle:
                                            GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Image",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          setState(() {
                                            longitude = value;
                                          });
                                        },
                                        onSaved: (value) {
                                          longitude = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        controller: longitudeController,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                        ),
                                        decoration: InputDecoration(
                                          // suffixIcon: GestureDetector(
                                          //   onTap: (){
                                          //     getLocation();
                                          //   },
                                          //   child: Padding(
                                          //     padding: EdgeInsets.all(0.0),
                                          //     child: Icon(
                                          //       Icons.location_searching_sharp,
                                          //       color: Colors.grey,
                                          //     ), // icon is 48px widget.
                                          //   ),
                                          // ),
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            hintText: "Enter a longitude",
                                            suffixStyle:
                                            GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          text: "Submit",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              Loader(context);
                              print("doc");
                              //List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(latitude.toString()) , double.parse(longitude.toString()));
                              if(widget.type=="category") {
                                CollectionReference hospital = FirebaseFirestore.instance
                                    .collection('conversion')
                                    .doc("CaR0p64r6NvFCtKWQmg1").collection(
                                    'category');
                                var id = hospital
                                    .doc()
                                    .id;
                                print("doc id:" + "${hospital
                                    .doc()
                                    .id}");
                                print("id:" + "${hospital.id}");

                                var imgValue;
                                hospital.doc(id).set({
                                  "id": id,
                                  "name": name,
                                  "subcategory": latitude,
                                  "image": longitude,
                                }).then((value) async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ShowSuccessToast('Added Succesfully');
                                  print("done");
                                });
                                //CollectionReference hospital = FirebaseFirestore.instance.collection('hospital');
                                //FirebaseFirestore.instance.collection('hospital').doc()
                              }
                              else{
                                CollectionReference hospital= FirebaseFirestore.instance
                                    .collection('conversion')
                                    .doc("CaR0p64r6NvFCtKWQmg1")
                                    .collection('category')
                                    .doc("att6cyxRcnxLcbqM9XMl")
                                    .collection('topic');

                                var id = hospital
                                    .doc()
                                    .id;
                                print("doc id:" + "${hospital
                                    .doc()
                                    .id}");
                                print("id:" + "${hospital.id}");

                                var imgValue;
                                hospital.doc(id).set({
                                  "id": id,
                                  "name": name,
                                  "subcategory": latitude,
                                  "image": longitude,
                                }).then((value) async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ShowSuccessToast('Added Succesfully');
                                  print("done");
                                });
                              }
                            } else {
                              ShowSuccessToast('Add all details');
                              print("fill in all");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      ShowSuccessToast('Enable Location services');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}