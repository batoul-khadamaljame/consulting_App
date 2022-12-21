import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/Bloc/register/register_state.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/UI/Screens/userRegister_screen.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var medicineController = TextEditingController();
var careerController = TextEditingController();
var psychologyController = TextEditingController();
var familyController = TextEditingController();
var managementController = TextEditingController();
var descriptionController = TextEditingController();
var starttimeController = TextEditingController();
var endtimeController = TextEditingController();
var countryController = TextEditingController();
var cityController = TextEditingController();

class ExpertRegisterScreen extends StatefulWidget {
  const ExpertRegisterScreen({super.key});

  @override
  State<ExpertRegisterScreen> createState() => _ExpertRegisterScreenState();
}

class _ExpertRegisterScreenState extends State<ExpertRegisterScreen> {
  int countcategory = 0;
  int counttime = 1;

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

  List<String> name = [];
  List<String> price = [];

  int varb = 0;

  void addOtherServices() {
    for (int i = varb; i < name.length; i++) {
      RegisterCubit.get(context).addService(6, name[i], price[i]);
    }

    varb = name.length;
    /*
    for (int i = 0; i < RegisterCubit
        .get(context)
        .services
        .length; i++) {
      print(RegisterCubit
          .get(context)
          .services[i].id);
      print(RegisterCubit
          .get(context)
          .services[i].name);
      print(RegisterCubit
          .get(context)
          .services[i].price);
    }
    */
  }

  List<dynamic> startTime = [];
  List<dynamic> endTime = [];

  int point = 0;

  void addListsTime() {

    for (int i = point; i < startTime.length; i++) {
      RegisterCubit.get(context).addTimes(startTime[i], endTime[i]);
    }
    point = startTime.length;
  }

