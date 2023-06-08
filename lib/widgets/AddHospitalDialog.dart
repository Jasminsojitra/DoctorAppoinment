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

class AddHospitalDialog extends StatefulWidget {
  const AddHospitalDialog({Key? key}) : super(key: key);

  @override
  _AddHospitalDialogState createState() => _AddHospitalDialogState();
}

class _AddHospitalDialogState extends State<AddHospitalDialog> {
  String? name;
  String? latitude;
  String? longitude;
  String? department;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();



  _getFromGallery() async {
    try{
      //Navigator.pop(context);
      var pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          isSelectedImage=true;
        });
        //Navigator.pop(context);
      }
      else{
        isSelectedImage=false;
        setState(() {

        });
      }
      //uploadImageToFirebase();
    }
    catch(ex){

      print(ex);
    }
  }
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
                        "Add Conversion",
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
                                  title: "Title",
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
                                // Text(
                                //   "Department",
                                //   style: GoogleFonts.montserrat(
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // DropdownButton(
                                //   underline: Container(
                                //     color: Colors.black26,
                                //     height: 1,
                                //   ),
                                //   isExpanded: true,
                                //   // Initial Value
                                //   value: dropdownvalue,
                                //   // Down Arrow Icon
                                //   icon: const Icon(Icons.keyboard_arrow_down),
                                //
                                //   // Array list of items
                                //   items: items.map((String items) {
                                //     return DropdownMenuItem(
                                //       value: items,
                                //       child: Text(items,style: GoogleFonts.montserrat(
                                //         fontSize: 14,
                                //       ),),
                                //     );
                                //   }).toList(),
                                //   // After selecting the desired option,it will
                                //   // change button value to selected value
                                //   onChanged: (String? newValue) {
                                //     setState(() {
                                //       dropdownvalue = newValue!;
                                //     });
                                //   },
                                // ),
                                // FormTitleAndField(
                                //   validate: (value) {
                                //     if (value == null || value.isEmpty) {
                                //       return 'Please enter some text';
                                //     }
                                //     return null;
                                //   },
                                //   textEditingController: departmentController,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       department = value;
                                //     });
                                //   },
                                //   onSaved: (value) {
                                //     name = value;
                                //   },
                                //   title: "Department",
                                //   hintText: "OT,ICU...",
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 20),
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         "Image",
                                //         style: GoogleFonts.montserrat(
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //       const SizedBox(height: 10),
                                //       Row(
                                //         children: [
                                //           Material(
                                //             borderRadius: BorderRadius.circular(12),
                                //             color: Colors.grey[400],
                                //             child: InkWell(
                                //               borderRadius: BorderRadius.circular(12),
                                //               onTap: () {
                                //                 _getFromGallery();
                                //                 if (isSelectedImage == true) {
                                //                   setState(() {
                                //                     isSelectedImage = false;
                                //                   });
                                //                 }
                                //               },
                                //               child: Container(
                                //                 padding: EdgeInsets.symmetric(
                                //                     horizontal: 20, vertical: 10),
                                //                 child: Text(
                                //                   "Select a file",
                                //                   style: TextStyle(fontSize: 14),
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //           const SizedBox(width: 20),
                                //           imageFile == null
                                //               ? Text(
                                //             "No File Chosen",
                                //             style: TextStyle(fontSize: 14),
                                //           )
                                //               : Expanded(
                                //             child: Ink.image(
                                //               image: FileImage(imageFile!),
                                //               fit: BoxFit.cover,
                                //               height: 100,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       (!isSelectedImage)
                                //           ? Padding(
                                //         padding: const EdgeInsets.only(top: 10),
                                //         child: Text(
                                //           "Please select a file",
                                //           style: TextStyle(
                                //               fontSize: 12.5, color: Colors.red[700]),
                                //         ),
                                //       )
                                //           : SizedBox.shrink(),
                                //     ],
                                //   ),
                                // ),
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
                              CollectionReference hospital= FirebaseFirestore.instance
                                  .collection('conversion');
                              var id=hospital.doc().id;
                              print("doc id:"+"${hospital.doc().id}");
                              print("id:"+"${hospital.id}");
                              //Reference ref =firebaseStorageRef.ref().child('upload/${rng.nextInt(1000)}');
                              //UploadTask uploadTask = ref.putFile(imageFile!);
                              var imgValue;
                              hospital.doc(id).set({
                                "id":id,
                                "title": name,
                                "subcategory": latitude,
                                "image":longitude,

                              }).then((value)async{

                                Navigator.pop(context);
                                Navigator.pop(context);
                                ShowSuccessToast('Added Succesfully');
                                setState(() {

                                });
                                print("done");
                              });
                               //CollectionReference hospital = FirebaseFirestore.instance.collection('hospital');
                              //FirebaseFirestore.instance.collection('hospital').doc()


                            } else {

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


class AddDoctorDialog extends StatefulWidget {
  const AddDoctorDialog({Key? key}) : super(key: key);

  @override
  _AddDoctorDialogState createState() => _AddDoctorDialogState();
}

class _AddDoctorDialogState extends State<AddDoctorDialog> {
  var _fileBytes;
  String? name;
  String? latitude;
  String? longitude;
  String? description;
  String? specialist;
  String? reviews;
  String? Appointment;


  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showSelectFileMessage = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController specialistController = TextEditingController();
  TextEditingController reviewsController = TextEditingController();
  TextEditingController appoimentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getFromGallery() async {
    try{
      //Navigator.pop(context);
      var pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          isSelectedImage=true;
        });
        //Navigator.pop(context);
      }
      else{
        isSelectedImage=false;
        setState(() {

        });
      }
      //uploadImageToFirebase();
    }
    catch(ex){

      print(ex);
    }
  }
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var rng = Random();
  FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;
  bool isSelectedImage=false;

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
                        "Add Doctor",
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
                                      // Text(
                                      //   "Location",
                                      //   style: GoogleFonts.montserrat(
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      // TextFormField(
                                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       location = value;
                                      //     });
                                      //   },
                                      //   onSaved: (value) {
                                      //     location = value;
                                      //   },
                                      //   validator: (value) {
                                      //     if (value == null || value.isEmpty) {
                                      //       return 'Please enter location';
                                      //     }
                                      //     return null;
                                      //   },
                                      //   controller: locationController,
                                      //   style: GoogleFonts.montserrat(
                                      //     fontSize: 14,
                                      //   ),
                                      //   decoration: InputDecoration(
                                      //       suffixIcon: GestureDetector(
                                      //         onTap: (){
                                      //           getLocation();
                                      //         },
                                      //         child: Padding(
                                      //           padding: EdgeInsets.all(0.0),
                                      //           child: Icon(
                                      //             Icons.location_searching_sharp,
                                      //             color: Colors.grey,
                                      //           ), // icon is 48px widget.
                                      //         ),
                                      //       ),
                                      //       floatingLabelBehavior: FloatingLabelBehavior.always,
                                      //       hintText: "Enter a location",
                                      //       suffixStyle:
                                      //       GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Latitude",
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
                                              ),keyboardType: TextInputType.number,
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
                                              "Longitude",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextFormField(
                                              keyboardType: TextInputType.number,
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
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: descriptionController,
                                  onChanged: (value) {
                                    setState(() {
                                      description = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    description = value;
                                  },
                                  title: "Description",
                                  hintText: "Details...",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: specialistController,
                                  onChanged: (value) {
                                    setState(() {
                                      specialist = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    specialist = value;
                                  },
                                  title: "Specialist",
                                  hintText: "specialist...",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: reviewsController,
                                  onChanged: (value) {
                                    setState(() {
                                      reviews = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    reviews = value;
                                  },
                                  title: "Reviews",
                                  hintText: "reviews...",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: appoimentController,
                                  onChanged: (value) {
                                    setState(() {
                                      Appointment = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    Appointment = value;
                                  },
                                  title: "Appointment",
                                  hintText: "appointment...",
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
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Material(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.grey[400],
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(12),
                                              onTap: () {
                                                _getFromGallery();
                                                if (isSelectedImage == true) {
                                                  setState(() {
                                                    isSelectedImage = false;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                child: Text(
                                                  "Select a file",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          imageFile == null
                                              ? Text(
                                            "No File Chosen",
                                            style: TextStyle(fontSize: 14),
                                          )
                                              : Expanded(
                                            child: Ink.image(
                                              image: FileImage(imageFile!),
                                              fit: BoxFit.cover,
                                              height: 100,
                                            ),
                                          ),
                                        ],
                                      ),
                                      (!isSelectedImage)
                                          ? Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          "Please select a file",
                                          style: TextStyle(
                                              fontSize: 12.5, color: Colors.red[700]),
                                        ),
                                      )
                                          : SizedBox.shrink(),
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
                              List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(latitude.toString()) , double.parse(longitude.toString()));

                              CollectionReference hospital= FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('doctor');
                              var id=hospital.doc().id;
                              print("doc id:"+"${hospital.doc().id}");
                              print("id:"+"${hospital.id}");
                              //CollectionReference hospital = FirebaseFirestore.instance.collection('hospital');
                              //FirebaseFirestore.instance.collection('hospital').doc()

                              Reference ref =firebaseStorageRef.ref().child('upload/${rng.nextInt(1000)}');
                              UploadTask uploadTask = ref.putFile(imageFile!);
                              var imgValue;
                              uploadTask.then((res) {res.ref.getDownloadURL().then((value) {
                                imgValue = value;
                                print(imgValue);
                                hospital.doc(id).set({
                                  "id":id,
                                  "name": name,
                                  "latitude": latitude,
                                  "longitude":longitude,
                                  "location":placemarks.first.name,
                                  "description":description,
                                  "specialist":specialist,
                                  "reviews":reviews,
                                  "Appointment":Appointment,
                                  "image":imgValue
                                }).then((value)async{
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ShowSuccessToast('Added Succesfully');
                                  print("done");
                                });
                              });});

                            } else {
                              setState(() {
                                showSelectFileMessage = true;
                              });
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


String parseToDouble(String value) {
  num number = num.parse(value);
  return number.toStringAsFixed(1);
}

Hospital resObject = Hospital(
  imageUrl: "assets/images/family_bean.jpg",
  name: "BAPS Pramukh Swami Hospital",
  latitude: "21.196102",
  longitude: "72.815766",
  location: "Surat",
  department: "Pharmacy",
);
