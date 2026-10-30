import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/event_data_model.dart';

class FirebaseFirestoreService {
  /// 1- Get Collection Reference with Converter
  static CollectionReference<EventDataModel> getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(EventDataModel.collectionName)
        .withConverter<EventDataModel>(
          fromFirestore: (snapshot, _) =>
              EventDataModel.fromFirestore(snapshot.data()!),
          toFirestore: (eventData, _) => eventData.toFirestore(),
        );
  }

  /// 2- Create New Event
  static Future<bool> createNewEvent(EventDataModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc();
      data.eventID = docRef.id;
      data.userID = FirebaseAuth.instance.currentUser?.uid ?? '';
      await docRef.set(data);
      return true;
    } catch (error) {
      log("createNewEvent error: $error");
      return false;
    }
  }

  /// 3- Get All Data Once
  static Future<List<EventDataModel>> getDataFromFirestore() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
      var query = getCollectionReference().where("userID", isEqualTo: currentUserId);
      QuerySnapshot<EventDataModel> data = await query.get();

      List<EventDataModel> eventDataList = data.docs.map((element) {
        return element.data();
      }).toList();

      return eventDataList;
    } catch (error) {
      log("getDataFromFirestore error: $error");
      return [];
    }
  }

  /// 4- Get Live Stream Filtered by Category and Current User ID
  static Stream<QuerySnapshot<EventDataModel>> getStreamData(String categoryName) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    Query<EventDataModel> query = getCollectionReference().where("userID", isEqualTo: currentUserId);

    if (categoryName != "All" && categoryName.isNotEmpty) {
      query = query.where("eventCategory", isEqualTo: categoryName);
    }

    return query.snapshots();
  }

  /// 5- Get Live Stream Favorite Events Only for Current User
  static Stream<QuerySnapshot<EventDataModel>> getStreamFavoriteData() {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    return getCollectionReference()
        .where("userID", isEqualTo: currentUserId)
        .where("isFavorite", isEqualTo: true)
        .snapshots();
  }

  /// 6- Delete Event
  static Future<bool> deleteEvent(EventDataModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc(data.eventID);
      await docRef.delete();
      return true;
    } catch (error) {
      log("deleteEvent error: $error");
      return false;
    }
  }

  /// 7- Update Event
  static Future<bool> updateEvent(EventDataModel data) async {
    try {
      var collectionRef = getCollectionReference();
      var docRef = collectionRef.doc(data.eventID);
      await docRef.update(data.toFirestore());
      return true;
    } catch (error) {
      log("updateEvent error: $error");
      return false;
    }
  }
}
