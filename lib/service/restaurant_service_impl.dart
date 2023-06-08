import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorappoimentadmin/service/restaurant_service_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/restaurant.dart';

class RestaurantServiceImpl implements IRestaurantService {

    @override
  Future<List<Hospital>> getAllHospital() async {
    QuerySnapshot qShot =
    await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('hospital').get();
    // final allData = qShot.docs.map((doc) => doc.data()).toList();
    // print(allData);
    // var d=qShot.docs.map(
    //         (doc) => Hospital(
    //         id:doc['id'],
    //         department: doc['department'],
    //         name:doc['name'],
    //         location:doc['location'])
    // ).toList();
    return qShot.docs.map(
            (doc) => Hospital(
            id:doc['id'],
            imageUrl: "https:/",
            department: doc['department'],
            name:doc['name'],
            latitude:  doc['latitude'],
            longitude: doc['longitude'],
            location:doc['location'])
    ).toList();
  }

}
