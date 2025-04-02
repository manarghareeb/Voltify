import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/const_themes.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';

class RoomAmountWidget extends StatelessWidget {
  const RoomAmountWidget({
    super.key,
    required this.roomName,
    required this.onpluss,
    required this.onminus,
  });
  final String roomName;
  final VoidCallback onpluss;
  final VoidCallback onminus;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        roomName,
        style: TextStyle(
          color: AppTheme.kSecondaryColor,
          fontSize: ScreenSize.width / 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          onPressed: onpluss,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ScreenSize.width / 40,
              ),
            ),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: ScreenSize.width / 50,
        ),
        Text(
          BlocProvider.of<HomeDesignCubit>(context)
              .roomVariable(roomName)
              .toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenSize.width / 15,
          ),
        ),
        SizedBox(
          width: ScreenSize.width / 50,
        ),
        IconButton(
          onPressed: onminus,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                ScreenSize.width / 40,
              ),
            ),
          ),
          icon: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}
