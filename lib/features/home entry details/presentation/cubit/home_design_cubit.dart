import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:voltify/core/fun.dart';
import 'package:voltify/features/home%20entry%20details/data/device_model.dart';
import 'package:voltify/features/Profile/data/room_model.dart';

part 'home_design_state.dart';

class HomeDesignCubit extends Cubit<HomeDesignState> {
  HomeDesignCubit() : super(HomeDesignInitial());

  // room numbers
  int livingNum = 0;
  int kitchenNum = 0;
  int bedroomNum = 0;
  int bathroomNum = 0;
  int laundaryNum = 0;
  int officeNum = 0;
  int storageNum = 0;
  int balaconyNum = 0;

  Map<String, int> roomCounts = {};
  String? selectedDesign;

  void addRoomNumbers(String roomName) {
    roomCounts[roomName] = (roomCounts[roomName] ?? 0) + 1;
    addRoomNumber(roomName);
    emit(RoomNumbersUpdated(roomCounts));
  }

  void removeRoomNumbers(String roomName) {
    if (roomCounts[roomName] != null && roomCounts[roomName]! > 0) {
      roomCounts[roomName] = roomCounts[roomName]! - 1;
      removeRoomNumber(roomName);
      emit(RoomNumbersUpdated(roomCounts));
    }
  }

  Map<String, int> getRoomCounts() {
    return roomCounts;
  }

  //add the number of specific rooms
  addRoomNumber(String roomName) {
    if (roomName == 'Living Room') {
      livingNum++;
    } else if (roomName == 'Kitchen') {
      kitchenNum++;
    } else if (roomName == 'Bedroom') {
      bedroomNum++;
    } else if (roomName == 'Bathroom') {
      bathroomNum++;
    } else if (roomName == 'Laundary Room') {
      laundaryNum++;
    } else if (roomName == 'Office') {
      officeNum++;
    } else if (roomName == 'Storage Room') {
      storageNum++;
    } else if (roomName == 'Balcony') {
      balaconyNum++;
    }
  }

  //remove the number of specific rooms
  removeRoomNumber(String roomName) {
    if (roomName == 'Living Room') {
      if (livingNum > 0) {
        livingNum--;
      } else {
        livingNum = 0;
      }
    } else if (roomName == 'Kitchen') {
      if (kitchenNum > 0) {
        kitchenNum--;
      } else {
        kitchenNum = 0;
      }
    } else if (roomName == 'Bedroom') {
      if (bedroomNum > 0) {
        bedroomNum--;
      } else {
        bedroomNum = 0;
      }
    } else if (roomName == 'Bathroom') {
      if (bathroomNum > 0) {
        bathroomNum--;
      } else {
        bathroomNum = 0;
      }
    } else if (roomName == 'Laundary Room') {
      if (laundaryNum > 0) {
        laundaryNum--;
      } else {
        laundaryNum = 0;
      }
    } else if (roomName == 'Office') {
      if (officeNum > 0) {
        officeNum--;
      } else {
        officeNum = 0;
      }
    } else if (roomName == 'Storage Room') {
      if (storageNum > 0) {
        storageNum--;
      } else {
        storageNum = 0;
      }
    } else if (roomName == 'Balcony') {
      if (balaconyNum > 0) {
        balaconyNum--;
      } else {
        balaconyNum = 0;
      }
    }
  }

