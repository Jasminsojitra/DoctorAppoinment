class Restaurant {
  final String? id;
  final String imageUrl;
  final String name;
  final String resType;
  final String rating;
  final String price;
  final String distance;

  Restaurant({
    this.id,
    required this.imageUrl,
    required this.name,
    required this.resType,
    required this.rating,
    required this.price,
    required this.distance,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'].toString(),
      imageUrl: json['imageUrl'] ?? "",
      name: json['name'],
      resType: json['resType'],
      rating: json['rating'],
      price: json['price'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['resType'] = this.resType;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['distance'] = this.distance;
    return data;
  }
}


List<Restaurant> cachedRestaurantList = [
  Restaurant(
    id: "1",
    imageUrl: "assets/images/family_bean.jpg",
    name: "Molon Lave",
    resType: "Asian Kitchen",
    rating: "4.7",
    price: "30",
    distance: "0.2",
  ),
  Restaurant(
    id: "2",
    imageUrl: "assets/images/boston_barista.jpg",
    name: "Bostan Barista",
    resType: "Pubs",
    rating: "4.8",
    price: "50",
    distance: "1.2",
  ),
  Restaurant(
    id: "3",
    imageUrl: "assets/images/family_bean.jpg",
    name: "Family Bean",
    resType: "Cafe",
    rating: "3.9",
    price: "45",
    distance: "3.1",
  ),
  Restaurant(
    id: "4",
    imageUrl: "assets/images/powerhouse.jpg",
    name: "Power House",
    resType: "Vegan",
    rating: "4.2",
    price: "28",
    distance: "0.6",
  ),
  Restaurant(
    id: "5",
    imageUrl: "assets/images/lureme.jpg",
    name: "Lureme",
    resType: "Cocktail Bar",
    rating: "4.3",
    price: "55",
    distance: "1.2",
  ),
];

class Hospital {
  final String? id;
  final String? imageUrl;
  final String name;
  final String latitude;
  final String longitude;
  final String location;
  final String department;

  Hospital({
    this.id,
    this.imageUrl,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.department,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'].toString(),
      imageUrl: json['imageUrl'].toString(),
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['department'] = this.department;
    return data;
  }
}

List<Hospital> cachedHospitalList = [
  Hospital(
    id: "1",
    imageUrl: "assets/images/boston_barista.jpg",
    name: "Molon Lave",
    latitude: "21.196102",
    longitude: "72.815766",
    location: "OPD should be located at the entrance of the hospital",
    department: "Pharmacy Department",
  ),
  Hospital(
    id: "2",
    imageUrl: "assets/images/family_bean.jpg",
    name: "Bostan Barista",
    latitude: "21.196102",
    longitude: "72.815766",
    location: "Should be separate from inpatient area connected to",
    department: "Dietary Department",
  ),
  Hospital(
    id: "3",
    imageUrl: "assets/images/family_bean.jpg",
    name: "Family Bean",
    latitude: "21.196102",
    longitude: "72.815766",
    location: "Must have easy access to MRD, X-ray, laboratory, pharmacy and billing counter",
    department: "Radiology Department",
  ),
];

class Doctor {
  final String? id;
  final String? imageUrl;
  final String name;
  final String latitude;
  final String longitude;
  final String location;
  final String description;
  final String specialist;
  final String reviews;
  final String appoiment;

  Doctor({
    this.id,
    this.imageUrl,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.description,
    required this.specialist,
    required this.reviews,
    required this.appoiment,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'].toString(),
      imageUrl: json['imageUrl'].toString(),
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      description: json['description'],
      specialist: json['specialist'],
      reviews: json['reviews'],
      appoiment: json['appoiment'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['description'] = this.description;
    data['specialist'] = this.specialist;
    data['reviews'] = this.reviews;
    data['appoiment'] = this.appoiment;
    return data;
  }
}

List<Doctor> cachedDoctorList = [
  Doctor(
    id: "1",
    imageUrl: "assets/images/family_bean.jpg",
    name: "Dr Manoj",
    latitude: "21.196102",
    longitude: "72.815766",
    location: "Surat",
    description: "OPD should be located at the entrance of the hospital ",
    specialist: "Pharmacy Department ",
    reviews: "He is good Doctor",
    appoiment: "Available after 08:00 ",
  ),
  Doctor(
    id: "1",
    imageUrl: "assets/images/family_bean.jpg",
    name: "Dr Manoj",
    latitude: "21.196102",
    longitude: "72.815766",
    location: "Surat",
    description: "Must have easy access to MRD, X-ray, laboratory, pharmacy and billing counter",
    specialist: "Radiology Department ",
    reviews: "He is good Doctor",
    appoiment: "09:00 ",
  ),

];