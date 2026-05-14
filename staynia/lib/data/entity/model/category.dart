import 'package:staynia/core/constants/app_svg.dart';

class Category {
  int? id;
  String? name;
  String? type;
  String? description;
  String? icon;

  Category({this.id, this.name, this.type, this.description, this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'description': description,
    'icon': icon,
  };

  Category copyWith({
    int? id,
    String? name,
    String? type,
    String? description,
    String? icon,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  static final List<Map<String, dynamic>> listCommon = [
    {
      'id': 1,
      "name": "Wifi",
      "description": "Free high-speed Wi-Fi available throughout the property",
      "type": "COMMON",
      'icon': AppSvg.commonWifi,
    },
    {
      'id': 2,
      "name": "Air Conditioning",
      "description": "Air conditioning available in every room",
      "type": "COMMON",
      'icon': AppSvg.commonAirConditioning,
    },
    {
      'id': 3,
      "name": "TV",
      "description": "Flat-screen TV with cable channels",
      "type": "COMMON",
      'icon': AppSvg.commonTV,
    },
    {
      'id': 4,
      "name": "Mini Bar",
      "description": "Mini bar with snacks and drinks provided",
      "type": "COMMON",
      'icon': AppSvg.commonMiniBar,
    },
    {
      'id': 5,
      "name": "Wordspace",
      "description": "Dedicated workspace with desk and chair",
      "type": "COMMON",
      'icon': AppSvg.commonWordSpace,
    },
    {
      'id': 6,
      "name": "Safe",
      "description": "Safety box for personal belongings",
      "type": "COMMON",
      'icon': AppSvg.commonSafe,
    },
    {
      'id': 7,
      "name": "Hair Dryer",
      "description": "Hair dryer available in the bathroom",
      "type": "COMMON",
      'icon': AppSvg.commonHairDryer,
    },
    {
      'id': 8,
      "name": "No Smoking",
      "description": "Non-smoking room for clean air and comfort",
      "type": "COMMON",
      'icon': AppSvg.commonNoSmorking,
    },
    {
      'id': 9,
      "name": "Balcony",
      "description": "Private balcony with scenic view",
      "type": "COMMON",
      'icon': AppSvg.commonBalcory,
    },
    {
      'id': 10,
      "name": "Washing",
      "description": "Washing machine for personal laundry",
      "type": "COMMON",
      'icon': AppSvg.commonWashing,
    },
    {
      'id': 11,
      "name": "Microwave",
      "description": "Microwave for heating or quick cooking",
      "type": "COMMON",
      'icon': AppSvg.commonMicroware,
    },
    {
      'id': 12,
      "name": "Stove",
      "description": "Stove with essential cooking utensils",
      "type": "COMMON",
      'icon': AppSvg.commonStove,
    },
    {
      'id': 13,
      "name": "Coffee",
      "description": "Coffee maker or electric kettle provided",
      "type": "COMMON",
      'icon': AppSvg.commonCoffee,
    },
    {
      'id': 14,
      "name": "Pool",
      "description": "Swimming pool for relaxation and fun",
      "type": "COMMON",
      'icon': AppSvg.commonPool,
    },
    {
      'id': 15,
      "name": "Dumbbell",
      "description": "Gym equipped with fitness machines",
      "type": "COMMON",
      'icon': AppSvg.commonDumbbel,
    },
    {
      'id': 16,
      "name": "Car Parking",
      "description": "Private parking space for guests",
      "type": "COMMON",
      'icon': AppSvg.commonCar,
    },
    {
      'id': 17,
      "name": "Elevator",
      "description": "Elevator access to all floors",
      "type": "COMMON",
      'icon': AppSvg.commonElevator,
    },
    {
      'id': 18,
      "name": "Soap",
      "description": "Free toiletries including soap and shampoo",
      "type": "COMMON",
      'icon': AppSvg.commonSoap,
    },
    {
      'id': 19,
      "name": "Bathtub",
      "description": "Bathtub for a relaxing soak",
      "type": "COMMON",
      'icon': AppSvg.commonBathtub,
    },
    {
      'id': 20,
      "name": "Towel",
      "description": "Fresh towels replaced daily",
      "type": "COMMON",
      'icon': AppSvg.commonTowel,
    },
    {
      'id': 21,
      "name": "Paw",
      "description": "Pet-friendly accommodation allowed",
      "type": "COMMON",
      'icon': AppSvg.commonPaw,
    },
    {
      'id': 22,
      "name": "BBQ",
      "description": "Outdoor BBQ area for guests",
      "type": "COMMON",
      'icon': AppSvg.commonBbq,
    },
    {
      'id': 23,
      "name": "Garden",
      "description": "Beautiful garden area for relaxation",
      "type": "COMMON",
      'icon': AppSvg.commonGarden,
    },
    {
      'id': 24,
      "name": "Security",
      "description": "24/7 security and surveillance cameras",
      "type": "COMMON",
      'icon': AppSvg.commonSecurity,
    },
    {
      'id': 25,
      "name": "Luggage",
      "description": "Luggage storage service at the reception",
      "type": "COMMON",
      'icon': AppSvg.commonLuggage,
    },
  ];
}
