import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/Bloc/reservation_history/reservation_history_cubit.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/reservation_history.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var fullnameController = TextEditingController();
var emailController = TextEditingController();
var numberController = TextEditingController();
var roleController = TextEditingController();

var medicinePriceController = TextEditingController();
var careerPriceController = TextEditingController();
var psychologyPriceController = TextEditingController();
var familyPriceController = TextEditingController();
var managementPriceController = TextEditingController();

List<TextEditingController> OtherNamesController = [];
List<TextEditingController> OtherPricesController = [];

var countryController = TextEditingController();
var cityController = TextEditingController();

var descriptionController = TextEditingController();

var startTimeController = TextEditingController();
var endTimeController = TextEditingController();

List<TextEditingController> starttimesController = [];
List<TextEditingController> endtimesController = [];

var formKey = GlobalKey<FormState>();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool? isMedecine = false;
  bool? isCareer = false;
  bool? isPsychology = false;
  bool? isFamily = false;
  bool? isManagement = false;

  bool? isSunday = false;
  bool? isMonday = false;
  bool? isTuesday = false;
  bool? isWednesday = false;
  bool? isThursday = false;
  bool? isFriday = false;
  bool? isSaturday = false;

  void addOtherCategoryController() {
    OtherNamesController.add(TextEditingController());
    OtherPricesController.add(TextEditingController());
    print(OtherNamesController);
    print(OtherPricesController);
  }

  void deleteOtherCategoryController() {
    OtherNamesController.removeLast();
    OtherPricesController.removeLast();
  }

  void addOtherTimesController() {
    starttimesController.add(TextEditingController());
    endtimesController.add(TextEditingController());
  }

  void deleteOtherTimesController() {
    starttimesController.removeLast();
    endtimesController.removeLast();
  }
