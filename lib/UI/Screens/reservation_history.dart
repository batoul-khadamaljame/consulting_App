import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/reservation_history/reservation_history_cubit.dart';
import 'package:consulting_app/Bloc/reservation_history/reservation_history_state.dart';
import 'package:consulting_app/models/reservation_history_model.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationHisory extends StatelessWidget {
  const ReservationHisory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;
    var model = ReservationHistoryCubit.get(context).reservationHistoryModel;
    return BlocConsumer<ReservationHistoryCubit, ReservationHistoryStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return ConditionalBuilder(
      condition: state is! ReservationHistoryLoadingState,
      builder:(context)=> Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.backgroundColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(
              Icons.chevron_left,
              size: 40,
              color: Colors.purple,
            ),
          ),
          title: Text(
            'My Schedule',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          elevation: 0.0,
        ),
        backgroundColor: ThemeColors.backgroundColor,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                    ),
                    SizedBox(
                      height: heightscreen * 0.03,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 9,
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        height: heightscreen * 0.03,
                      ),
                      itemBuilder: (context, index) => reservationCard(model!,context,index),
                    ),
                  ],
                ),
              ),
            )),
      ),
      fallback: (context)=> CircularProgressIndicator(color: Colors.purple,),
    );
  },
);
  }

  Widget reservationCard(ReservationHistoryModel model,context,index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            color: Colors.purple.withOpacity(0.3),
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                Text(
                  //time +':00' ,
                  '08:00',
                  style: TextStyle(
                      color: Color.fromARGB(255, 43, 40, 40),
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  //dayst,
                  'Sunday',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 9,
                ),
                Text(
//dayi + ' ' +month + ' ' +year ,
                  '17 january 2023',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            height: double.infinity,
            width: 2,
            color: Colors.black45,
          ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //'type : ' + type,
                    'Type : medicine',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(
                  height: 13,
                ),
                Text(
                  //name,
                  'batoul',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                      onTap: () {},
                      child: const Center(
                          child: Text(
                            ' Profile',
                            style: TextStyle(
                              color: ThemeColors.backgroundColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [Icon(Icons.chevron_right_outlined)],
          )
        ],
      ),
    );
  }
}