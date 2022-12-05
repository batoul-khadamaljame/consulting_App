import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/enter_moblie_number_cubit.dart';
import 'package:consulting_app/Bloc/input_date_cubit.dart';
import 'package:consulting_app/BlocObserver.dart';
import 'package:consulting_app/UI/Screens/expertRegister_screen.dart';
import 'package:consulting_app/UI/Screens/home.dart';
import 'package:consulting_app/UI/Screens/login_screen.dart';
import 'package:consulting_app/UI/Screens/userRegister_screen.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();

  //The color of the status bar and system navigation bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.purple,
      systemNavigationBarColor: Colors.black,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ConsultingCubit()),
        BlocProvider(
            create: (BuildContext context) => EnterMoblieNumberCubit()),
        BlocProvider(create: (BuildContext context) => InputDateCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/userRegister': (context) => UserRegister(),
          '/expertRegister': (context) => ExpertRegisterScreen(),
          '/home': (context) => HomePage(),
        },
        home: null,
      ),
    );
  }
}
