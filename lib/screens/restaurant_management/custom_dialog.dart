import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../../constants.dart';
import '../../entities/restaurant.dart';
import '../../widgets/custom_text_button.dart';
import '../../widgets/restaurant_card.dart';

Widget imageLoader(){
  return Center(
    child: SizedBox(
      child: CircularProgressIndicator(color: Colors.black54),
      height: 50.0,
      width: 50.0,
    ),
  );
}

class CustomDialog extends StatefulWidget {
  final String dialogTitle;
  final String buttonText;
  final VoidCallback onTap;
  final Restaurant restaurant;

  const CustomDialog({
    Key? key,
    required this.restaurant,
    required this.dialogTitle,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

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
        content: Container(
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
                      widget.dialogTitle,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailInfo(
                                  title: "ID", info: widget.restaurant.id!),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      "Image",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(2.0),
                                    child: Container(
                                      width: 250,
                                      child: AspectRatio(
                                        aspectRatio: 1.8,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: CircularProgressIndicator(color: Colors.black,),
                                          ),
                                          imageUrl: widget.restaurant.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DetailInfo(
                                  title: "Category",
                                  info: widget.restaurant.resType),
                              DetailInfo(
                                  title: "Rating",
                                  info: widget.restaurant.rating),
                              DetailInfo(
                                  title: "Price",
                                  info: widget.restaurant.price),
                              DetailInfo(
                                  title: "Distance",
                                  info: widget.restaurant.distance),
                            ],
                          ),
                        ),
                        const SizedBox(width: 50),
                        Material(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.primaries[
                                  int.parse(widget.restaurant.id!) %
                                      Colors.primaries.length]
                              .withOpacity(0.2),
                          child: Container(
                            height: 275,
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
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: CircularProgressIndicator(color: Colors.black,),
                                          ),
                                          imageUrl: widget.restaurant.imageUrl,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      widget.restaurant.name,
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
                                      widget.restaurant.resType,
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
                                              widget.restaurant.rating,
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
                                              widget.restaurant.price,
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
                                              widget.restaurant.distance,
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
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        text: widget.buttonText,
                        onTap: widget.onTap,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  final String title;
  final String info;

  const DetailInfo({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 150,
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              info,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomDialogHospital extends StatefulWidget {
  final String dialogTitle;
  final String buttonText;
  final VoidCallback onTap;
  final Hospital hospital;

  const CustomDialogHospital({
    Key? key,
    required this.hospital,
    required this.dialogTitle,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomDialogHospitalState createState() => _CustomDialogHospitalState();
}

class _CustomDialogHospitalState extends State<CustomDialogHospital> {
  //final restaurantService = getIt<IRestaurantService>();

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
        insetPadding: EdgeInsets.all(20),
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: MediaQuery.of(context).size.width,
          // height: 700,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.dialogTitle,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // DetailInfo(
                              //     title: "ID", info: widget.hospital.id!),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      "Image",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                   Expanded(
                                     child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey)
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 1.8,
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => Padding(
                                              padding: const EdgeInsets.all(25.0),
                                              child: CircularProgressIndicator(color: Colors.black,),
                                            ),
                                            imageUrl: widget.hospital.imageUrl.toString(),
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) => Image.asset(
                                              "assets/images/lureme.jpg",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                   ),

                                ],
                              ),
                              SizedBox(height: 5,),
                              DetailInfo(
                                  title: "Name",
                                  info: widget.hospital.name),
                              DetailInfo(
                                  title: "Location",
                                  info: widget.hospital.location),
                              DetailInfo(
                                  title: "Department",
                                  info: widget.hospital.department),
                            ],
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        text: widget.buttonText,
                        onTap: widget.onTap,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialogDoctor extends StatefulWidget {
  final String dialogTitle;
  final String buttonText;
  final VoidCallback onTap;
  final Doctor docotor;

  const CustomDialogDoctor({
    Key? key,
    required this.docotor,
    required this.dialogTitle,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomDialogDoctorState createState() => _CustomDialogDoctorState();
}

class _CustomDialogDoctorState extends State<CustomDialogDoctor> {
  //final restaurantService = getIt<IRestaurantService>();

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
        content: Container(
          width: 750,
          // height: 700,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.dialogTitle,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      "Image",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey)
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1.8,
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => imageLoader(),
                                          imageUrl: widget.docotor.imageUrl.toString(),
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => Image.asset(
                                            "assets/images/lureme.jpg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 5,),
                              DetailInfo(
                                  title: "Name",
                                  info: widget.docotor.name),
                              DetailInfo(
                                  title: "Location",
                                  info: widget.docotor.location),
                              DetailInfo(
                                  title: "Description",
                                  info: widget.docotor.description),
                              DetailInfo(
                                  title: "Specialist",
                                  info: widget.docotor.specialist),
                              DetailInfo(
                                  title: "Reviews",
                                  info: widget.docotor.reviews),
                              DetailInfo(
                                  title: "Appointment",
                                  info: widget.docotor.appoiment),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        text: widget.buttonText,
                        onTap: widget.onTap,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}