import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_cubit.dart';
import 'package:consulting_app/Bloc/reservation/reservation_cubit.dart';
import 'package:consulting_app/Bloc/reservation/reservation_state.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';


class ServiceReservation extends StatelessWidget {
  const ServiceReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(DateFormat('EEEE').format(DateTime.now()));
   // print(DateFormat('EEEE').format(ReservationCubit.get(context).date));
    //print(DateFormat('MMM').format(ReservationCubit.get(context).date));

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var cubit = ReservationCubit.get(context);
    return BlocConsumer<ReservationCubit, ReservationStates>(
      listener: (context, state) {
        if (state is ReservationDoneSuccessState) {
          if (state.reservationDoneModel.status != null) {
            print('sdsdgsgfdlgskddlsdasfslkfa;;asg');

            if (state.reservationDoneModel.status == true) {
              showToast(
                text: state.reservationDoneModel.message!,
                state: ToastState.success,
              );
              cubit.SundayDate = DateTime.now();
              cubit.MondayDate = DateTime.now();
              cubit.TuesdayDate = DateTime.now();
              cubit.WednesdayDate = DateTime.now();
              cubit.ThrusdayDate = DateTime.now();
              cubit.FridayDate = DateTime.now();
              cubit.SaturdayDate = DateTime.now();
              Navigator.of(context).pushReplacementNamed('/home');
            } else {
              showToast(
                text: state.reservationDoneModel.message!,
                state: ToastState.error,
              );
            }
          } else {
            showToast(
              text: state.reservationDoneModel.message!,
              state: ToastState.error,

            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ReservationLoadingState,
          builder: (context) => Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              leading: IconButton(
                onPressed: () {
                  cubit.SundayDate = DateTime.now();
                  cubit.MondayDate = DateTime.now();
                  cubit.TuesdayDate = DateTime.now();
                  cubit.WednesdayDate = DateTime.now();
                  cubit.ThrusdayDate = DateTime.now();
                  cubit.FridayDate = DateTime.now();
                  cubit.SaturdayDate = DateTime.now();

                  Navigator.pop(context);
                },

                color: Colors.black,
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  color: Colors.purple,
                ),
              ),
              centerTitle: true,
              title: const Text(
                'Service Info',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              elevation: 0.0,
            ),
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: ThemeColors.backgroundColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 80,
                      child: Image.asset(
                        'assets/reserve1.png',
                        color: Colors.purple,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: height * 0.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(180, 158, 219, 180),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 0.5, color: Colors.deepPurple),

                      ),
                      child: Row(
                        children: [
                           Text(
                            'Service:',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                            /*style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                            ),*/

                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(
                            '${cubit.reservertionModel!.data!.type}',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 22,
                                //fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            /*
                            style: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),*/
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: height * 0.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(180, 158, 219, 180),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 0.5, color: Colors.deepPurple),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Text(
                        'Price:',
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                        ),),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Text(

                            '    ${cubit.reservertionModel!.data!.price}\$',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 22,
                                //fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,

                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      height: height * 0.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(180, 158, 219, 180),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 0.5, color: Colors.deepPurple),
                      ),
                      child: Row(
                        children: [
                           Text(
                            'Expert:',
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text(
                            '${cubit.reservertionModel!.data!.name}',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 22,
                                //fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding:  EdgeInsets.fromLTRB(width*0.04, 0, 0, 0),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              width: width * 0.27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: const RadialGradient(
                                    radius: 4,
                                    colors: [
                                      Color.fromARGB(255, 141, 68, 243),
                                      Colors.purple
                                    ]),),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor:
                                      ThemeColors.splashinkweel,
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    PublicProfileCubit.get(context).getPublicExpertProfileData(cubit.reservertionModel!.data!.expert_id);
                                    Navigator.of(context).pushNamed('/public_expert_profile');
                                  },
                                  child: const Center(
                                      child: Text(
                                    'Show Profile',
                                    style: TextStyle(
                                      color: Colors.white,
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
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Pick Date:',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(150, 118, 204,5),
                        //color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DatePicker(

                        DateTime.now(),

                        activeDates: [
                          if (cubit.reservertionModel!.data!.days!.sunday == 1)
                            cubit.SundayDate,
                          if (cubit.reservertionModel!.data!.days!.monday == 1)
                            cubit.MondayDate,
                          if (cubit.reservertionModel!.data!.days!.tuesday == 1)
                            cubit.TuesdayDate,
                          if (cubit.reservertionModel!.data!.days!.wednesday ==
                              1)
                            cubit.WednesdayDate,
                          if (cubit.reservertionModel!.data!.days!.thursday ==
                              1)
                            cubit.ThrusdayDate,
                          if (cubit.reservertionModel!.data!.days!.friday == 1)
                            cubit.FridayDate,
                          if (cubit.reservertionModel!.data!.days!.saturday ==
                              1)
                            cubit.SaturdayDate,
                          if (cubit.reservertionModel!.data!.days!.sunday == 1)
                            cubit.SundayDate.add(const Duration(days: 7)),
                          if (cubit.reservertionModel!.data!.days!.monday == 1)
                            cubit.MondayDate.add(const Duration(days: 7)),
                          if (cubit.reservertionModel!.data!.days!.tuesday == 1)
                            cubit.TuesdayDate.add(const Duration(days: 7)),
                          if (cubit.reservertionModel!.data!.days!.wednesday ==
                              1)
                            cubit.WednesdayDate.add(const Duration(days: 7)),
                          if (cubit.reservertionModel!.data!.days!.thursday ==
                              1)
                            cubit.ThrusdayDate.add(const Duration(days: 7)),
                          if (cubit.reservertionModel!.data!.days!.friday == 1)
                            cubit.FridayDate.add(const Duration(days: 7)),
                          if (cubit.reservertionModel!.data!.days!.saturday ==
                              1)
                            cubit.SaturdayDate.add(const Duration(days: 7)),
                          if (cubit.reservertionModel!.data!.days!.sunday == 1)
                            cubit.SundayDate.add(const Duration(days: 14)),
                          if (cubit.reservertionModel!.data!.days!.monday == 1)
                            cubit.MondayDate.add(const Duration(days: 14)),
                          if (cubit.reservertionModel!.data!.days!.tuesday == 1)
                            cubit.TuesdayDate.add(const Duration(days: 14)),
                          if (cubit.reservertionModel!.data!.days!.wednesday ==
                              1)
                            cubit.WednesdayDate.add(const Duration(days: 14)),
                          if (cubit.reservertionModel!.data!.days!.thursday ==
                              1)
                            cubit.ThrusdayDate.add(const Duration(days: 14)),
                          if (cubit.reservertionModel!.data!.days!.friday == 1)
                            cubit.FridayDate.add(const Duration(days: 14)),
                          if (cubit.reservertionModel!.data!.days!.saturday ==
                              1)
                            cubit.SaturdayDate.add(const Duration(days: 14)),
                          if (cubit.reservertionModel!.data!.days!.sunday == 1)
                            cubit.SundayDate.add(const Duration(days: 21)),
                          if (cubit.reservertionModel!.data!.days!.monday == 1)
                            cubit.MondayDate.add(const Duration(days: 21)),
                          if (cubit.reservertionModel!.data!.days!.tuesday == 1)
                            cubit.TuesdayDate.add(const Duration(days: 21)),
                          if (cubit.reservertionModel!.data!.days!.wednesday ==
                              1)
                            cubit.WednesdayDate.add(const Duration(days: 21)),
                          if (cubit.reservertionModel!.data!.days!.thursday ==
                              1)
                            cubit.ThrusdayDate.add(const Duration(days: 21)),
                          if (cubit.reservertionModel!.data!.days!.friday == 1)
                            cubit.FridayDate.add(const Duration(days: 21)),
                          if (cubit.reservertionModel!.data!.days!.saturday ==
                              1)
                            cubit.SaturdayDate.add(const Duration(days: 21)),
                          if (cubit.reservertionModel!.data!.days!.sunday == 1)
                            cubit.SundayDate.add(const Duration(days: 28)),
                          if (cubit.reservertionModel!.data!.days!.monday == 1)
                            cubit.MondayDate.add(const Duration(days: 28)),
                          if (cubit.reservertionModel!.data!.days!.tuesday == 1)
                            cubit.TuesdayDate.add(const Duration(days: 28)),
                          if (cubit.reservertionModel!.data!.days!.wednesday ==
                              1)
                            cubit.WednesdayDate.add(const Duration(days: 28)),
                          if (cubit.reservertionModel!.data!.days!.thursday ==
                              1)
                            cubit.ThrusdayDate.add(const Duration(days: 28)),
                          if (cubit.reservertionModel!.data!.days!.friday == 1)
                            cubit.FridayDate.add(const Duration(days: 28)),
                          if (cubit.reservertionModel!.data!.days!.saturday ==
                              1)
                            cubit.SaturdayDate.add(const Duration(days: 28)),
                        ],
                        daysCount: 31,
                        width: 80,
                        height: 95,
                        initialSelectedDate:
                            cubit.reservertionModel!.data!.days!.sunday == 1
                                ? cubit.SundayDate
                                : cubit.reservertionModel!.data!.days!.monday ==
                                        1
                                    ? cubit.MondayDate
                                    : cubit.reservertionModel!.data!.days!
                                                .tuesday ==
                                            1
                                        ? cubit.TuesdayDate
                                        : cubit.reservertionModel!.data!.days!
                                                    .wednesday ==
                                                1
                                            ? cubit.WednesdayDate
                                            : cubit.reservertionModel!.data!
                                                        .days!.thursday ==
                                                    1
                                                ? cubit.ThrusdayDate
                                                : cubit.reservertionModel!.data!
                                                            .days!.friday ==
                                                        1
                                                    ? cubit.FridayDate
                                                    : cubit.SaturdayDate,
                        selectedTextColor: Colors.white,
                        selectionColor: const Color.fromRGBO(114, 72, 188, 130),
                        dayTextStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.backgroundColor,
                        ),
                        dateTextStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.backgroundColor,
                        ),
                        monthTextStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.backgroundColor,
                        ),
                        deactivatedColor: Colors.black45,

                        onDateChange: (newDate) {
                          cubit.changeSelectedDate(newDate);
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.016),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(180, 158, 219, 180),
                        border:
                            Border.all(width: 0.5, color: Colors.deepPurple),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Avaliable times:',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.reservertionModel!.data!
                                  .workStartTimes!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2.5,
                                      crossAxisCount: 4),
                              itemBuilder: (context, index) =>
                                  buildTimes(index, context),
                            ),
                          ]),
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConditionalBuilder(
                          condition: state is! ReservationDoneLoadingState,
                          builder: (context) => Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const RadialGradient(
                                  radius: 4,
                                  colors: [
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

                                  print(cubit.reservertionModel!
                                      .data!.experience_id);
                                  print(cubit.reservertionModel!.data!
                                      .workStartTimes![cubit.timeIndex]);
                                  print(cubit.selectedDate.day);
                                  print(cubit.selectedDate.month);
                                  print(token);

                                  cubit.userReservation(
                                      experience_id: cubit.reservertionModel!
                                          .data!.experience_id,
                                      from: cubit.reservertionModel!.data!
                                          .workStartTimes![cubit.timeIndex],
                                      day: cubit.selectedDate.day,
                                      month: cubit.selectedDate.month,
                                      year: cubit.selectedDate.year,
                                      context: context);

                                },
                                child: const Center(
                                    child: Text(
                                  'Check Service',
                                  style: TextStyle(
                                    color: ThemeColors.backgroundColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator(color: Colors.purple,)),
        );
      },
    );
  }

  Widget buildTimes(index, context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: index == ReservationCubit.get(context).timeIndex
            ? Colors.deepPurple
            : Colors.white24,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            ReservationCubit.get(context).changeTimeIndex(index);
          },
          child: Center(
            child: Text(
              '${ReservationCubit.get(context).reservertionModel!.data!.workStartTimes![index]} ' +
                  '->' +
                  ' ${ReservationCubit.get(context).reservertionModel!.data!.workStartTimes![index] + 1}',
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
