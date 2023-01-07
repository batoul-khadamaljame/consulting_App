import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_cubit.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_state.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PublicUserProfileScreen extends StatelessWidget {
  const PublicUserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;

    return BlocConsumer<PublicProfileCubit, PublicProfileStates>(
      listener: (context, state) {},
      builder: (
          context,
          state,
          ) {
        var cubit = PublicProfileCubit.get(context);
        return Scaffold(
          backgroundColor: ThemeColors.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 3, left: 25, right: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.black,
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33),
                            color: Color.fromARGB(255, 200, 119, 238),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 2,
                                spreadRadius: 2,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          width: 155,
                          height: 185,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.asset(
                                'assets/demo/tech.png',
                                fit: BoxFit.cover,
                                width: 150,
                                height: 180,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                //'DR steaf hihihjjjdddd',
                                '${cubit!.publicUserProfileModel!.data!.name}',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700,

                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: Color.fromARGB(120, 206, 157, 223),
                                    ),
                                    child: Icon(
                                      Icons.phone,
                                      color: Color.fromARGB(255, 160, 7, 168),
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: Color.fromARGB(120, 206, 157, 223),
                                    ),
                                    child: Icon(
                                      Icons.message,
                                      color: Color.fromARGB(255, 160, 7, 168),
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightscreen * 0.05,
                    ),
                    Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.email_outlined,
                              size: 25,
                              color: Color.fromARGB(255, 158, 62, 202),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children:  [
                            SizedBox(
                              height: 10,
                              width: 36,
                            ),
                            Text(
                              '${cubit.publicUserProfileModel!.data!.email!}',
                              //'batoul@gmail.com',
                              style: TextStyle(
                                color: Color.fromARGB(255, 53, 42, 70),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightscreen * 0.04,
                    ),
                    Column(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.phone_android_outlined,
                              size: 25,
                              color: Color.fromARGB(255, 158, 62, 202),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Phone',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children:  [
                            SizedBox(
                              height: 10,
                              width: 36,
                            ),
                            Text(
                              '${cubit.publicUserProfileModel!.data!.phone}',
                              //'09478989889',
                              style: TextStyle(
                                color: Color.fromARGB(255, 53, 42, 70),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }}