  var formKey = GlobalKey<FormState>();

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
          showToast(
            text: state.loginModel.message!,
            state: ToastState.success,
          );
          CacheHelper.saveData(
            key: 'token',
            value: state.loginModel.data!.token,
          ).then((value) {
            token = state.loginModel.data!.token;
            Navigator.of(context).pushReplacementNamed('/home');
          });
           }
              else {
              print(state.loginModel.status!);
              showToast(
                text: state.loginModel.message!,
                state: ToastState.error,
              );
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: medicineController,
                                  enabled: isMedecine,
                                  keyboardType: TextInputType.number,
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
                                    labelText: 'price',
                                    prefixIcon: Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle: TextStyle(color: Colors.grey),
                                    suffixText: '\$',
                                  ),
                                  validator: (value) {
                                    if (isMedecine == false &&
                                        isCareer == false &&
                                        isPsychology == false &&
                                        isFamily == false &&
                                        isManagement == false &&
                                        countcategory == 0) {
                                      return 'You should offer one service at least';
                                    }
                                    if (value!.isEmpty && isMedecine == true) {
                                      return 'Enter price';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    cubit.addService(1, 'medicine', value);
                                    print(cubit.services[0].name);
                                  },
                                ),
                              ],
                            ),

                            value: isMedecine,
                            onChanged: (newbool) {
                              setState(() {
                                isMedecine = newbool;
                                if (isMedecine == false) {
                                  medicineController.clear();
                                  if (cubit.services.length > 0) {
                                    cubit.deleteSpecificService(1);
                                  }
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
                                  controller: careerController,
                                  keyboardType: TextInputType.number,
                                  enabled: isCareer,
                                  cursorColor: ThemeColors.highlight,
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
                                    labelText: 'price',
                                    prefixIcon: Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle: TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty && isCareer == true) {
                                      return 'Enter price';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    cubit.addService(2, 'career', value);
                                  },
                                ),
                              ],
                            ),
                            value: isCareer,
                            onChanged: (newbool) {
                              setState(() {
                                isCareer = newbool;
                                if (isCareer == false) {
                                  careerController.clear();
                                  cubit.deleteSpecificService(2);
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
                                  controller: psychologyController,
                                  keyboardType: TextInputType.number,
                                  enabled: isPsychology,
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
                                    labelText: 'price',
                                    prefixIcon: Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle: TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty &&
                                        isPsychology == true) {
                                      return 'Enter price';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    cubit.addService(3, 'psychology', value);
                                  },
                                ),
                              ],
                            ),
                            value: isPsychology,
                            onChanged: (newbool) {
                              setState(() {
                                isPsychology = newbool!;
                                if (isPsychology == false) {
                                  psychologyController.clear();
                                  cubit.deleteSpecificService(3);
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
                                  onFieldSubmitted: (value) {
                                    cubit.addService(4, 'family', value);
                                  },
                                  controller: familyController,
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
                                    suffixStyle: TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty && isFamily == true) {
                                      return 'Enter price';
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
                                  familyController.clear();
                                  cubit.deleteSpecificService(4);
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
                                  controller: managementController,
                                  keyboardType: TextInputType.number,
                                  enabled: isManagement,
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
                                    labelText: 'price',
                                    prefixIcon: Icon(
                                      Icons.price_change_outlined,
                                      color: ThemeColors.icon,
                                    ),
                                    suffixStyle: TextStyle(color: Colors.grey),
                                    suffixText: "\$",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty &&
                                        isManagement == true) {
                                      return 'Enter price';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    cubit.addService(5, 'management', value);
                                  },
                                ),
                              ],
                            ),
                            value: isManagement,
                            onChanged: (newbool) {
                              setState(() {
                                isManagement = newbool;
                                if (isManagement == false) {
                                  managementController.clear();
                                  cubit.deleteSpecificService(5);
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
                                      countcategory++;
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
                                    if (countcategory > 0) {
                                      if (countcategory == price.length &&
                                          countcategory == name.length) {
                                        setState(() {
                                          name.removeLast();
                                          price.removeLast();
                                          cubit.deleteService();
                                        });
                                      } else if (countcategory == name.length) {
                                        setState(() {
                                          name.removeLast();
                                        });
                                      } else if (countcategory ==
                                          price.length) {
                                        setState(() {
                                          price.removeLast();
                                        });
                                      }
                                      setState(() {
                                        countcategory--;
                                      });
                                    }
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
                          itemCount: countcategory,
                          itemBuilder: (context, index) => addCatergory(),
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
                            if (RegExp(r"[!@#<>?':_`~ ١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
                                    .hasMatch(value) ||
                                RegExp(r'[!@#<>?":_`~.,/;{}€£¥₩°•○●□■♤♡◇♧☆▪️¤《》¡¿$÷×[\]\\|=+)(*&^%0-9-]')
                                    .hasMatch(value)) {
                              return "it doesn't existed";
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
                            if (RegExp(r"[!@#<>?':_`~ ١٢٣٤٥٦٧٨٩٠؛،؟.,/;[\]\\|=+)(*&^%0-9-]")
                                    .hasMatch(value) ||
                                RegExp(r'[!@#<>?":_`~.,/;{}€£¥₩°•○●□■♤♡◇♧☆▪️¤《》¡¿$÷×[\]\\|=+)(*&^%0-9-]')
                                    .hasMatch(value)) {
                              return "it doesn't existed";
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      //reverse: true,
                      itemCount: counttime,
                      itemBuilder: (context, j) => Addtime(j),
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
                                print(fullname);
                                print(numberController.text);
                                print(emailController.text);
                                print(passwordController.text);
                                print(countryController.text);
                                print(cityController.text);
                                print(descriptionController.text);
                                print(cubit.services);
                                print(cubit.days);
                                print(cubit.times);


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

  Widget addCatergory() {
    return Column(
      children: [
        TextFormField(

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
              return 'Please enter your consultation';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            setState(() {
              name.add(value);
              if (countcategory == name.length &&
                  countcategory == price.length) {
                addOtherServices();
              }
            });
          },
        ),
        TextFormField(
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
              return 'Please enter price';
            }
            return null;
          },
          onFieldSubmitted: (value) {
            setState(() {
              price.add(value);
              if (countcategory == name.length &&
                  countcategory == price.length) {
                addOtherServices();
              }
            });
          },
        ),
      ],
    );
  }

  Widget Addtime(int index) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 50,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
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
                cursorColor: ThemeColors.highlight,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "It's empty!";
                  }
                  if(int.parse(value) < 0 || int.parse(value) > 22){
                    return 'Invalid start time';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    startTime.add(value);
                    if (counttime == startTime.length &&
                        counttime == endTime.length) {
                      addListsTime();
                    }
                  });
                },
                onTap: () {
                  RegisterCubit.get(context).addDays(isSunday, isMonday,
                      isTuesday, isWednesday, isThursday, isFriday, isSaturday);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                width: 120,
                height: 50,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                  cursorColor: ThemeColors.highlight,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "It's empty!";
                    }
                    if(int.parse(value) < 1 || int.parse(value) > 23){
                      return 'Invalid end time';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      endTime.add(value);
                      if (counttime == startTime.length &&
                          counttime == endTime.length) {
                        addListsTime();
                      }
                    });
                  },
                )),
            const SizedBox(
              width: 10,
            ),
            index == 0
                ? Row(
                    children: [
                      Container(
                        height: 25,
                        width: 40,
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
                              setState(() {
                                counttime++;
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
                              setState(() {
                                if (counttime > 0) {
                                  if (counttime == startTime.length &&
                                      counttime == endTime.length) {
                                    setState(() {
                                      startTime.removeLast();
                                      endTime.removeLast();
                                      RegisterCubit.get(context).deleteTimes();
                                    });
                                  } else if (counttime == startTime.length) {
                                    setState(() {
                                      name.removeLast();
                                    });
                                  } else if (counttime ==
                                      endTime.length) {
                                    setState(() {
                                      price.removeLast();
                                    });
                                  }
                                  setState(() {
                                    counttime--;
                                  });
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
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
