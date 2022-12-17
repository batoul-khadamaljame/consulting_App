
import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';

class GuestProfileScreen extends StatelessWidget {
  const GuestProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
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
      drawer: Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/guest.png'),color: Colors.deepPurple,),
          SizedBox(height: 10,),
          Text("You don't have an account",style: TextStyle(fontSize: 20,color: Colors.black),),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      LoginCubit.get(context).changeIsLoginAsGuesst();
                      ConsultingCubit.get(context).indx();
                      Navigator.of(context).pushReplacementNamed('/login');
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
              SizedBox(width: 10,),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(50),
                  gradient: const RadialGradient(
                      radius: 4,
                      colors: [
                        Color.fromARGB(
                            255, 141, 68, 243),
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
                    splashColor:
                    ThemeColors.splashinkweel,
                    borderRadius:
                    BorderRadius.circular(30),
                    onTap: () {
                      LoginCubit.get(context).changeIsLoginAsGuesst();
                      ConsultingCubit.get(context).indx();
                      Navigator.of(context).pushReplacementNamed('/getStarted');
                    },
                    child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color:
                            ThemeColors.backgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                ),
              ),
          ],)
        ],
      ),
    );
  }
}
