import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
const Color kGreyColor = Colors.grey;
const double kdefaultPadding = 20;
const Color kWhiteColor = Colors.white;
Color? kLightGreyColor = Colors.grey[500];

TextStyle largestText = GoogleFonts.montserrat(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle largeText = GoogleFonts.montserrat(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

TextStyle normalText = GoogleFonts.montserrat(fontSize: 12);

TextStyle normalGreyText = GoogleFonts.montserrat(
  fontSize: 12,
  color: Colors.grey.shade600,
);

TextStyle normalBoldText = GoogleFonts.montserrat(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

List<String> tableTitle = [
  "Name",
  "Location",
  "Department",
];
List<String> doctorTableTitle = [
  "Name",
  "Location",
  "Description",
  "Specialist",
  "Reviews",
  "Appointment"
];

void Loader(BuildContext context){
   showGeneralDialog(
    context: context,
    barrierColor: Colors.black12.withOpacity(0.6), // Background color
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Column(
        children: <Widget>[
          Expanded(
            child: Center(child: Container(child: CircularProgressIndicator(color: Colors.black),width: 50,height: 50,)),
          ),
        ],
      );
    },
  );
}
void ShowSuccessToast(String messege){
  Fluttertoast.showToast(
      msg: messege,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0
  );
}