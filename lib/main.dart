import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/Bloc/enter_moblie_number_cubit.dart';
import 'package:consulting_app/Bloc/home_guest/home_guest_cubit.dart';
import 'package:consulting_app/Bloc/input_date_cubit.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/Bloc/messanger/message_cubit.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_cubit.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/Bloc/reservation/reservation_cubit.dart';
import 'package:consulting_app/Bloc/reservation_history/reservation_history_cubit.dart';
import 'package:consulting_app/Bloc/search/search_cubit.dart';
import 'package:consulting_app/BlocObserver.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/chat.dart';
import 'package:consulting_app/UI/Screens/expertRegister_screen.dart';
import 'package:consulting_app/UI/Screens/home_message.dart';
import 'package:consulting_app/UI/Screens/public_expert_profile.dart';
import 'package:consulting_app/UI/Screens/get_started.dart';
import 'package:consulting_app/UI/Screens/home_guest.dart';
import 'package:consulting_app/UI/Screens/login_screen.dart';
import 'package:consulting_app/UI/Screens/pages_controll.dart';
import 'package:consulting_app/UI/Screens/public_user_profile.dart';
import 'package:consulting_app/UI/Screens/reservation_history.dart';
import 'package:consulting_app/UI/Screens/search_screen.dart';
import 'package:consulting_app/UI/Screens/service_reservation.dart';
import 'package:consulting_app/UI/Screens/settiengs.dart';
import 'package:consulting_app/UI/Screens/userRegister_screen.dart';
import 'package:consulting_app/UI/Screens/private_profile.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:consulting_app/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  CacheHelper.getData(key: 'switchValue') != null
      ? switchValue = CacheHelper.getData(key: 'switchValue')
      : false;
  print('token= $token');

  Widget widget;
  if (token != null) {
    widget = PagesControllScreen();
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

  runApp(EasyLocalization(
      path: 'assets/translations/',
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: MyApp(startWidget: widget)));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ConsultingCubit()
            ..getHomeDataToken(0)
            ..getUserData()
            ..getFavorites() /*..getCategories()*/ //..getFavorites()/*..getUserData()*/,),
          ,
        ),
        BlocProvider(
            create: (BuildContext context) =>
                HomeGuestCubit()..getHomeDataGuest(0)),
        BlocProvider(
            create: (BuildContext context) => EnterMoblieNumberCubit()),
        BlocProvider(create: (BuildContext context) => InputDateCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),
        BlocProvider(create: (BuildContext context) => ReservationCubit()),
        BlocProvider(create: (BuildContext context) => PublicProfileCubit()),
        BlocProvider(
            create: (BuildContext context) => ReservationHistoryCubit()),
        BlocProvider(create: (BuildContext context) => MessageCubit()),
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/login': (context) => LoginScreen(),
          '/getStarted': (context) => GetStartedScreen(),
          '/userRegister': (context) => UserRegister(),
          '/expertRegister': (context) => ExpertRegisterScreen(),
          '/home': (context) => PagesControllScreen(),
          '/search': (context) => SearchScreen(),
          '/settings': (context) => SettingsScreen(),
          '/reservation': (context) => ServiceReservation(),
          '/public_expert_profile': (context) => PublicExpertProfileScreen(),
          '/public_user_profile': (context) => PublicUserProfileScreen(),
          '/reservation_history': (context) => ReservationHisory(),
          '/home_message': (context) => HomeMessageScreen(),
          '/chat': (context) => ChatScreen(),
        },
        home: null,
      ),
    );
  }
}
