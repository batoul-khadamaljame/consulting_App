import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/Bloc/register/register_state.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/userRegister_screen.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class ExpertRegisterScreen extends StatefulWidget {
  const ExpertRegisterScreen({super.key});

  @override
  State<ExpertRegisterScreen> createState() => _ExpertRegisterScreenState();
}

class _ExpertRegisterScreenState extends State<ExpertRegisterScreen> {

  //category
  bool? isMedecine = false;
  bool? isCareer = false;
  bool? isPsychology = false;
  bool? isFamily = false;
  bool? isManagement = false;

//days
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

  void initState(){
    medicinePriceController.clear();
    careerPriceController.clear();
    psychologyPriceController.clear();
    familyPriceController.clear();
    managementPriceController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.loginModel.status!) {
            print(state.loginModel.status!);
            print(state.loginModel!.data!.token);
            print(state.loginModel.data!.expert!.expertInfo!.country);
            print(state.loginModel.data!.expert!.expertInfo!.city);
            print(state.loginModel.data!.expert!.expertInfo!.skills);
            print(state.loginModel.data!.expert!.days!.sunday);
            print(state.loginModel.data!.expert!.days!.monday);
            print(state.loginModel.data!.expert!.days!.tuesday);
            print(state.loginModel.data!.expert!.days!.wednesday);
            print(state.loginModel.data!.expert!.days!.thursday);
            print(state.loginModel.data!.expert!.days!.friday);
            print(state.loginModel.data!.expert!.days!.saturday);
            print(state.loginModel.data!.expert!.experiences!.length);
            for (int i = 0;
                i < state.loginModel.data!.expert!.experiences!.length;
                i++) {
              print(state.loginModel.data!.expert!.experiences![i].category_id);
              print(
                  state.loginModel.data!.expert!.experiences![i].category_name);
              print(state.loginModel.data!.expert!.experiences![i].price);
            }
            for (int i = 0;
                i < state.loginModel.data!.expert!.duration!.length;
                i++) {
              print(state.loginModel.data!.expert!.duration![i].from);
              print(state.loginModel.data!.expert!.duration![i].to);
            }

            showToast(
              text: state.loginModel.message!,
              state: ToastState.success,
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.data!.token,
            ).then((value) {
              token = state.loginModel.data!.token;
              cubit.ExpertPhotoRegister();
            });
          } else {
            cubit.days.clear();
            medicinePriceController.clear();
            careerPriceController.clear();
            psychologyPriceController.clear();
            familyPriceController.clear();
            managementPriceController.clear();
            cubit.services.clear();
            cubit.times.clear();
            print(state.loginModel.status!);


            showToast(
              text: state.loginModel.message!,
              state: ToastState.error,
            );
            Navigator.pop(context);
          }
        }
        if (state is RegisterPhotoSuccessState){
          if(RegisterCubit.get(context).photoModel!.status== false){
            cubit.days.clear();
            medicinePriceController.clear();
            careerPriceController.clear();
            psychologyPriceController.clear();
            familyPriceController.clear();
            managementPriceController.clear();
            cubit.services.clear();
            cubit.times.clear();
            print(state.photoModel.status!);
          }
          else{
          ConsultingCubit.get(context).indx();
          ConsultingCubit.get(context).getHomeDataToken(0);
          Navigator.of(context).pushReplacementNamed('/home');
        }}
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeColors.backgroundColor,
          appBar: null,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      'More information',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 84, 44, 147)),
                    ),
                    SizedBox(
                      height: heightscreen * 0.03,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Choose the services you offer',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              backgroundColor: Color.fromARGB(50, 105, 22, 135),
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
                            activeColor: Colors.deepPurple,

                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Medicene',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 105, 22, 135),
                                    //backgroundColor: Color.fromARGB(80, 172, 122, 183),
                                  ),
                                ),
                                TextFormField(
                                  controller: medicinePriceController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  enabled: isMedecine,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      color: ThemeColors.highlight,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeColors.bordertextfromfiled,
                                      ),
                                    ),
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: isMedecine == true
                                        ? const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    labelText: 'price',
                                    prefixIcon: const Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle:
                                        const TextStyle(color: Colors.grey),
                                    suffixText: '\$',
                                  ),
                                  validator: (value) {
                                    if (isMedecine == false &&
                                        isCareer == false &&
                                        isPsychology == false &&
                                        isFamily == false &&
                                        isManagement == false &&
                                        OtherNamesController.length == 0) {
                                      return 'You should offer one service at least';
                                    }
                                    if (value!.isEmpty && isMedecine == true) {
                                      return 'Enter price';
                                    }
                                    if (RegExp(
                                            r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                        .hasMatch(value)) {
                                      return 'Wrong price';
                                    }
                                    if (value.length > 5) {
                                      return 'People are poor :(';
                                    }
                                    if (isMedecine!) {
                                      if (value[0] == '0') {
                                        return 'Invalid price';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                            value: isMedecine,
                            onChanged: (newbool) {
                              setState(() {
                                isMedecine = newbool;
                                if (isMedecine == false) {
                                  medicinePriceController.clear();
                                }
                              });
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
                            activeColor: Colors.deepPurple,

                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Career',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 105, 22, 135),
                                  ),
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: careerPriceController,
                                  keyboardType: TextInputType.number,
                                  enabled: isCareer,
                                  cursorColor: ThemeColors.highlight,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      color: ThemeColors.highlight,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeColors.bordertextfromfiled,
                                      ),
                                    ),
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: isCareer == true
                                        ? const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    labelText: 'price',
                                    prefixIcon: const Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle:
                                        const TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty && isCareer == true) {
                                      return 'Enter price';
                                    }
                                    if (RegExp(
                                            r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                        .hasMatch(value)) {
                                      return 'Wrong price';
                                    }
                                    if (value.length > 5) {
                                      return 'People are poor :(';
                                    }

                                    if (isCareer!) {
                                      if (value[0] == '0') {
                                        return 'Invalid price';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            value: isCareer,
                            onChanged: (newbool) {
                              setState(() {
                                isCareer = newbool;
                                if (isCareer == false) {
                                  careerPriceController.clear();
                                }
                              });
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
                            activeColor: Colors.deepPurple,

                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Psychology',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 105, 22, 135),
                                  ),
                                ),
                                TextFormField(
                                  cursorColor: ThemeColors.highlight,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: psychologyPriceController,
                                  keyboardType: TextInputType.number,
                                  enabled: isPsychology,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      color: ThemeColors.highlight,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeColors.bordertextfromfiled,
                                      ),
                                    ),
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: isPsychology == true
                                        ? const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    labelText: 'price',
                                    prefixIcon: const Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle:
                                        const TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty &&
                                        isPsychology == true) {
                                      return 'Enter price';
                                    }
                                    if (RegExp(
                                            r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                        .hasMatch(value)) {
                                      return 'Wrong price';
                                    }
                                    if (value.length > 5) {
                                      return 'People are poor :(';
                                    }
                                    if (isPsychology!) {
                                      if (value[0] == '0') {
                                        return 'Invalid price';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            value: isPsychology,
                            onChanged: (newbool) {
                              setState(() {
                                isPsychology = newbool!;
                                if (isPsychology == false) {
                                  psychologyPriceController.clear();
                                }
                              });
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
                            activeColor: Colors.deepPurple,

                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Family',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 105, 22, 135),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                TextFormField(
                                  cursorColor: ThemeColors.highlight,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: familyPriceController,
                                  keyboardType: TextInputType.number,
                                  enabled: isFamily,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      color: ThemeColors.highlight,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeColors.bordertextfromfiled,
                                      ),
                                    ),
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: isFamily == true
                                        ? const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    labelText: 'price',
                                    prefixIcon: const Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle:
                                        const TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty && isFamily == true) {
                                      return 'Enter price';
                                    }
                                    if (RegExp(
                                            r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                        .hasMatch(value)) {
                                      return 'Wrong price';
                                    }
                                    if (value.length > 5) {
                                      return 'People are poor :(';
                                    }
                                    if (isFamily!) {
                                      if (value[0] == '0') {
                                        return 'Invalid price';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            value: isFamily,
                            onChanged: (newbool) {
                              setState(() {
                                isFamily = newbool;
                                if (isFamily == false) {
                                  familyPriceController.clear();
                                }
                              });
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
                            activeColor: Colors.deepPurple,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Management',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 105, 22, 135),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                TextFormField(
                                  cursorColor: ThemeColors.highlight,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: managementPriceController,
                                  keyboardType: TextInputType.number,
                                  enabled: isManagement,
                                  decoration: InputDecoration(
                                    labelStyle: const TextStyle(
                                      color: ThemeColors.highlight,
                                    ),
                                    fillColor: Colors.white,
                                    focusColor: Colors.white,
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ThemeColors.bordertextfromfiled,
                                      ),
                                    ),
                                    border: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    errorBorder: isManagement == true
                                        ? const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          )
                                        : null,
                                    labelText: 'price',
                                    prefixIcon: const Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle:
                                        const TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty &&
                                        isManagement == true) {
                                      return 'Enter price';
                                    }
                                    if (RegExp(
                                            r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                        .hasMatch(value)) {
                                      return 'Wrong price';
                                    }
                                    if (value.length > 5) {
                                      return 'People are poor :(';
                                    }
                                    if (isManagement!) {
                                      if (value[0] == '0') {
                                        return 'Invalid price';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            value: isManagement,
                            onChanged: (newbool) {
                              setState(() {
                                isManagement = newbool;
                                if (isManagement == false) {
                                  managementPriceController.clear();
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Others :',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 105, 22, 135),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 25,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const RadialGradient(
                                    radius: 4,
                                    colors: [
                                      Color.fromARGB(255, 141, 68, 243),
                                      Colors.purple
                                    ]),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 163, 33, 243),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  // highlightColor: Colors.orange.withOpacity(0.3),
                                  splashColor: ThemeColors.splashinkweel,
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    setState(() {
                                      addOtherCategoryController();
                                    });
                                  },
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 25,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const RadialGradient(
                                    radius: 4,
                                    colors: [
                                      Color.fromARGB(255, 141, 68, 243),
                                      Colors.purple
                                    ]),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 163, 33, 243),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  // highlightColor: Colors.orange.withOpacity(0.3),
                                  splashColor: ThemeColors.splashinkweel,
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    setState(() {
                                      if (OtherNamesController.length > 0) {
                                        deleteOtherCategoryController();
                                      }
                                    });
                                  },
                                  child: const Center(
                                      child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 22,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          //reverse: true,
                          itemCount: OtherNamesController.length,
                          itemBuilder: (context, index) => addCatergory(index),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightscreen * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Your Address',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            backgroundColor: Color.fromARGB(50, 105, 22, 135),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your country';
                            }
                            if (RegExp(r"[!@#<>?':_`~١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
                                    .hasMatch(value) ||
                                RegExp(r'[!@#<>?":_`~.,/;{}،؟ًٌٍَُِّْ😅❤️🤩🔥👑🎉💙🤣💔👋💻😁🙋🤍🤝😂💪🌷🇦🇷👍🤦💚😍😥❤️🥳♾️🥰❤️🤗😘😪❤️❤️❤️❤️😬🤬❤️❤️€£¥₩°•○●□■♤♡◇♧☆▪️¤《》¡¿$÷×[\]\\|=+)(*&^%0-9-]')
                                    .hasMatch(value)) {
                              return 'Invalid country';
                            }
                            if (value.length > 10) {
                              return 'You reached the maximum length';
                            }
                            return null;
                          },
                        )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: cityController,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your city';
                            }
                            if (RegExp(r"[!@#<>?':_`~١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
                                    .hasMatch(value) ||
                                RegExp(r'[!@#<>?":_`~.,/;{}،؟ًٌٍَُِّْ😅❤️🤩🔥👑🎉💙🤣💔👋💻😁🙋🤍🤝😂💪🌷🇦🇷👍🤦💚😍😥❤️🥳♾️🥰❤️🤗😘😪❤️❤️❤️❤️😬🤬❤️❤️€£¥₩°•○●□■♤♡◇♧☆▪️¤《》¡¿$÷×[\]\\|=+)(*&^%0-9-]')
                                    .hasMatch(value)) {
                              return 'Invalid city';
                            }
                            if (value.length > 10) {
                              return 'You reached the maximum length';
                            }
                            return null;
                          },
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
                          'Your Experience',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            backgroundColor: Color.fromARGB(50, 105, 22, 135),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightscreen * 0.02,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          'Select your available time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            backgroundColor: Color.fromARGB(50, 105, 22, 135),
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
                              onChanged: (newbool) {
                                setState(() {
                                  isSunday = newbool;
                                });
                              },
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
                              onChanged: (newbool) {
                                setState(() {
                                  isMonday = newbool;
                                });
                              },
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
                              onChanged: (newbool) {
                                setState(() {
                                  isTuesday = newbool;
                                });
                              },
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
                              onChanged: (newbool) {
                                setState(() {
                                  isWednesday = newbool;
                                });
                              },
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
                              onChanged: (newbool) {
                                setState(() {
                                  isThursday = newbool;
                                });
                              },
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
                              onChanged: (newbool) {
                                setState(() {
                                  isFriday = newbool;
                                });
                              },
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
                              onChanged: (newbool) {
                                setState(() {
                                  isSaturday = newbool;
                                });
                              },
                            ),
                            // Checkbox(value: value, onChanged: onChanged)
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: heightscreen * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          child: TextFormField(
                              controller: startTimeController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counterText: '',
                                suffixStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
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
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              maxLength: 2,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              cursorColor: ThemeColors.highlight,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "It's empty!";
                                }
                                if (RegExp(
                                        r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                    .hasMatch(value)) {
                                  return 'Invalid start time';
                                }
                                if (value.length > 1) {
                                  if (value[0] == '0') {
                                    return 'Invalid start time';
                                  }
                                }
                                if (int.parse(value) < 0 ||
                                    int.parse(value) > 23) {
                                  return 'Invalid start time';
                                }
                                if (RegExp(r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                        .hasMatch(endTimeController.text)) {
                                  return 'Invalid start time';
                                }
                                if(endTimeController.text.isNotEmpty) {
                                  if (int.parse(value) >=
                                      int.parse(endTimeController.text)) {
                                    return 'Invalid start time';
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
                                return 'Invalid start time';
                              } else if (value.length > 1) {
                                if (value[value.length - 2] == '.' ||
                                    value[value.length - 2] == '0' ||
                                    value[value.length - 2] == '-') {
                                  return 'Invalid start time';
                                } else if (int.parse(value) < 0 ||
                                    int.parse(value) > 23) {
                                  return 'Invalid start time';
                                } else if (endTimeController.text != '') {
                                  if (endTimeController.text.length == 1) {
                                    if (endTimeController.text[0] == '.' ||
                                        endTimeController.text[0] == '-') {
                                      return 'Invalid start time';
                                    }
                                    if (int.parse(value) >=
                                        int.parse(endTimeController.text)) {
                                      return 'Invalid start time';
                                    }
                                  } else {
                                    if (endTimeController.text[0] == '.' ||
                                        endTimeController.text[0] == '-') {
                                      return 'Invalid start time';
                                    }
                                    if (endTimeController.text[1] == '.' ||
                                        endTimeController.text[1] == '-') {
                                      return 'Invalid start time';
                                    }
                                    if (int.parse(value) >=
                                        int.parse(endTimeController.text)) {
                                      return 'Invalid start time';
                                    }
                                  }
                                }
                              } else if (endTimeController.text != '') {
                                if (endTimeController.text.length == 1) {
                                  if (endTimeController.text[0] == '.' ||
                                      endTimeController.text[0] == '-') {
                                    return 'Invalid start time';
                                  }
                                  if (int.parse(value) >=
                                      int.parse(endTimeController.text)) {
                                    return 'Invalid start time';
                                  }
                                } else {
                                  if (endTimeController.text[0] == '.' ||
                                      endTimeController.text[0] == '-') {
                                    return 'Invalid start time';
                                  }
                                  if (endTimeController.text[1] == '.' ||
                                      endTimeController.text[1] == '-') {
                                    return 'Invalid start time';
                                  }
                                  if (int.parse(value) >=
                                      int.parse(endTimeController.text)) {
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
                                controller: endTimeController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
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
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 1.5),
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
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "It's empty!";
                                  }
                                  if (RegExp(
                                          r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                      .hasMatch(value)) {
                                    return 'Invalid end time';
                                  }
                                  if (value.length > 1) {
                                    if (value[0] == '0') {
                                      return 'Invalid end time';
                                    }
                                  }
                                  if (int.parse(value) < 0 ||
                                      int.parse(value) > 23) {
                                    return 'Invalid end time';
                                  }
                                  if (RegExp(r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                      .hasMatch(startTimeController.text)) {
                                    return 'Invalid end time';
                                  }
                                  if(startTimeController.text.isNotEmpty) {
                                    if (int.parse(value) <=
                                        int.parse(startTimeController.text)) {
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
                                  } else if (startTimeController.text != '') {
                                    if (startTimeController.text.length == 1) {
                                      if (startTimeController.text[0] == '.' ||
                                          startTimeController.text[0] == '-') {
                                        return 'Invalid end time';
                                      }
                                      if (int.parse(value) <=
                                          int.parse(startTimeController.text)) {
                                        return 'Invalid end time';
                                      }
                                    } else {
                                      if (startTimeController.text[0] == '.' ||
                                          startTimeController.text[0] == '-') {
                                        return 'Invalid end time';
                                      }
                                      if (startTimeController.text[1] == '.' ||
                                          startTimeController.text[1] == '-') {
                                        return 'Invalid end time';
                                      }
                                      if (int.parse(value) <=
                                          int.parse(startTimeController.text)) {
                                        return 'Invalid end time';
                                      }
                                    }
                                  }
                                } else if (startTimeController.text != '') {
                                  if (startTimeController.text.length == 1) {
                                    if (startTimeController.text[0] == '.' ||
                                        startTimeController.text[0] == '-') {
                                      return 'Invalid end time';
                                    }
                                    if (int.parse(value) <=
                                        int.parse(startTimeController.text)) {
                                      return 'Invalid end time';
                                    }
                                  } else {
                                    if (startTimeController.text[0] == '.' ||
                                        startTimeController.text[0] == '-') {
                                      return 'Invalid end time';
                                    }
                                    if (startTimeController.text[1] == '.' ||
                                        startTimeController.text[1] == '-') {
                                      return 'Invalid end time';
                                    }
                                    if (int.parse(value) <=
                                        int.parse(startTimeController.text)) {
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
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const RadialGradient(
                                    radius: 4,
                                    colors: [
                                      Color.fromARGB(255, 141, 68, 243),
                                      Colors.purple
                                    ]),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 163, 33, 243),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  // highlightColor: Colors.orange.withOpacity(0.3),
                                  splashColor: ThemeColors.splashinkweel,
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    setState(() {
                                      if(starttimesController.length<12) {
                                        addOtherTimesController();
                                      }
                                    });
                                  },
                                  child: const Center(
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 25,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const RadialGradient(
                                    radius: 4,
                                    colors: [
                                      Color.fromARGB(255, 141, 68, 243),
                                      Colors.purple
                                    ]),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 163, 33, 243),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  // highlightColor: Colors.orange.withOpacity(0.3),
                                  splashColor: ThemeColors.splashinkweel,
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    setState(() {
                                      if (starttimesController.length > 0) {
                                        deleteOtherTimesController();
                                      }
                                    });
                                  },
                                  child: const Center(
                                      child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 22,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
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
                    Center(
                      child: Container(
                        height: 50,
                        width: 150,
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
                              if (formKey.currentState!.validate()) {
                                addServices(
                                    isMedecine!,
                                    isCareer!,
                                    isPsychology!,
                                    isFamily!,
                                    isManagement!,
                                    isSunday!,
                                    isMonday!,
                                    isTuesday!,
                                    isWednesday!,
                                    isThursday!,
                                    isFriday!,
                                    isSaturday!);

                                RegisterCubit.get(context).ExpertRegister(
                                  name: fullname,
                                  phone: numberController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  country: countryController.text,
                                  city: cityController.text,
                                  experience: descriptionController.text,
                                );
                              } else {
                                setState(() {
                                  isMedecine = true;
                                });
                              }
                            },
                            child: const Center(
                                child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: ThemeColors.backgroundColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
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
            if (RegExp(r"[!@#<>?':_`~١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
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
                  inputFormatters: [],
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
