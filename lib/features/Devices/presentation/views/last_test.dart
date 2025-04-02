import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/features/Devices/data/devices_model.dart';
import 'package:voltify/features/Devices/presentation/widgets/last_test.dart';
import '../../../const_themes.dart';
import '../cubit/devices_cubit.dart';

class HomeScreenTest extends StatelessWidget {
  //final List<String> rooms = ['Living Room', 'Bedroom', 'Kitchen'];

  @override
  Widget build(BuildContext context) {
    final rooms = ModalRoute.of(context)!.settings.arguments as List<DevicesModel>;
    return BlocConsumer(
        builder: (context, state){
          if (state is DevicesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DevicesSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Devices',
                  style: TextStyle(
                    color: AppTheme.kSecondaryColor,
                    fontSize: MediaQuery.of(context).size.width / 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor: AppTheme.kPrimaryColor,
                elevation: 0,
              ),
              backgroundColor: AppTheme.kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your devices:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width / 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          return RoomItemTest(rooms[index] as String);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is DevicesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red
              ),
            );
          }
          },
    );
  }
}