  //get the number of specific rooms
  roomVariable(String roomName) {
    if (roomName == 'Living Room') {
      return livingNum;
    } else if (roomName == 'Kitchen') {
      return kitchenNum;
    } else if (roomName == 'Bedroom') {
      return bedroomNum;
    } else if (roomName == 'Bathroom') {
      return bathroomNum;
    } else if (roomName == 'Laundary Room') {
      return laundaryNum;
    } else if (roomName == 'Office') {
      return officeNum;
    } else if (roomName == 'Storage Room') {
      return storageNum;
    } else if (roomName == 'Balcony') {
      return balaconyNum;
    }
  }

//------------------------------------------------------------------------
  List livingRooms = [];
  List kitchenRooms = [];
  List bedroomRooms = [];
  List bathroomRooms = [];
  List laundaryRooms = [];
  List officeRooms = [];
  List storageRooms = [];
  List balaconyRooms = [];
  //next page
  nextOne() {
    livingRooms = List.generate(
      livingNum,
      (i) {
        return "Living Room ${i + 1}";
      },
    );
    kitchenRooms = List.generate(
      kitchenNum,
      (i) {
        return "Kitchen ${i + 1}";
      },
    );
    bedroomRooms = List.generate(
      bedroomNum,
      (i) {
        return "Bedroom ${i + 1}";
      },
    );
    bathroomRooms = List.generate(
      bathroomNum,
      (i) {
        return "Bathroom ${i + 1}";
      },
    );
    laundaryRooms = List.generate(
      laundaryNum,
      (i) {
        return "Laundary Room ${i + 1}";
      },
    );
    officeRooms = List.generate(
      officeNum,
      (i) {
        return "Office ${i + 1}";
      },
    );
    storageRooms = List.generate(
      storageNum,
      (i) {
        return "Storage Room ${i + 1}";
      },
    );
    balaconyRooms = List.generate(
      balaconyNum,
      (i) {
        return "Balcony ${i + 1}";
      },
    );
    log(livingRooms.toString());
    log(kitchenRooms.toString());
    log(bedroomRooms.toString());
    log(bathroomRooms.toString());
    log(laundaryRooms.toString());
    log(officeRooms.toString());
    log(storageRooms.toString());
    log(balaconyRooms.toString());
  }

  //final room models
  List<RoomModel> livingRoomModels = [];
  List<RoomModel> kitchenRoomModels = [];
  List<RoomModel> bedroomRoomModels = [];
  List<RoomModel> bathroomRoomModels = [];
  List<RoomModel> laundaryRoomModels = [];
  List<RoomModel> officeRoomModels = [];
  List<RoomModel> storageRoomModels = [];
  List<RoomModel> balaconyRoomModels = [];

  List<DeviceModel> devicesAPI = [];
  getDevicesAPI() async {
    try {
      emit(GetDevicesLoading());
      final response =
          await Dio().get("https://back-render.vercel.app/devices/all");
      devicesAPI = List.generate(
        response.data.length,
        (index) => DeviceModel.fromJson(response.data[index]),
      );
      log(devicesAPI.toString());
      emit(GetDevicesSuccess(devicesAPI));
    } on DioException catch (e) {
      log(e.message.toString());
      emit(GetDevicesError(e.message.toString()));
    }
  }

  addDeviceToFireStoreRooms(
      {required String deviceName,
      required String model,
      required String roomName}) async {
    try {
      emit(AddDeviceLoading());
      num power = 0;
      String deviceIcon = "";
      String id = "";
      for (var device in devicesAPI) {
        if (device.deviceName == deviceName && device.model == model) {
          power = device.powerConsumption;
          id = device.id;
          deviceIcon = device.deviceIcon;
          break;
        }
      }
      String? docID = await getDocID();
      CollectionReference room = FirebaseFirestore.instance
          .collection('users')
          .doc(docID)
          .collection(roomName.replaceAll(" ", ""));
      await room.add({
        'id': id,
        'deviceName': deviceName,
        'model': model,
        'powerConsumption': power,
        "deviceIcon": deviceIcon,
      });
      emit(AddDeviceSuccess());
      log("-------------------------");
      log("Device ($deviceName) added successfully to $room");
    } catch (e) {
      emit(AddDeviceError(e.toString()));
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

  Stream<QuerySnapshot> displayDevicesFromSpecificRoom(String roomName) async* {
    String? docID = await getDocID();

    if (docID != null) {
      // Return the stream of documents from the specified room
      yield* FirebaseFirestore.instance
          .collection('users')
          .doc(docID)
          .collection(roomName.replaceAll(" ", ""))
          .snapshots();
    }
  }

  finishButton() async {
    try {
      emit(UpdateDataUserLoading());
      String? docID = await getDocID();
      final roomCol = FirebaseFirestore.instance.collection('users').doc(docID);
      await roomCol.update(
        {
          'roomCounts': roomCounts,
          'HomeDesign': selectedDesign,
        },
      );
      log("Data updated successfully in Firestore added successfully to $roomCounts and $selectedDesign");
      emit(UpdateDataUserSuccess());
    } catch (e) {
      emit(UpdateDataUserError(e.toString()));
      log(e.toString());
    }
  }
}
