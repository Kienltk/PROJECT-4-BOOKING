import 'package:staynia/data/entity/model/category.dart';
import 'package:staynia/data/entity/model/document.dart';

class Room {
  int? status;
  String? actionKey;
  String? createdDate;
  String? lastUpdatedDate;
  int? id;
  List<Category>? categories;
  List<Category>? commons;
  List<Category>? tags;
  List<Document>? documents;
  String? title;
  String? subTitle;
  String? description;
  double? pricePerNight;
  double? cleaningFee;
  double? serviceFee;
  int? maxGuests;
  int? roomCount;
  int? bathroomCount;

  Room({
    this.status,
    this.actionKey,
    this.id,
    this.categories,
    this.commons,
    this.documents,
    this.title,
    this.description,
    this.tags,
    this.subTitle,
    this.pricePerNight,
    this.cleaningFee,
    this.serviceFee,
    this.maxGuests,
    this.roomCount,
    this.createdDate,
    this.lastUpdatedDate,
    this.bathroomCount,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      status: json['status'],
      actionKey: json['actionKey'],
      id: json['id'],
      categories: (json['categories'] as List?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
      commons: (json['commons'] as List?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
      tags: (json['tags'] as List?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
      documents: (json['documents'] as List?)
          ?.map((e) => Document.fromJson(e))
          .toList(),
      title: json['title'],
      createdDate: json['createdDate'],
      lastUpdatedDate: json['lastUpdatedDate'],
      subTitle: json['subTitle'],
      description: json['description'],
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble(),
      cleaningFee: (json['cleaningFee'] as num?)?.toDouble(),
      serviceFee: (json['serviceFee'] as num?)?.toDouble(),
      maxGuests: json['maxGuests'],
      roomCount: json['roomCount'],
      bathroomCount: json['bathroomCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'actionKey': actionKey,
    'id': id,
    'title': title,
    'description': description,
    'pricePerNight': pricePerNight,
    'cleaningFee': cleaningFee,
    'serviceFee': serviceFee,
    'maxGuests': maxGuests,
    'roomCount': roomCount,
    'bathroomCount': bathroomCount,
  };
}
