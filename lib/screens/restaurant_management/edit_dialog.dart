import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;

import '../../constants.dart';
import '../../entities/menu.dart';
import '../../entities/restaurant.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/form_title_and_field.dart';
import '../../widgets/restaurant_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom_dialog.dart';
class EditDialog extends StatefulWidget {
  final Restaurant? restaurant;

  const EditDialog({Key? key, this.restaurant}) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {

  String? name;
  String? category;
  String? rating;
  String? price;
  String? distance;
  String? image;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showSelectFileMessage = false;
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController ratingController;
  late TextEditingController priceController;
  late TextEditingController distanceController;

  Future<void> _pickImage() async {


  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    categoryController = TextEditingController();
    ratingController = TextEditingController();
    priceController = TextEditingController();
    distanceController = TextEditingController();
    if (widget.restaurant != null) {
      //* ---------------------------------
      //* Assign restaurant properties value
      //* ---------------------------------
      name = widget.restaurant?.name;
      category = widget.restaurant?.resType;
      rating = widget.restaurant?.rating;
      price = widget.restaurant?.price;
      distance = widget.restaurant?.distance;
      image = widget.restaurant?.imageUrl;

      //* ---------------------------------------
      //* Assign textfield with the default value
      //* ---------------------------------------

      nameController.text = name!;
      categoryController.text = category!;
      ratingController.text = rating!;
      priceController.text = price!;
      distanceController.text = distance!;
    }
  }

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
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update Restaurant",
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
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: categoryController,
                                  onChanged: (value) {
                                    setState(() {
                                      category = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    category = value;
                                  },
                                  title: "Category",
                                  hintText: "Cafe / Bars / Asian ...",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: ratingController,
                                  onChanged: (value) {
                                    setState(() {
                                      rating = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    rating = value;
                                  },
                                  title: "Rating",
                                  hintText: "Rate the restaurant ! (0 - 5)",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: priceController,
                                  onChanged: (value) {
                                    setState(() {
                                      price = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    price = value;
                                  },
                                  title: "Price",
                                  hintText:
                                      "Enter the average food price of the restaurant",
                                ),
                                FormTitleAndField(
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textEditingController: distanceController,
                                  onChanged: (value) {
                                    setState(() {
                                      distance = value;
                                    });
                                  },
                                  onSaved: (value) {
                                    distance = value;
                                  },
                                  title: "Distance",
                                  hintText: "Enter the distance",
                                  suffixText: "km",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),
                          Material(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                            color: Colors.pink.withOpacity(0.2),
                            child: Container(
                              height: 275,
                              width: 220,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [

                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        (name == null || name == "")
                                            ? cachedRestaurantList[0].name
                                            : name!,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        (category == null || category == "")
                                            ? cachedRestaurantList[0].resType
                                            : category!,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 50,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                (rating == null || rating == "")
                                                    ? cachedRestaurantList[0]
                                                        .rating
                                                    : rating!,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          CustomDivider(height: 40),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  CurrencyIcon(size: 10),
                                                  CurrencyIcon(
                                                      size: 10,
                                                      color:
                                                          Colors.grey.shade600),
                                                  CurrencyIcon(
                                                      size: 10,
                                                      color:
                                                          Colors.grey.shade600),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                (price == null || price == "")
                                                    ? cachedRestaurantList[0]
                                                        .price
                                                    : price!,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          CustomDivider(height: 40),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "km",
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                (distance == null ||
                                                        distance == "")
                                                    ? cachedRestaurantList[0]
                                                        .distance
                                                    : distance!,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                                _pickImage();
                                if (showSelectFileMessage == true) {
                                  setState(() {
                                    showSelectFileMessage = false;
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

                        ],
                      ),
                      (showSelectFileMessage)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Please select a file",
                                style: TextStyle(
                                    fontSize: 12.5, color: Colors.red[700]),
                              ),
                            )
                          : SizedBox.shrink(),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          text: "Update",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              Restaurant restaurant = Restaurant(
                                imageUrl: image!,
                                name: name!,
                                resType: category!,
                                rating: rating!,
                                price: price!,
                                distance: distance!,
                              );

                              Navigator.pop(context);
                            } else {
                              // setState(() {
                              //   showSelectFileMessage = true;
                              // });
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
}


class EditDialogHospital extends StatefulWidget {
  final Hospital? hospital;
  final String? type;

  const EditDialogHospital({Key? key, this.hospital,this.type}) : super(key: key);

  @override
  _EditDialogHospitalState createState() => _EditDialogHospitalState();
}

class _EditDialogHospitalState extends State<EditDialogHospital> {

  String? image;
  String? OriginalUrl;
  String? id;
  String? name;
  String? latitude;
  String? longitude;
  String? department;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showSelectFileMessage = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
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
  // getLocation()async{
  //   var p=await determinePosition();
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
  void initState() {
    super.initState();
    if (widget.hospital != null) {
      //* ---------------------------------
      //* Assign restaurant properties value
      //* ---------------------------------
      id=widget.hospital?.id;
      name = widget.hospital?.name;
      //location = widget.hospital?.location;
      latitude= widget.hospital?.latitude;
      longitude= widget.hospital?.longitude;
      department = widget.hospital?.department;
      image= widget.hospital?.imageUrl;
      OriginalUrl=widget.hospital?.imageUrl;
      //* ---------------------------------------
      //* Assign textfield with the default value
      //* ---------------------------------------
      nameController.text = name!;
      latitudeController.text = latitude!;
      longitudeController.text = longitude!;
      //departmentController.text = department!;
    }
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
          image=null;
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
                        "Update ${widget.type}",
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
                                Text(
                                  "Department",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButton(
                                  underline: Container(
                                    color: Colors.black26,
                                    height: 1,
                                  ),
                                  isExpanded: true,
                                  // Initial Value
                                  value: department,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                      ),),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      department = newValue!;
                                    });
                                  },
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
                                          (imageFile == null&&image==null)
                                              ? Text(
                                            "No File Chosen",
                                            style: TextStyle(fontSize: 14),
                                          )
                                              : Expanded(
                                                child: Container(
                                            decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey)
                                            ),
                                            child: image == null?Ink.image(
                                                image: FileImage(imageFile!),
                                                fit: BoxFit.cover,
                                                height: 120,
                                            ):CachedNetworkImage(
                                              placeholder: (context, url) => imageLoader(),
                                                height: 120,
                                                imageUrl: image.toString(),
                                                fit: BoxFit.cover,
                                                errorWidget: (context, url, error) => Image.asset(
                                                  "assets/images/family_bean.jpg",
                                                  fit: BoxFit.cover,
                                                ),
                                            ),
                                          ),
                                              ),
                                        ],
                                      ),
                                      (!isSelectedImage&&image==null)
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
                          text: "Update",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(latitude.toString()) , double.parse(longitude.toString()));

                              if(isSelectedImage){
                                Reference ref =firebaseStorageRef.ref().child('upload/${rng.nextInt(1000)}');
                                UploadTask uploadTask = ref.putFile(imageFile!);
                                uploadTask.then((res) {res.ref.getDownloadURL().then((value) {
                                var imgValue = value;
                                FirebaseStorage.instance.refFromURL(OriginalUrl.toString()).delete().then((value){
                                  print("Old image Deleted Image");
                                });
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('${widget.type}')
                                    .doc(id).update({
                                  "name": name,
                                  "latitude": latitude,
                                  "longitude":longitude,
                                  "location":placemarks.first.name,
                                  "department":department,
                                  "image":imgValue
                                }).then((result){//pop dialog
                                  Navigator.pop(context);
                                  ShowSuccessToast("Edited Succesfully");
                                });
                                });});
                              }else{
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('${widget.type}')
                                    .doc(id).update({
                                  "name": name,
                                  "latitude": latitude,
                                  "longitude":longitude,
                                  "location":placemarks.first.name,
                                  "department":department,
                                }).then((result){//pop dialog
                                  Navigator.pop(context);
                                  ShowSuccessToast("Edited Succesfully");
                                });
                              }


                            } else {
                              // setState(() {
                              //   showSelectFileMessage = true;
                              // });
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
}

class EditDialogDoctor extends StatefulWidget {
  final Doctor? dector;

