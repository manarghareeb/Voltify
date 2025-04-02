import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltify/core/database/cache_helper.dart';
import 'package:voltify/features/Authentication/cubit/auth_cubit.dart';
import 'package:voltify/features/Devices/presentation/cubit/devices_cubit.dart';
import 'package:voltify/features/Home/presentation/cubit/balance_cubit.dart';
import 'package:voltify/features/Home/presentation/views/home.dart';
import 'package:voltify/features/Home/presentation/views/home_view.dart';
import 'package:voltify/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:voltify/features/Profile/presentation/views/devicesRoom_view.dart';
import 'package:voltify/features/Profile/presentation/views/rooms_view.dart';
import 'package:voltify/features/home%20entry%20details/presentation/cubit/home_design_cubit.dart';
import 'package:voltify/features/home%20entry%20details/presentation/views/home_type_view.dart';
import 'package:voltify/features/onboarding/views/splash_screen.dart';
import 'package:voltify/features/Authentication/presentation/views/login_view.dart';
import 'package:voltify/features/Authentication/presentation/views/registeration_screen.dart';
import 'package:voltify/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const VoltifyApp());
}

class VoltifyApp extends StatefulWidget {
  const VoltifyApp({super.key});

  @override
  State<VoltifyApp> createState() => _VoltifyAppState();
}

class _VoltifyAppState extends State<VoltifyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeDesignCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => BalanceCubit()..loadBalance(),
        ),
        BlocProvider(
          create: (context) => DevicesCubit(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          RegisterationScreen.routeName: (context) =>
              const RegisterationScreen(),
          LoginView.routeName: (context) => const LoginView(),
          HomeTypeView.routeName: (context) => const HomeTypeView(),
          HomeScreens.routeName: (context) => const HomeScreens(),
          HomeView.routeName: (context) => const HomeView(),
          RoomsView.routeName: (context) => const RoomsView(),
          DevicesRoomView.routeName: (context) => const DevicesRoomView(),
        },
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
