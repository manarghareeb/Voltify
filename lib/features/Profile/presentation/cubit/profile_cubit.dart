import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:voltify/core/fun.dart';
import 'package:voltify/features/Profile/data/room_model.dart';
import 'package:voltify/features/home%20entry%20details/data/device_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  Future<String?> getHomeDesign() async {
    String? docID = await getDocID();
    String? image;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docID)
        .get()
        .then((value) {
      image = value['HomeDesign'];
    });
    return image;
  }

  Future<List<String>> generateListOfRoomNames() async {
    String? docID = await getDocID();
    Map<String, dynamic>? roomNames;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(docID)
        .get()
        .then((value) {
      roomNames = value.data()?['roomCounts'];
    });

    List<String> roomList = [];
    if (roomNames != null) {
      roomNames!.forEach((key, count) {
        for (int i = 1; i <= count; i++) {
          roomList.add('$key $i');
        }
      });
    }

    log(roomList.toString());
    return roomList;
  }

  getRooms() async {
    try {
      emit(GetRoomsLoading());
      List<RoomModel> rooms = [];
      String? docID = await getDocID();
      List<String> roomNames = await generateListOfRoomNames();
      for (String roomName in roomNames) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(docID)
            .collection(roomName.replaceAll(" ", ""))
            .get()
            .then((value) {
          rooms.add(
            RoomModel(
              name: roomName,
              image: getRoomImage(roomName)!,
              devices: List.generate(value.size, (index) {
                return DeviceModel.fromFireStore(value.docs[index].data());
              }),
            ),
          );
        });
      }
      log(rooms.length.toString());
      emit(GetRoomsSuccess(rooms));
    } catch (e) {
      emit(GetRoomsError(e.toString()));
      log(e.toString());
    }
  }

  removeDeviceFromFireStoreRooms({
    required String deviceId,
    required String roomName,
  }) async {
    try {
      emit(RemoveDeviceLoading());

      String? docID = await getDocID();
      if (docID == null) {
        throw Exception("User document ID not found");
      }

      // Reference the collection for the specific room
      CollectionReference room = FirebaseFirestore.instance
          .collection('users')
          .doc(docID)
          .collection(roomName.replaceAll(" ", ""));

      // Query for the device with the matching id
      QuerySnapshot querySnapshot =
          await room.where('id', isEqualTo: deviceId).get();

      // Check if any document matches the device ID
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          // Delete the matching document
          await room.doc(doc.id).delete();
          log("Device with ID $deviceId removed successfully from $roomName");
        }
        emit(RemoveDeviceSuccess());
      } else {
        log("No device found with ID $deviceId in $roomName");
        emit(RemoveDeviceError("No device found with the specified ID."));
      }
    } catch (e) {
      emit(RemoveDeviceError(e.toString()));
    }
  }

}
