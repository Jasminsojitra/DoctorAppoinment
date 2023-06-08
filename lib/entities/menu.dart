import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

var items = ["Surgery",
    "Radiology",
    "Ophthalmology",
    "Pediatrics",
    "Neurology",
    "Cardiology",
    "Orthopedics",
    "Urology",
    "Obstetrics and gynaecology",
    "Dermatology",
    "Neurosurgery",
    "Pathology",
    "Psychiatry",
    "Pharmacy",
    "Emergency medicine",
    "Internal medicine",
    "Anesthesiology",
    "Otorhinolaryngology",
    "Gastroenterology",
    "Hematology",
    "Physical medicine and rehabilitation",
    "Nephrology",
    "Intensive care medicine",
    "Oncology"
];

class Menu {
  final IconData icon;
  final String title;

  Menu(this.icon, this.title);
}

final List<Menu> menuList = [
  Menu(FontAwesomeIcons.hospital, "Hospital"),
  Menu(FontAwesomeIcons.slack, "Hospital List"),
  Menu(FontAwesomeIcons.userDoctor, "Doctor"),
  Menu(FontAwesomeIcons.slack, "Doctor List"),
  Menu(FontAwesomeIcons.userDoctor, "Lap"),
  Menu(FontAwesomeIcons.slack, "Lap List"),
  Menu(FontAwesomeIcons.userDoctor, "Scan"),
  Menu(FontAwesomeIcons.slack, "Scan List"),
  //Menu(FontAwesomeIcons.solidHeart, "Favourites"),
];
