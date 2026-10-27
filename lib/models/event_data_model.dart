import 'package:flutter/material.dart';

class EventDataModel {
  static const String collectionName = 'collectionDataEvent';
  String eventID;
  final String eventTitle;
  final String eventDescription;
  final String eventCategory;
  final String eventImage;
  final DateTime eventDate;
  final TimeOfDay eventTime;
  final double latitude;
  final double longitude;
  bool isFavorite;

  EventDataModel({
    this.eventID = '',
    required this.eventTitle,
    required this.eventDescription,
    required this.eventCategory,
    required this.eventImage,
    required this.eventDate,
    required this.eventTime,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.isFavorite = false,
  });

  /// Get data from firestore
  factory EventDataModel.fromFirestore(Map<String, dynamic> json) {
    TimeOfDay parsedTime = const TimeOfDay(hour: 0, minute: 0);
    if (json['eventTime'] != null && json['eventTime'].toString().contains(':')) {
      final parts = json['eventTime'].toString().split(':');
      parsedTime = TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 0,
        minute: int.tryParse(parts[1]) ?? 0,
      );
    }

    return EventDataModel(
      eventID: json['eventID'] ?? '',
      eventTitle: json['eventTitle'] ?? '',
      eventDescription: json['eventDescription'] ?? '',
      eventCategory: json['eventCategory'] ?? '',
      eventImage: json['eventImage'] ?? '',
      eventDate: DateTime.fromMillisecondsSinceEpoch(
        json['eventDate'] ?? DateTime.now().millisecondsSinceEpoch,
      ),
      eventTime: parsedTime,
      latitude: (json['latitude'] as num?)?.toDouble() ??
          (json['latitdue'] as num?)?.toDouble() ??
          0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ??
          (json['longtiude'] as num?)?.toDouble() ??
          0.0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  /// Create data for firestore
  Map<String, dynamic> toFirestore() => {
        "eventID": eventID,
        "eventTitle": eventTitle,
        "eventDescription": eventDescription,
        "eventCategory": eventCategory,
        "eventImage": eventImage,
        "eventDate": eventDate.millisecondsSinceEpoch,
        "eventTime": "${eventTime.hour}:${eventTime.minute}",
        "latitude": latitude,
        "longitude": longitude,
        "isFavorite": isFavorite,
      };
}
