import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getDocID() async {
  var userSnapshot = await FirebaseFirestore.instance.collection("users").get();
  for (var doc in userSnapshot.docs) {
    if (doc.data()['email'] == FirebaseAuth.instance.currentUser!.email) {
      return doc.id; // Return the doc ID if found
    }
  }
  return null; // Return null if no doc is found
}

String? getRoomImage(String roomName) {
  if (roomName.contains("Bedroom")) {
    return "assets/app_images/rooms/bedRoom.png";
  } else if (roomName.contains("Kitchen")) {
    return "assets/app_images/rooms/kitchen.png";
  } else if (roomName.contains("Living Room")) {
    return "assets/app_images/rooms/livingRoom.png";
  } else if (roomName.contains("Bathroom")) {
    return "assets/app_images/rooms/bathRoom.png";
  } else if (roomName.contains("Office")) {
    return "assets/app_images/rooms/Office.png";
  } else if (roomName.contains("Balcony")) {
    return "assets/app_images/rooms/Balcony.png";
  } else if (roomName.contains("Laundary Room")) {
    return "assets/app_images/rooms/Laundary Room.png";
  } else if (roomName.contains("Storage Room")) {
    return "assets/app_images/rooms/Storage Room.png";
  }
  return null;
}