  const EditDialogDoctor({Key? key, this.dector}) : super(key: key);

  @override
  _EditDialogDoctorState createState() => _EditDialogDoctorState();
}

class _EditDialogDoctorState extends State<EditDialogDoctor> {


  String? id;
  String? name;
  String? latitude;
  String? longitude;
  String? description;
  String? specialist;
  String? reviews;
  String? Appointment;
  String? image;
  String? OriginalUrl;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showSelectFileMessage = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController specialistController = TextEditingController();
  TextEditingController reviewsController = TextEditingController();
  TextEditingController appoimentController = TextEditingController();

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
          image=null;
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

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
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
  // getLocation()async{
  //   var p=await determinePosition();
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
  void initState() {
    super.initState();
    if (widget.dector != null) {
      //* ---------------------------------
      //* Assign restaurant properties value
      //* ---------------------------------
      id=widget.dector?.id;
      name = widget.dector?.name;
      latitude= widget.dector?.latitude;
      longitude= widget.dector?.longitude;
      description = widget.dector?.description;
      reviews = widget.dector?.reviews;
      Appointment = widget.dector?.appoiment;
      specialist = widget.dector?.specialist;
      image=widget.dector?.imageUrl;
      OriginalUrl=widget.dector?.imageUrl;

      //* ---------------------------------------
      //* Assign textfield with the default value
      //* ---------------------------------------

      nameController.text = name!;
      latitudeController.text = latitude!;
      longitudeController.text = longitude!;
      descriptionController.text = description!;
      reviewsController.text = reviews!;
      appoimentController.text = Appointment!;
      specialistController.text = specialist!;

    }
  }

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
                        "Update Doctor",
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
                              ],
                            ),
                          ),

                        ],
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
                                (imageFile == null&&image==null)
                                    ? Text(
                                  "No File Chosen",
                                  style: TextStyle(fontSize: 14),
                                )
                                    : Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey)
                                    ),
                                    child: image == null?Ink.image(
                                      image: FileImage(imageFile!),
                                      fit: BoxFit.cover,
                                      height: 100,
                                    ):CachedNetworkImage(
                                      placeholder: (context, url) => imageLoader(),
                                      height: 100,
                                      imageUrl: image.toString(),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) => Image.asset(
                                        "assets/images/family_bean.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (!isSelectedImage&&image==null)
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
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          text: "Update",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(latitude.toString()) , double.parse(longitude.toString()));

                              if(isSelectedImage){
                                Reference ref =firebaseStorageRef.ref().child('upload/${rng.nextInt(1000)}');
                                UploadTask uploadTask = ref.putFile(imageFile!);
                                uploadTask.then((res) {res.ref.getDownloadURL().then((value) {
                                  var imgValue = value;
                                  FirebaseStorage.instance.refFromURL(OriginalUrl.toString()).delete().then((value){
                                    print("Old image Deleted Image");
                                  });
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth.instance.currentUser!.uid)
                                      .collection('doctor')
                                      .doc(id).update({
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
                                  }).then((result){//pop dialog
                                    Navigator.pop(context);
                                    ShowSuccessToast("Edited Succesfully");
                                  });
                                });});
                              }else{
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('doctor')
                                    .doc(id).update({
                                  "id":id,
                                  "name": name,
                                  "latitude": latitude,
                                  "longitude":longitude,
                                  "location":placemarks.first.name,
                                  "description":description,
                                  "specialist":specialist,
                                  "reviews":reviews,
                                  "Appointment":Appointment,
                                }).then((result){//pop dialog
                                  Navigator.pop(context);
                                  ShowSuccessToast("Edited Succesfully");
                                });
                              }

                              // Restaurant restaurant = Restaurant(
                              //   imageUrl: image!,
                              //   name: name!,
                              //   resType: category!,
                              //   rating: rating!,
                              //   price: price!,
                              //   distance: distance!,
                              // );
                              //
                              // if (_cloudFile != null) {
                              //   restaurantService.updateRestaurant(
                              //     widget.restaurant!.id!,
                              //     restaurant,
                              //     _fileBytes,
                              //     _cloudFile,
                              //   );
                              // } else {
                              //   restaurantService.updateRestaurant(
                              //       widget.restaurant!.id!,
                              //       restaurant,
                              //       null,
                              //       null);
                              // }

                              Navigator.pop(context);
                            } else {
                              // setState(() {
                              //   showSelectFileMessage = true;
                              // });
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
}