/*
  void addServices(
      bool isMedecine,
      bool isCareer,
      bool isPsychology,
      bool isFamily,
      bool isManagement,
      bool isSunday,
      bool isMonday,
      bool isTuesday,
      bool isWednesday,
      bool isThursday,
      bool isFriday,
      bool isSaturday) {
    if (isMedecine) {
      RegisterCubit.get(context)
          .addService('1', 'Medicine', medicinePriceController.text);
    }
    if (isCareer) {
      RegisterCubit.get(context)
          .addService('2', 'Career', careerPriceController.text);
    }
    if (isPsychology) {
      RegisterCubit.get(context)
          .addService('3', 'Psychology', psychologyPriceController.text);
    }
    if (isFamily) {
      RegisterCubit.get(context)
          .addService('4', 'Family', familyPriceController.text);
    }
    if (isManagement) {
      RegisterCubit.get(context)
          .addService('5', 'Management', managementPriceController.text);
    }

    for (int i = 0; i < OtherNamesController.length; i++) {
      RegisterCubit.get(context).addService(
          '6', OtherNamesController[i].text, OtherPricesController[i].text);
    }

    if (isSunday ||
        isMonday ||
        isTuesday ||
        isWednesday ||
        isThursday ||
        isFriday ||
        isSaturday) {
      RegisterCubit.get(context).addDays(isSunday, isMonday, isTuesday,
          isWednesday, isThursday, isFriday, isSaturday);
    }
    RegisterCubit.get(context)
        .addTimes(startTimeController.text, endTimeController.text);
    for (int i = 0; i < starttimesController.length; i++) {
      RegisterCubit.get(context)
          .addTimes(starttimesController[i].text, endtimesController[i].text);
    }
  }
  */
  @override
  Widget build(BuildContext context) {
    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;
    return BlocConsumer<ConsultingCubit, ConsultingStates>(
      listener: (context, state) {

        if (state is SuccessLogoutState) {
          if (state.logoutModel.status != false) {
            showToast(
              text: state.logoutModel.message!,
              state: ToastState.success,
            );
            signOut(context);
          } else {
            showToast(
              text: state.logoutModel.message!,
              state: ToastState.error,
            );
          }
        }

      },
      builder: (
        context,
        state,
      ) {

        var model = ConsultingCubit.get(context).userDataModel;
        fullnameController.text = model!.data!.user!.name!;
        emailController.text = model.data!.user!.email!;
        numberController.text = model.data!.user!.phone!;

        if (model.data!.user!.isExp == 1) {
          roleController.text = 'Expert';
        } else {
          roleController.text = 'User';
        }


        if (model.data!.user!.isExp == 1) {
          int j =0;
          for (int i = 0; i < model.data!.expert!.experiences!.length; i++) {
            if (model.data!.expert!.experiences![i].category_id == 1){
              isMedecine = true;
              medicinePriceController.text = model.data!.expert!.experiences![i].price.toString();
            }
            else if(model.data!.expert!.experiences![i].category_id == 2){
              isCareer = true;
              careerPriceController.text = model.data!.expert!.experiences![i].price.toString();
            }
            else if(model.data!.expert!.experiences![i].category_id == 3){
              isPsychology = true;
              psychologyPriceController.text = model.data!.expert!.experiences![i].price.toString();
            }else if(model.data!.expert!.experiences![i].category_id == 4){
              isFamily = true;
              familyPriceController.text = model.data!.expert!.experiences![i].price.toString();
            }else if(model.data!.expert!.experiences![i].category_id == 5){
              isManagement = true;
              managementPriceController.text = model.data!.expert!.experiences![i].price.toString();
            }
            else{
              OtherNamesController.add(TextEditingController());
              OtherNamesController[j].text = model.data!.expert!.experiences![i].category_name!;
              OtherPricesController.add(TextEditingController());
              OtherPricesController[j].text = model.data!.expert!.experiences![i].price.toString();
              j++;
            }

          }

          for(int i=0;i<OtherNamesController.length;i++){
            print(OtherNamesController[i].text);
          }

          countryController.text = model.data!.expert!.expertInfo!.country!;
          cityController.text = model.data!.expert!.expertInfo!.city!;
          descriptionController.text = model.data!.expert!.expertInfo!.skills!;


          isSunday = model.data!.expert!.days!.sunday==0?false:true;
          isMonday = model.data!.expert!.days!.monday==0?false:true;
          isTuesday = model.data!.expert!.days!.tuesday==0?false:true;
          isWednesday = model.data!.expert!.days!.wednesday==0?false:true;
          isThursday = model.data!.expert!.days!.thursday==0?false:true;
          isFriday = model.data!.expert!.days!.friday==0?false:true;
          isSaturday = model.data!.expert!.days!.saturday==0?false:true;


          for(int i=0;i<model.data!.expert!.duration!.length;i++){
            starttimesController.add(TextEditingController());
            starttimesController[i].text = model.data!.expert!.duration![i].from.toString();
            endtimesController.add(TextEditingController());
            endtimesController[i].text = model.data!.expert!.duration![i].to.toString();
          }

        }


        return ConditionalBuilder(
          condition: state is! LoadingUserDataState,
          builder: (context) => model.data!.user!.isExp == 0
              ? Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: ThemeColors.icons),
                    backgroundColor: ThemeColors.backgroundColor,
                    /*leading: Icon(

                          Icons.menu,
                          color: ThemeColors.icons,


                    ),*/
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: ThemeColors.icons,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/search');
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.message,
                          color: ThemeColors.icons,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/messege');
                        },
                      ),
                    ],
                    elevation: 0.0,
                  ),
                  backgroundColor: ThemeColors.backgroundColor,
                  drawer: Drawer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: heightscreen * 0.07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              size: 50,
                              color: Colors.deepPurple,
                            ),
                            SizedBox(
                              width: widthscreen * 0.01,
                            ),
                            Text('Settings',
                                style: TextStyle(
                                    fontSize: 27,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: heightscreen * 0.05,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.language,
                              size: 30,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: widthscreen * 0.01,
                            ),
                            Text('Language',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(
                          height: heightscreen * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: heightscreen * 0.05,
                              width: widthscreen * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: switchValue
                                    ? Colors.white
                                    : ThemeColors.backgroundColor,
                              ),
                              child: Center(
                                child: Text(
                                  'English',
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                            Switch(
                              value: switchValue,
                              onChanged: (value) async{
                                ConsultingCubit.get(context).changeLanguage(value,context);
                                await switchValue?context.setLocale(Locale('ar')):context.setLocale(Locale('en'));
                              },
                              inactiveThumbColor: Colors.purple,
                              inactiveTrackColor: Colors.purple,
                              activeTrackColor: ThemeColors.highlight,
                              activeColor: ThemeColors.highlight,
                            ),
                            Container(
                              height: heightscreen * 0.05,
                              width: widthscreen * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: switchValue
                                    ? ThemeColors.backgroundColor
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Arabic',
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heightscreen * 0.1,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          Icon(
                            Icons.info,
                            size: 30,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: widthscreen * 0.01,
                          ),
                          Text('About us',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),),
                        ],),
                        SizedBox(
                          height: heightscreen * 0.03,
                        ),
                        Text('This app was created by the developers Bassam,Batoul,Rajaei and Obada(BBRO).           You can sign up as a User or an Expert, then sell and buy some services of different types. We are so glad by offer this app that can be used on your phone',style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 2)),
                      ],
                    ),
                  ),
                )),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 65.0,
                                backgroundColor:
                                    Color.fromARGB(255, 200, 119, 238),
                              ),
                              Container(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/images/imageprofile.jpeg",
                                        width: 115,
                                        height: 115,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: heightscreen * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'My Role:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.icon,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      readOnly: true,
                                      enabled: false,
                                      controller: roleController,
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (String value) {
                                        print(value);
                                      },
                                      decoration: InputDecoration(
                                        //labelText: "Full Name",
                                        prefixIcon: const Icon(
                                          Icons.roller_shades_sharp,
                                          color: ThemeColors.icon,
                                        ),
                                        // labelStyle: const TextStyle(
                                        //   color: ThemeColors.highlight,
                                        // ),
                                        fillColor: Colors.white,
                                        // focusedBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(35.0),
                                        //   borderSide: const BorderSide(
                                        //     color: ThemeColors.bordertextfromfiled,
                                        //   ),
                                        // ),
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(25.0),
                                        //   borderSide: const BorderSide(
                                        //     color: Colors.black,
                                        //     width: 1.5,
                                        //   ),
                                        // ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: heightscreen * 0.04,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'My Name:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.icon,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Expanded(
                                        child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      readOnly: true,
                                      enabled: false,
                                      controller: fullnameController,
                                      keyboardType: TextInputType.text,
                                      onFieldSubmitted: (String value) {
                                        print(value);
                                      },
                                      decoration: InputDecoration(
                                        //labelText: "Full Name",
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: ThemeColors.icon,
                                        ),
                                        // labelStyle: const TextStyle(
                                        //   color: ThemeColors.highlight,
                                        // ),
                                        fillColor: Colors.white,
                                        // focusedBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(35.0),
                                        //   borderSide: const BorderSide(
                                        //     color: ThemeColors.bordertextfromfiled,
                                        //   ),
                                        // ),
                                        // enabledBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(25.0),
                                        //   borderSide: const BorderSide(
                                        //     color: Colors.black,
                                        //     width: 1.5,
                                        //   ),
                                        // ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 1.5,
                                          ),
                                        ),
                                        // errorBorder: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(25.0),
                                        //   borderSide: const BorderSide(
                                        //     color: Colors.red,
                                        //     width: 1.5,
                                        //   ),
                                        // ),
                                      ),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Please enter your first name';
                                      //   }
                                      //   if (RegExp(r"[!@#<>?':_`~ ١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
                                      //           .hasMatch(value) ||
                                      //       RegExp(r'[!@#<>?":_`~.,/;{}€£¥₩°•○●□■♤♡◇♧☆▪️¤《》¡¿$÷×[\]\\|=+)(*&^%0-9-]')
                                      //           .hasMatch(value)) {
                                      //     return 'Invalid first name';
                                      //   }
                                      //   if (value.length > 20) {
                                      //     return 'You reached the maximum length';
                                      //   }
                                      //   return null;
                                      // },
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: heightscreen * 0.04,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'My Email:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.icon,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        controller: emailController,
                                        readOnly: true,
                                        enabled: false,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onFieldSubmitted: (String value) {
                                          print(value);
                                        },
                                        decoration: InputDecoration(
                                          //labelText: "Your Email",
                                          prefixIcon: const Icon(
                                            Icons.email,
                                            color: ThemeColors.icon,
                                          ),
                                          labelStyle: const TextStyle(
                                            color: ThemeColors.highlight,
                                            fontSize: 25,
                                          ),
                                          fillColor: Colors.white,

                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(35.0),
                                            borderSide: const BorderSide(
                                              color: ThemeColors
                                                  .bordertextfromfiled,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          // errorBorder: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(25.0),
                                          //   borderSide: const BorderSide(
                                          //     color: Colors.red,
                                          //     width: 1.5,
                                          //   ),
                                          // ),
                                        ),
                                        // validator: (value) {
                                        //   if (!EmailValidator.validate(value!)) {
                                        //     return 'Please enter a valid Email';
                                        //   }
                                        //   return null;
                                        // },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: heightscreen * 0.04,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'My Phone:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColors.icon,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        readOnly: true,
                                        enabled: false,
                                        controller: numberController,
                                        keyboardType: TextInputType.phone,
                                        onFieldSubmitted: (String value) {
                                          print(value);
                                        },
                                        decoration: InputDecoration(
                                          //labelText: "Your phone",
                                          prefixIcon: const Icon(
                                            Icons.phone,
                                            color: ThemeColors.icon,
                                          ),
                                          // labelStyle: const TextStyle(
                                          //   color: ThemeColors.highlight,
                                          //   fontSize: 20,
                                          // ),
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(35.0),
                                            borderSide: const BorderSide(
                                              color: ThemeColors
                                                  .bordertextfromfiled,
                                            ),
                                          ),
                                          // enabledBorder: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(25.0),
                                          //   borderSide: const BorderSide(
                                          //     color: Colors.black,
                                          //     width: 1.5,
                                          //   ),
                                          // ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your number';
                                          }
                                          if (RegExp(
                                                  r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                              .hasMatch(value)) {
                                            return 'Wrong number';
                                          }
                                          if (value.length > 10 ||
                                              value.length < 10) {
                                            return 'Invalid number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: heightscreen * 0.03),
                                Container(
                                  height: 70,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color.fromARGB(180, 205, 171, 221),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'My balance :',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          '${model.data!.user!.balance.toString()}\$',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: heightscreen * 0.03),
                                Container(
                                  height: 50,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: const RadialGradient(
                                        radius: 4,
                                        colors: [
                                          Color.fromARGB(255, 141, 68, 243),
                                          Colors.purple
                                        ]),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 163, 33, 243),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      // highlightColor: Colors.orange.withOpacity(0.3),
                                      splashColor: ThemeColors.splashinkweel,
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () {
                                        ConsultingCubit.get(context).logout();
                                      },
                                      child: const Center(
                                          child: Text(
                                        'Log out',
                                        style: TextStyle(
                                          color: ThemeColors.backgroundColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    ),
                                  ),
                                ),
                                SizedBox(height: heightscreen * 0.04),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )
              : Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: ThemeColors.icons),
              backgroundColor: ThemeColors.backgroundColor,
              /*leading: Icon(

                          Icons.menu,
                          color: ThemeColors.icons,


                    ),*/
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: ThemeColors.icons,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.message,
                    color: ThemeColors.icons,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/messege');
                  },
                ),
              ],
              elevation: 0.0,
            ),
            backgroundColor: ThemeColors.backgroundColor,
            drawer: Drawer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: heightscreen * 0.07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              size: 50,
                              color: Colors.deepPurple,
                            ),
                            SizedBox(
                              width: widthscreen * 0.01,
                            ),
                            Text('Settings',
                                style: TextStyle(
                                    fontSize: 27,
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(
                          height: heightscreen * 0.05,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.language,
                              size: 30,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              width: widthscreen * 0.01,
                            ),
                            Text('Language',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),),
                          ],
                        ),
                        SizedBox(
                          height: heightscreen * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: heightscreen * 0.05,
                              width: widthscreen * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: switchValue
                                    ? Colors.white
                                    : ThemeColors.backgroundColor,
                              ),
                              child: Center(
                                child: Text(
                                  'English',
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                            Switch(
                              value: switchValue,
                              onChanged: (value) async{
                                ConsultingCubit.get(context).changeLanguage(value,context);
                                await switchValue?context.setLocale(Locale('ar')):context.setLocale(Locale('en'));
                              },
                              inactiveThumbColor: Colors.purple,
                              inactiveTrackColor: Colors.purple,
                              activeTrackColor: ThemeColors.highlight,
                              activeColor: ThemeColors.highlight,
                            ),
                            Container(
                              height: heightscreen * 0.05,
                              width: widthscreen * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: switchValue
                                    ? ThemeColors.backgroundColor
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  'Arabic',
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: heightscreen * 0.1,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                          Icon(
                            Icons.info,
                            size: 30,
                            color: Colors.purple,
                          ),
                          SizedBox(
                            width: widthscreen * 0.01,
                          ),
                          Text('About us',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),),
                        ],),
                        SizedBox(
                          height: heightscreen * 0.03,
                        ),
                        Text('This app was created by the developers Bassam,Batoul,Rajaei and Obada(BBRO).           You can sign up as a User or an Expert, then sell and buy some services of different types. We are so glad by offer this app that can be used on your phone',style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 2)),
                      ],
                    ),
                  ),
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${5}',
                            //'${model.data.expert.expertInfo.rate}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                            size: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 65.0,
                                      backgroundColor:
                                      Color.fromARGB(255, 200, 119, 238),
                                    ),
                                    Container(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/images/imageprofile.jpeg",
                                              width: 115,
                                              height: 115,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: heightscreen * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'My Role:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.icon,
                                ),
                              ),
                              SizedBox(
                                width: 29,
                              ),
                              Container(
                                height: 50,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  enabled: false,
                                  controller: roleController,
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  decoration: InputDecoration(
                                    //labelText: "Full Name",
                                    prefixIcon: const Icon(
                                      Icons.roller_shades_sharp,
                                      color: ThemeColors.icon,
                                    ),
                                    // labelStyle: const TextStyle(
                                    //   color: ThemeColors.highlight,
                                    // ),
                                    fillColor: Colors.white,
                                    // focusedBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(35.0),
                                    //   borderSide: const BorderSide(
                                    //     color: ThemeColors.bordertextfromfiled,
                                    //   ),
                                    // ),
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(25.0),
                                    //   borderSide: const BorderSide(
                                    //     color: Colors.black,
                                    //     width: 1.5,
                                    //   ),
                                    // ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightscreen * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                'My Name:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.icon,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 50,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  enabled: false,
                                  controller: fullnameController,
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  decoration: InputDecoration(
                                    //labelText: "Full Name",
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: ThemeColors.icon,
                                    ),
                                    // labelStyle: const TextStyle(
                                    //   color: ThemeColors.highlight,
                                    // ),
                                    fillColor: Colors.white,
                                    // focusedBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(35.0),
                                    //   borderSide: const BorderSide(
                                    //     color: ThemeColors.bordertextfromfiled,
                                    //   ),
                                    // ),
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(25.0),
                                    //   borderSide: const BorderSide(
                                    //     color: Colors.black,
                                    //     width: 1.5,
                                    //   ),
                                    // ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    // errorBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(25.0),
                                    //   borderSide: const BorderSide(
                                    //     color: Colors.red,
                                    //     width: 1.5,
                                    //   ),
                                    // ),
                                  ),
                                  // validator: (value) {
                                  //                                         if (value!.isEmpty) {
                                  //                                           return 'Please enter your first name';
                                  //                                         }
                                  //                                         if (RegExp(r"[!@#<>?':_`~ ١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
                                  //                                                 .hasMatch(value) ||
                                  //                                             RegExp(r'[!@#<>?":_`~.,/;{}،؟ًٌٍَُِّْ😅❤️🤩🔥👑🎉💙🤣💔👋💻😁🙋🤍🤝😂💪🌷🇦🇷👍🤦💚😍😥❤️🥳♾️🥰❤️🤗😘😪❤️❤️❤️❤️😬🤬❤️❤️€£¥₩°•○●□■♤♡◇♧☆▪️¤《》¡¿$÷×[\]\\|=+)(*&^%0-9-]')
                                  //                                                 .hasMatch(value)) {
                                  //                                           return 'Invalid first name';
                                  //                                         }
                                  //
                                  //
                                  //                                         if (value.length > 20) {
                                  //                                           return 'You reached the maximum length';
                                  //                                         }
                                  //                                         return null;
                                  //                                       },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightscreen * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                'My Email:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.icon,
                                ),
                              ),
                              SizedBox(
                                width: 22,
                              ),
                              Container(
                                height: heightscreen*0.08,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  controller: emailController,
                                  readOnly: true,
                                  enabled: false,
                                  keyboardType: TextInputType.emailAddress,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  decoration: InputDecoration(
                                    //labelText: "Your Email",
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: ThemeColors.icon,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: ThemeColors.highlight,
                                      fontSize: 25,
                                    ),
                                    fillColor: Colors.white,

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                      borderSide: const BorderSide(
                                        color: ThemeColors.bordertextfromfiled,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    // errorBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(25.0),
                                    //   borderSide: const BorderSide(
                                    //     color: Colors.red,
                                    //     width: 1.5,
                                    //   ),
                                    // ),
                                  ),
                                  // validator: (value) {
                                  //   if (!EmailValidator.validate(value!)) {
                                  //     return 'Please enter a valid Email';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightscreen * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                'My Phone:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.icon,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 50,
                                width: 250,
                                child: TextFormField(
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  readOnly: true,
                                  enabled: false,
                                  controller: numberController,
                                  keyboardType: TextInputType.phone,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  decoration: InputDecoration(
                                    //labelText: "Your phone",
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: ThemeColors.icon,
                                    ),
                                    // labelStyle: const TextStyle(
                                    //   color: ThemeColors.highlight,
                                    //   fontSize: 20,
                                    // ),
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                      borderSide: const BorderSide(
                                        color: ThemeColors.bordertextfromfiled,
                                      ),
                                    ),
                                    // enabledBorder: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(25.0),
                                    //   borderSide: const BorderSide(
                                    //     color: Colors.black,
                                    //     width: 1.5,
                                    //   ),
                                    // ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: heightscreen * 0.04),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'My Services',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    backgroundColor:
                                    Color.fromARGB(50, 105, 22, 135),
                                    // backgroundColor: Color.fromARGB(
                                    //   100,
                                    //   172,
                                    //   122,
                                    //   183,
                                    // ),
                                    // color: Color.fromARGB(255, 172, 122, 183),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: heightscreen * 0.03,
                          ),
                          Column(
                            children: [
                              Container(
                                color: ThemeColors.backgroundColor,
                                child: CheckboxListTile(
                                  enabled: false,
                                  activeColor: Colors.deepPurple,

                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Medicene',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                          Color.fromARGB(255, 105, 22, 135),
                                          //backgroundColor: Color.fromARGB(80, 172, 122, 183),
                                        ),
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        controller: medicinePriceController,
                                        enabled: false,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            color: ThemeColors.highlight,
                                          ),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              ThemeColors.bordertextfromfiled,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          labelText: 'price',
                                          prefixIcon: Icon(
                                            Icons.price_change_outlined,
                                            color: ThemeColors.icon,
                                          ),
                                          suffixStyle:
                                          TextStyle(color: Colors.grey),
                                          suffixText: '\$',
                                        ),
                                      ),
                                    ],
                                  ),

                                  value: isMedecine,
                                  onChanged: (newbool) {
                                    setState(() {});
                                  },
                                  // activeColor: Color.fromARGB(255, 80, 185, 166),
                                  // checkColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: heightscreen * 0.01,
                              ),
                              Container(
                                color: ThemeColors.backgroundColor,
                                child: CheckboxListTile(
                                  enabled: false,
                                  activeColor: Colors.deepPurple,

                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Career',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                          Color.fromARGB(255, 105, 22, 135),
                                        ),
                                      ),
                                      TextFormField(
                                        enabled: false,
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        controller: careerPriceController,
                                        keyboardType: TextInputType.number,
                                        cursorColor: ThemeColors.highlight,
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            color: ThemeColors.highlight,
                                          ),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              ThemeColors.bordertextfromfiled,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          labelText: 'price',
                                          prefixIcon: Icon(
                                            Icons.price_change_outlined,
                                            color: ThemeColors.icon,
                                          ),
                                          suffixStyle:
                                          TextStyle(color: Colors.grey),
                                          suffixText: "\$",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty &&
                                              isCareer == true) {
                                            return 'Enter price';
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) {},
                                      ),
                                    ],
                                  ),
                                  value: isCareer,
                                  onChanged: (newbool) {
                                    setState(() {});
                                  },
                                  // activeColor: Color.fromARGB(255, 80, 185, 166),
                                  // checkColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: heightscreen * 0.01,
                              ),
                              Container(
                                color: ThemeColors.backgroundColor,
                                child: CheckboxListTile(
                                  enabled: false,
                                  activeColor: Colors.deepPurple,

                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Psychology',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                          Color.fromARGB(255, 105, 22, 135),
                                        ),
                                      ),
                                      TextFormField(
                                        enabled: false,
                                        cursorColor: ThemeColors.highlight,
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        controller: psychologyPriceController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            color: ThemeColors.highlight,
                                          ),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              ThemeColors.bordertextfromfiled,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          labelText: 'price',
                                          prefixIcon: Icon(
                                            Icons.price_change_outlined,
                                            color: ThemeColors.icon,
                                          ),
                                          suffixStyle:
                                          TextStyle(color: Colors.grey),
                                          suffixText: "\$",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty &&
                                              isPsychology == true) {
                                            return 'Enter price';
                                          }
                                          return null;
                                        },
                                        onFieldSubmitted: (value) {},
                                      ),
                                    ],
                                  ),
                                  value: isPsychology,
                                  onChanged: (newbool) {},
                                  // activeColor: Color.fromARGB(255, 80, 185, 166),
                                  // checkColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: heightscreen * 0.01,
                              ),
                              Container(
                                color: ThemeColors.backgroundColor,
                                child: CheckboxListTile(
                                  enabled: false,
                                  activeColor: Colors.deepPurple,

                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Family',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                          Color.fromARGB(255, 105, 22, 135),
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        cursorColor: ThemeColors.highlight,
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        onFieldSubmitted: (value) {},
                                        controller: familyPriceController,
                                        keyboardType: TextInputType.number,
                                        enabled: isFamily,
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            color: ThemeColors.highlight,
                                          ),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              ThemeColors.bordertextfromfiled,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          labelText: 'price',
                                          prefixIcon: Icon(
                                            Icons.price_change_outlined,
                                            color: ThemeColors.icon,
                                          ),
                                          suffixStyle:
                                          TextStyle(color: Colors.grey),
                                          suffixText: "\$",
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty &&
                                              isFamily == true) {
                                            return 'Enter price';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  value: isFamily,
                                  onChanged: (newbool) {
                                    setState(() {});
                                  },
                                  // activeColor: Color.fromARGB(255, 80, 185, 166),
                                  // checkColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: heightscreen * 0.01,
                              ),
                              Container(
                                color: ThemeColors.backgroundColor,
                                child: CheckboxListTile(
                                  enabled: false,
                                  activeColor: Colors.deepPurple,
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Management',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800,
                                          color:
                                          Color.fromARGB(255, 105, 22, 135),
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      TextFormField(
                                        enabled: false,
                                        cursorColor: ThemeColors.highlight,
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        controller: managementPriceController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelStyle: TextStyle(
                                            color: ThemeColors.highlight,
                                          ),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              ThemeColors.bordertextfromfiled,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          labelText: 'price',
                                          prefixIcon: Icon(
                                            Icons.price_change_outlined,
                                            color: ThemeColors.icon,
                                          ),
                                          suffixStyle:
                                          TextStyle(color: Colors.grey),
                                          suffixText: "\$",
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: isManagement,
                                  onChanged: (newbool) {
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                               // reverse: true,
                                itemCount: OtherNamesController.length,
                                itemBuilder: (context, index) => addCatergory(index),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'My Address',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      backgroundColor:
                                      Color.fromARGB(50, 105, 22, 135),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: heightscreen * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                        enabled: false,
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        controller: countryController,
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted: (String value) {
                                          print(value);
                                        },
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.place_outlined,
                                            color: Colors.deepPurple,
                                          ),
                                          labelStyle: TextStyle(
                                            color: ThemeColors.highlight,
                                          ),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeColors.bordertextfromfiled,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          labelText: 'country',
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        controller: cityController,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        onFieldSubmitted: (String value) {
                                          print(value);
                                        },
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.place_outlined,
                                            color: Colors.deepPurple,
                                          ),
                                          labelStyle: TextStyle(
                                            color: ThemeColors.highlight,
                                          ),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ThemeColors.bordertextfromfiled,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          labelText: 'city',
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: heightscreen * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'My Experience',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      backgroundColor:
                                      Color.fromARGB(50, 105, 22, 135),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: heightscreen * 0.02,
                              ),
                              TextFormField(
                                enabled: false,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                controller: descriptionController,
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                // minLines: null,
                                decoration: InputDecoration(
                                  labelText: "Description",
                                  prefixIcon: const Icon(
                                    Icons.info,
                                    color: ThemeColors.icon,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: ThemeColors.highlight,
                                  ),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                    borderSide: const BorderSide(
                                      color: ThemeColors.bordertextfromfiled,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                cursorColor: ThemeColors.highlight,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Write your experience';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: heightscreen * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'My Scheduale',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      backgroundColor:
                                      Color.fromARGB(50, 105, 22, 135),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: heightscreen * 0.03,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Column(children: [
                                      const Text('Sunday'),
                                      Checkbox(

                                        activeColor: Colors.deepPurple,
                                        value: isSunday,
                                        onChanged: (newbool) {},
                                      ),
                                      // Checkbox(value: value, onChanged: onChanged)
                                    ]),
                                    SizedBox(
                                      width: widthscreen * 0.05,
                                    ),
                                    Column(children: [
                                      const Text('Monday'),
                                      Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: isMonday,
                                        onChanged: (newbool) {},
                                      ),
                                      // Checkbox(value: value, onChanged: onChanged)
                                    ]),
                                    SizedBox(
                                      width: widthscreen * 0.05,
                                    ),
                                    Column(children: [
                                      const Text('Tuesday'),
                                      Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: isTuesday,
                                        onChanged: (newbool) {},
                                      ),
                                      // Checkbox(value: value, onChanged: onChanged)
                                    ]),
                                    SizedBox(
                                      width: widthscreen * 0.05,
                                    ),
                                    Column(children: [
                                      const Text('Wednesday'),
                                      Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: isWednesday,
                                        onChanged: (newbool) {},
                                      ),
                                      // Checkbox(value: value, onChanged: onChanged)
                                    ]),
                                    SizedBox(
                                      width: widthscreen * 0.05,
                                    ),
                                    Column(children: [
                                      const Text('Thursday'),
                                      Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: isThursday,
                                        onChanged: (newbool) {},
                                      ),
                                      // Checkbox(value: value, onChanged: onChanged)
                                    ]),
                                    SizedBox(
                                      width: widthscreen * 0.05,
                                    ),
                                    Column(children: [
                                      const Text('Friday'),
                                      Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: isFriday,
                                        onChanged: (newbool) {},
                                      ),
                                      // Checkbox(value: value, onChanged: onChanged)
                                    ]),
                                    SizedBox(
                                      width: widthscreen * 0.05,
                                    ),
                                    Column(children: [
                                      const Text('Saturday'),
                                      Checkbox(
                                        activeColor: Colors.deepPurple,
                                        value: isSaturday,
                                        onChanged: (newbool) {},
                                      ),

                                      // Checkbox(value: value, onChanged: onChanged)
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightscreen * 0.02,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            //reverse: true,
                            itemCount: starttimesController.length,
                            itemBuilder: (context, index) => Addtime(index),
                          ),
                          SizedBox(
                            height: heightscreen * 0.02,
                          ),
                          Container(
                            height: 70,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(180, 205, 171, 221),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'My balance :',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${model.data!.user!.balance.toString()}\$',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: heightscreen * 0.03),
                          Container(
                            height: 60,
                            width: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const RadialGradient(radius: 4, colors: [
                                Colors.deepPurple,
                                Colors.purple
                              ]),
                              border: Border.all(
                                color: const Color.fromARGB(255, 163, 33, 243),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                // highlightColor: Colors.orange.withOpacity(0.3),
                                splashColor: ThemeColors.splashinkweel,
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  ReservationHistoryCubit.get(context).getExpertReservations();
                                  Navigator.of(context).pushNamed('/reservation_history');
                                },
                                child: const Center(
                                    child: Text(
                                      'Reservations history',
                                      style: TextStyle(
                                        color: ThemeColors.backgroundColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(height: heightscreen * 0.03),
                          Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const RadialGradient(radius: 4, colors: [
                                Color.fromARGB(255, 141, 68, 243),
                                Colors.purple
                              ]),
                              border: Border.all(
                                color: const Color.fromARGB(255, 163, 33, 243),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                // highlightColor: Colors.orange.withOpacity(0.3),
                                splashColor: ThemeColors.splashinkweel,
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  ConsultingCubit.get(context).logout();
                                },
                                child: const Center(
                                    child: Text(
                                      'Log out',
                                      style: TextStyle(
                                        color: ThemeColors.backgroundColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          // IconButton(
                          //     onPressed: () => Navigator.of(context)
                          //         .pushReplacementNamed('/expertRegister'),
                          //     icon: Icon(Icons.add)),
                          SizedBox(height: heightscreen * 0.04),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),

          ),
          fallback: (context) => CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      },
    );
  }

  Widget addCatergory(int index) {
    return Column(
      children: [
        TextFormField(
          controller: OtherNamesController[index],
          cursorColor: ThemeColors.highlight,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelStyle: TextStyle(
              color: ThemeColors.highlight,
            ),
            fillColor: Colors.white,
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ThemeColors.bordertextfromfiled,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            labelText: 'your consultation',
            prefixIcon: Icon(
              Icons.work_outline,
              color: ThemeColors.icon,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your first name';
            }
            if (RegExp(r"[!@#<>?':_`~ ١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
                .hasMatch(value) ||
                RegExp(r'[!@#<>?":_`~.,/;{}،؟ًٌٍَُِّْ😅❤️🤩🔥👑🎉💙🤣💔👋💻😁🙋🤍🤝😂💪🌷🇦🇷👍🤦💚😍😥❤️🥳♾️🥰❤️🤗😘😪❤️❤️❤️❤️😬🤬❤️❤️€£¥₩°•○●□■♤♡◇♧☆▪️¤《》¡¿$÷×[\]\\|=+)(*&^%0-9-]')
                    .hasMatch(value)) {
              return 'Invalid first name';
            }

            if (value.length > 20) {
              return 'You reached the maximum length';
            }
            return null;
          },
        ),
        TextFormField(
          controller: OtherPricesController[index],
          cursorColor: ThemeColors.highlight,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            suffixStyle: TextStyle(color: Colors.grey),
            suffixText: "\$",
            labelStyle: TextStyle(
              color: ThemeColors.highlight,
            ),
            fillColor: Colors.white,
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ThemeColors.bordertextfromfiled,
              ),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            labelText: 'price',
            prefixIcon: Icon(
              Icons.price_change_outlined,
              color: ThemeColors.icon,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter price';
            }
            if (RegExp(r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                .hasMatch(value)) {
              return 'Wrong price';
            }
            if (value.length > 5) {
              return 'People are poor :(';
            }
            if (value[0] == '0') {
              return 'Invalid price';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget Addtime(int index) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 50,
              child: TextFormField(
                  controller: starttimesController[index],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    suffixStyle:
                    const TextStyle(color: Colors.grey, fontSize: 16),
                    suffixText: ":00",
                    labelText: "Start Time",
                    labelStyle: const TextStyle(
                      color: ThemeColors.highlight,
                    ),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: ThemeColors.bordertextfromfiled,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 1.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                  ),
                  cursorColor: ThemeColors.highlight,
                  maxLength: 2,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "It's empty!";
                    }
                    if (RegExp(r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                        .hasMatch(value)) {
                      return 'Invalid start time';
                    }
                    if (value.length > 1) {
                      if (value[0] == '0') {
                        return 'Invalid start time';
                      }
                    }
                    if (int.parse(value) < 0 || int.parse(value) > 23) {
                      return 'Invalid start time';
                    }
                    if (RegExp(r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                        .hasMatch(endtimesController[index].text)) {
                      return 'Invalid start time';
                    }
                    if(endtimesController[index].text.isNotEmpty) {
                      if (int.parse(value) >=
                          int.parse(endtimesController[index].text)) {
                        return 'Invalid start time';
                      }
                    }
                    return null;
                  }
                /* validator: (value) {
                  if (value!.isEmpty) {
                    return "It's empty!";
                  }
                  if (value[value.length - 1] == '.' ||
                      value[value.length - 1] == '-') {
                    return 'Invalid start time';
                  } else if (value.length > 1) {
                    if (value[value.length - 2] == '.' ||
                        value[value.length - 2] == '0' ||
                        value[value.length - 2] == '-') {
                      return 'Invalid start time';
                    } else if (int.parse(value) < 0 || int.parse(value) > 23) {
                      return 'Invalid start time';
                    } else if (endtimesController[index].text != '') {
                      if (endtimesController[index].text.length == 1) {
                        if (endTimeController.text[0] == '.' ||
                            endtimesController[index].text[0] == '-') {
                          return 'Invalid start time';
                        }
                        if (int.parse(value) >=
                            int.parse(endtimesController[index].text)) {
                          return 'Invalid start time';
                        }
                      } else {
                        if (endtimesController[index].text[0] == '.' ||
                            endtimesController[index].text[0] == '-') {
                          return 'Invalid start time';
                        }
                        if (endtimesController[index].text[1] == '.' ||
                            endtimesController[index].text[1] == '-') {
                          return 'Invalid start time';
                        }
                        if (int.parse(value) >=
                            int.parse(endtimesController[index].text)) {
                          return 'Invalid start time';
                        }
                      }
                    }
                  } else if (endtimesController[index].text != '') {
                    if (endtimesController[index].text.length == 1) {
                      if (endtimesController[index].text[0] == '.' ||
                          endtimesController[index].text[0] == '-') {
                        return 'Invalid start time';
                      }
                      if (int.parse(value) >=
                          int.parse(endtimesController[index].text)) {
                        return 'Invalid start time';
                      }
                    } else {
                      if (endtimesController[index].text[0] == '.' ||
                          endtimesController[index].text[0] == '-') {
                        return 'Invalid start time';
                      }
                      if (endtimesController[index].text[1] == '.' ||
                          endtimesController[index].text[1] == '-') {
                        return 'Invalid start time';
                      }
                      if (int.parse(value) >=
                          int.parse(endtimesController[index].text)) {
                        return 'Invalid start time';
                      }
                    }
                  }

                  return null;
                },*/
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                width: 120,
                height: 50,
                child: TextFormField(
                    controller: endtimesController[index],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      suffixStyle:
                      const TextStyle(color: Colors.grey, fontSize: 16),
                      suffixText: ":00",
                      labelText: "End Time",
                      labelStyle: const TextStyle(
                        color: ThemeColors.highlight,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: ThemeColors.bordertextfromfiled,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                        const BorderSide(color: Colors.black, width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                    ),
                    maxLength: 2,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: ThemeColors.highlight,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "It's empty!";
                      }
                      if (RegExp(r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                          .hasMatch(value)) {
                        return 'Invalid end time';
                      }
                      if (value.length > 1) {
                        if (value[0] == '0') {
                          return 'Invalid end time';
                        }
                      }
                      if (int.parse(value) < 0 || int.parse(value) > 23) {
                        return 'Invalid end time';
                      }
                      if (RegExp(r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                          .hasMatch(starttimesController[index].text)) {
                        return 'Invalid end time';
                      }
                      if(starttimesController[index].text.isNotEmpty) {
                        if (int.parse(value) <=
                            int.parse(starttimesController[index].text)) {
                          return 'Invalid end time';
                        }
                      }
                      return null;
                    }
                  /*validator: (value) {
                    if (value!.isEmpty) {
                      return "It's empty!";
                    }
                    if (value[value.length - 1] == '.' ||
                        value[value.length - 1] == '-') {
                      return 'Invalid end time';
                    } else if (value.length > 1) {
                      if (value[value.length - 2] == '.' ||
                          value[value.length - 2] == '0' ||
                          value[value.length - 2] == '-') {
                        return 'Invalid end time';
                      } else if (int.parse(value) < 0 ||
                          int.parse(value) > 23) {
                        return 'Invalid end time';
                      } else if (starttimesController[index].text != '') {
                        if (starttimesController[index].text.length == 1) {
                          if (starttimesController[index].text[0] == '.' ||
                              starttimesController[index].text[0] == '-') {
                            return 'Invalid end time';
                          }
                          if (int.parse(value) <=
                              int.parse(starttimesController[index].text)) {
                            return 'Invalid end time';
                          }
                        } else {
                          if (starttimesController[index].text[0] == '.' ||
                              starttimesController[index].text[0] == '-') {
                            return 'Invalid end time';
                          }
                          if (starttimesController[index].text[1] == '.' ||
                              starttimesController[index].text[1] == '-') {
                            return 'Invalid end time';
                          }
                          if (int.parse(value) <=
                              int.parse(starttimesController[index].text)) {
                            return 'Invalid end time';
                          }
                        }
                      }
                    } else if (starttimesController[index].text != '') {
                      if (starttimesController[index].text.length == 1) {
                        if (starttimesController[index].text[0] == '.' ||
                            starttimesController[index].text[0] == '-') {
                          return 'Invalid end time';
                        }
                        if (int.parse(value) <=
                            int.parse(starttimesController[index].text)) {
                          return 'Invalid end time';
                        }
                      } else {
                        if (starttimesController[index].text[0] == '.' ||
                            starttimesController[index].text[0] == '-') {
                          return 'Invalid end time';
                        }
                        if (starttimesController[index].text[1] == '.' ||
                            starttimesController[index].text[1] == '-') {
                          return 'Invalid end time';
                        }
                        if (int.parse(value) <=
                            int.parse(starttimesController[index].text)) {
                          return 'Invalid end time';
                        }
                      }
                    }

                    return null;
                  },*/
                )),
            const SizedBox(
              width: 10,
            ),
            Container(),
          ],
        ),
      ],
    );
  }

}
