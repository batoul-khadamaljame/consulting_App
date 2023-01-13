import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/Bloc/register/register_state.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/userRegister_screen.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:consulting_app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

var medicinePriceControllerRegister = TextEditingController();
var careerPriceControllerRegister = TextEditingController();
var psychologyPriceControllerRegister = TextEditingController();
var familyPriceControllerRegister = TextEditingController();
var managementPriceControllerRegister = TextEditingController();

List<TextEditingController> OtherNamesControllerRegister = [];
List<TextEditingController> OtherPricesControllerRegister = [];

var countryControllerRegister = TextEditingController();
var cityControllerRegister = TextEditingController();

var descriptionControllerRegister = TextEditingController();

var startTimeControllerRegister = TextEditingController();
var endTimeControllerRegister = TextEditingController();

List<TextEditingController> starttimesControllerRegister = [];
List<TextEditingController> endtimesControllerRegister = [];

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
    OtherNamesControllerRegister.add(TextEditingController());
    OtherPricesControllerRegister.add(TextEditingController());
    print(OtherNamesControllerRegister);
    print(OtherPricesControllerRegister);
  }

  void deleteOtherCategoryController() {
    OtherNamesControllerRegister.removeLast();
    OtherPricesControllerRegister.removeLast();
  }

  void addOtherTimesController() {
    starttimesControllerRegister.add(TextEditingController());
    endtimesControllerRegister.add(TextEditingController());
  }

  void deleteOtherTimesController() {
    starttimesControllerRegister.removeLast();
    endtimesControllerRegister.removeLast();
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
          .addService('1', 'Medicine', medicinePriceControllerRegister.text);
    }
    if (isCareer) {
      RegisterCubit.get(context)
          .addService('2', 'Career', careerPriceControllerRegister.text);
    }
    if (isPsychology) {
      RegisterCubit.get(context).addService(
          '3', 'Psychology', psychologyPriceControllerRegister.text);
    }
    if (isFamily) {
      RegisterCubit.get(context)
          .addService('4', 'Family', familyPriceControllerRegister.text);
    }
    if (isManagement) {
      RegisterCubit.get(context).addService(
          '5', 'Management', managementPriceControllerRegister.text);
    }

    for (int i = 0; i < OtherNamesControllerRegister.length; i++) {
      RegisterCubit.get(context).addService(
          '6',
          OtherNamesControllerRegister[i].text,
          OtherPricesControllerRegister[i].text);
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
    RegisterCubit.get(context).addTimes(
        startTimeControllerRegister.text, endTimeControllerRegister.text);
    for (int i = 0; i < starttimesControllerRegister.length; i++) {
      RegisterCubit.get(context).addTimes(starttimesControllerRegister[i].text,
          endtimesControllerRegister[i].text);
    }
  }

  void initState() {
    medicinePriceControllerRegister.clear();
    careerPriceControllerRegister.clear();
    psychologyPriceControllerRegister.clear();
    familyPriceControllerRegister.clear();
    managementPriceControllerRegister.clear();
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
            medicinePriceControllerRegister.clear();
            careerPriceControllerRegister.clear();
            psychologyPriceControllerRegister.clear();
            familyPriceControllerRegister.clear();
            managementPriceControllerRegister.clear();

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
        if (state is RegisterPhotoSuccessState) {
          if (RegisterCubit.get(context).photoModel!.status == false) {
            cubit.days.clear();
            medicinePriceControllerRegister.clear();
            careerPriceControllerRegister.clear();
            psychologyPriceControllerRegister.clear();
            familyPriceControllerRegister.clear();
            managementPriceControllerRegister.clear();
            cubit.services.clear();
            cubit.times.clear();
            Navigator.pop(context);
            showToast(
              text: state.photoModel.message!,
              state: ToastState.error,
            );
            print(state.photoModel.status!);
          } else {
            showToast(
              text: 'registered sucessfully',
              state: ToastState.success,
            );
            ConsultingCubit.get(context).indx();
            ConsultingCubit.get(context).getHomeDataToken(0);
            Navigator.of(context).pushReplacementNamed('/home');
          }
        }
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
                    Text(
                      LocaleKeys.More_information.tr(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 84, 44, 147)),
                    ),
                    SizedBox(
                      height: heightscreen * 0.03,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text(
                        LocaleKeys.Choose_the_services_you_offer.tr(),
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
                                Text(
                                  LocaleKeys.Medicine.tr(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 105, 22, 135),
                                    //backgroundColor: Color.fromARGB(80, 172, 122, 183),
                                  ),
                                ),
                                TextFormField(
                                  controller: medicinePriceControllerRegister,
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
                                    labelText: LocaleKeys.price.tr(),
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
                                        OtherNamesControllerRegister.length ==
                                            0) {
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
                                  medicinePriceControllerRegister.clear();
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
                                Text(
                                  LocaleKeys.Career.tr(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color.fromARGB(255, 105, 22, 135),
                                  ),
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: careerPriceControllerRegister,
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
                                    labelText: LocaleKeys.Price.tr(),
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
                                  careerPriceControllerRegister.clear();
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
                                Text(
                                  LocaleKeys.Psychology.tr(),
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
                                  controller: psychologyPriceControllerRegister,
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
                                    labelText: LocaleKeys.Price.tr(),
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
                                  psychologyPriceControllerRegister.clear();
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
                                Text(
                                  LocaleKeys.Family.tr(),
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
                                  controller: familyPriceControllerRegister,
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
                                    labelText: LocaleKeys.Price.tr(),
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
                                  familyPriceControllerRegister.clear();
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
                                Text(
                                  LocaleKeys.Management.tr(),
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
                                  controller: managementPriceControllerRegister,
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
                                    labelText: LocaleKeys.Price.tr(),
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
                                  managementPriceControllerRegister.clear();
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
                            Text(
                              LocaleKeys.Others.tr(),
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
                                      if (OtherNamesControllerRegister.length >
                                          0) {
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
                          itemCount: OtherNamesControllerRegister.length,
                          itemBuilder: (context, index) => addCatergory(index),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightscreen * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.Address.tr(),
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
                          controller: countryControllerRegister,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          decoration: InputDecoration(
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
                            labelText: LocaleKeys.country.tr(),
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
                            return null;
                          },
                        )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: cityControllerRegister,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (String value) {
                            print(value);
                          },
                          decoration: InputDecoration(
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
                            labelText: LocaleKeys.city.tr(),
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
                      children: [
                        Text(
                          LocaleKeys.Your_Experience.tr(),
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
                      controller: descriptionControllerRegister,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      // minLines: null,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.Description.tr(),
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
                      children: [
                        Text(
                          LocaleKeys.Select_your_available_time.tr(),
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
                            Text(LocaleKeys.Sunday.tr()),
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
                            Text(LocaleKeys.Monday.tr()),
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
                            Text(LocaleKeys.Tuesday.tr()),
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
                            Text(LocaleKeys.Wednesday.tr()),
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
                            Text(LocaleKeys.Thrusday.tr()),
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
                            Text(LocaleKeys.Friday.tr()),
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
                            Text(LocaleKeys.Saturday.tr()),
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
                              controller: startTimeControllerRegister,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counterText: '',
                                suffixStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
                                suffixText: ":00",
                                labelText: LocaleKeys.Start_Time.tr(),
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
                                if (RegExp(
                                        r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                    .hasMatch(endTimeControllerRegister.text)) {
                                  return 'Invalid start time';
                                }
                                if (endTimeControllerRegister.text.isNotEmpty) {
                                  if (int.parse(value) >=
                                      int.parse(
                                          endTimeControllerRegister.text)) {
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
                                controller: endTimeControllerRegister,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText: '',
                                  suffixStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                  suffixText: ":00",
                                  labelText: LocaleKeys.End_Time.tr(),
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
                                  if (RegExp(
                                          r"[!@#<>?':_`~ N؛،؟.,/;[\]\\|=+)(*&-]")
                                      .hasMatch(
                                          startTimeControllerRegister.text)) {
                                    return 'Invalid end time';
                                  }
                                  if (startTimeControllerRegister
                                      .text.isNotEmpty) {
                                    if (int.parse(value) <=
                                        int.parse(
                                            startTimeControllerRegister.text)) {
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
                                      if (starttimesControllerRegister.length <
                                          12) {
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
                                      if (starttimesControllerRegister.length >
                                          0) {
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
                      itemCount: starttimesControllerRegister.length,
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
                                  phone: numberControllerRegister.text,
                                  email: emailControllerRegister.text,
                                  password: passwordControllerRegister.text,
                                  country: countryControllerRegister.text,
                                  city: cityControllerRegister.text,
                                  experience:
                                      descriptionControllerRegister.text,
                                );
                              } else {
                                setState(() {
                                  isMedecine = true;
                                });
                              }
                            },
                            child: Center(
                                child: Text(
                              LocaleKeys.Sign_up.tr(),
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
          controller: OtherNamesControllerRegister[index],
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
          controller: OtherPricesControllerRegister[index],
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
                  controller: starttimesControllerRegister[index],
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
                        .hasMatch(endtimesControllerRegister[index].text)) {
                      return 'Invalid start time';
                    }
                    if (endtimesControllerRegister[index].text.isNotEmpty) {
                      if (int.parse(value) >=
                          int.parse(endtimesControllerRegister[index].text)) {
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
                    controller: endtimesControllerRegister[index],
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
                          .hasMatch(starttimesControllerRegister[index].text)) {
                        return 'Invalid end time';
                      }
                      if (starttimesControllerRegister[index].text.isNotEmpty) {
                        if (int.parse(value) <=
                            int.parse(
                                starttimesControllerRegister[index].text)) {
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
