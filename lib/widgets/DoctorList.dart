import 'package:doctorappoimentadmin/widgets/restaurant_card.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../entities/restaurant.dart';
import 'AddHospitalDialog.dart';

class DoctorList extends StatefulWidget {
  final List<Doctor> doctorList;

  const DoctorList({
    Key? key,
    required this.doctorList,
  }) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20),
        height: 280,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: widget.doctorList.length + 1,
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
                          return AddDoctorDialog();
                        },
                      );
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
                                  "assets/images/lureme.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Add A Doctor!",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Share a Doctor refrence that you like to everyone",
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
              child: DoctorCard(
                onTap: () {},
                backgroundColor:
                Colors.primaries[index % Colors.primaries.length],
                doctors:  widget.doctorList[index - 1],
              ),
            );
          },
        ),
      ),
    );
  }
}
