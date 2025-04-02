import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../../core/fun.dart';
import '../../../home entry details/data/device_model.dart';
import '../../data/devices_model.dart';
part 'devices_state.dart';

class DevicesCubit extends Cubit<DevicesState> {
  DevicesCubit() : super(DevicesInitial());

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
      emit(DevicesLoading());
      List<DevicesModel> rooms = [];
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
            DevicesModel(
              name: roomName,
              isOn: true,
              devices: List.generate(value.size, (index) {
                return DeviceModel.fromFireStore(value.docs[index].data());
              }),
            ),
          );
        });
      }
      log(rooms.length.toString());
      emit(DevicesSuccess(rooms));
      return rooms;
    } catch (e) {
      emit(DevicesError(e.toString()));
      log(e.toString());
      return [];
    }
  }
}
