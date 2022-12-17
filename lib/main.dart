import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/enter_moblie_number_cubit.dart';
import 'package:consulting_app/Bloc/input_date_cubit.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/Bloc/search/search_cubit.dart';
import 'package:consulting_app/BlocObserver.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/expertRegister_screen.dart';
import 'package:consulting_app/UI/Screens/get_started.dart';
import 'package:consulting_app/UI/Screens/home.dart';
import 'package:consulting_app/UI/Screens/login_screen.dart';
import 'package:consulting_app/UI/Screens/pages_controll.dart';
import 'package:consulting_app/UI/Screens/search_screen.dart';
import 'package:consulting_app/UI/Screens/settiengs.dart';
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
  token = CacheHelper.getData(key: 'token');
  print(token);

  Widget widget;
  if (token != null) {
    widget = HomePage();
  } else {
    widget = const LoginScreen();
  }

  //The color of the status bar and system navigation bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp( MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

   MyApp({required this.startWidget, Key? key}) : super(key: key);

  int id = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ConsultingCubit()//..getHomeData(id)/*..getCategories()*/..getFavorites()/*..getUserData()*/,),
        ,),BlocProvider(
            create: (BuildContext context) => EnterMoblieNumberCubit()),
        BlocProvider(create: (BuildContext context) => InputDateCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => startWidget,
          '/login': (context) => LoginScreen(),
          '/getStarted': (context) => GetStartedScreen(),
          '/userRegister': (context) => UserRegister(),
          '/expertRegister': (context) => ExpertRegisterScreen(),
          '/home': (context) => PagesControllScreen(),
          '/search': (context) => SearchScreen(),
          '/settings': (context) => SettingsScreen(),
        },
        home: null,
      ),
    );
  }
}
