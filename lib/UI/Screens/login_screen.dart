
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/Bloc/login/login_state.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consulting_app/theme/theme.dart';

var emailControllerLogin = TextEditingController();
var passwordControllerLogin = TextEditingController();
var formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit, LoginStates>(
  listener: (context, state) {
    if (state is LoginSuccessState) {
      if (state.loginModel.status != false) {
        print(state.loginModel.status!);
        print(state.loginModel.data!.token);

        showToast(
          text: state.loginModel.message!,
          state: ToastState.success,
        );
        CacheHelper.saveData(
          key: 'token',
          value: state.loginModel.data!.token,
        ).then((value) {
          token = state.loginModel.data!.token;
          ConsultingCubit.get(context).indx();
          ConsultingCubit.get(context).getHomeDataToken(0);
          Navigator.of(context).pushReplacementNamed('/home');
        });
      } else {
        showToast(
          text: 'Invalid Email or Password',
          state: ToastState.error,
        );
      }
    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: heightscreen,
                width: widthscreen,
                color: ThemeColors.backgroundColor,
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    // height: 100,
                    child: Image.asset(
                      "assets/images/image1.png",
                      fit: BoxFit.cover,
                      // height: 200,
                    ),
                  ),
                  SizedBox(
                    height: heightscreen * 0.09,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Welcome Back..',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: heightscreen * 0.05,
                          ),
                          TextFormField(
                            cursorColor: ThemeColors.highlight,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            controller: emailControllerLogin,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (String value) {
                              print(value);
                            },
                            decoration: InputDecoration(
                              labelText: "Enter Email",
                              prefixIcon: const Icon(
                                Icons.email,
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
                                  width: 2.0,
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
                              if (!EmailValidator.validate(value!)) {
                                return 'Please enter a valid Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: heightscreen * 0.03,
                          ),
                          TextFormField(
                            cursorColor: ThemeColors.highlight,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            obscureText: LoginCubit
                                .get(context)
                                .isPassword,
                            controller: passwordControllerLogin,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: ' password',
                              labelStyle: const TextStyle(
                                color: Colors.deepPurpleAccent,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: ThemeColors.icon,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(
                                  LoginCubit
                                      .get(context)
                                      .suffix,
                                  color: ThemeColors.icon,
                                ),
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
                                  width: 2.0,
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
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(25.0),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Please enter your Password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: heightscreen * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 11,
                                    // decoration: TextDecoration.underline,
                                    color: ThemeColors.highlight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) =>
                            Container(
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
                                  splashColor: ThemeColors.splashinkweel,
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    if (formKey.currentState!.validate())
                                    {
                                      LoginCubit.get(context).changeIsLogin();
                                      LoginCubit.get(context).loginUser(
                                          email: emailControllerLogin.text,
                                          password: passwordControllerLogin.text);
                                    }

                                  },
                                  child: const Center(
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          color: ThemeColors.backgroundColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            fallback: (context) => const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
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
                                  LoginCubit.get(context).changeIsLoginAsGuesst();
                                  ConsultingCubit.get(context).indx();
                                  Navigator.of(context).pushReplacementNamed('/home');
                                },
                                child: const Center(
                                    child: Text(
                                      'login as guest',
                                      style: TextStyle(
                                        color: ThemeColors.backgroundColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(height: heightscreen * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an acount?'),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/getStarted');
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: ThemeColors.highlight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}