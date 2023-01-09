import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_cubit.dart';
import 'package:consulting_app/Bloc/reservation_history/reservation_history_cubit.dart';
import 'package:consulting_app/Bloc/reservation_history/reservation_history_state.dart';
import 'package:consulting_app/models/reservation_history_model.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:consulting_app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
          title:  Text(
            LocaleKeys.My_Secheduale.tr(),
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
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    SizedBox(
                      height: heightscreen * 0.03,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ReservationHistoryCubit.get(context).reservationHistoryModel!.data!.length,
                      separatorBuilder: (BuildContext context, int index) => SizedBox(
                        height: heightscreen * 0.03,
                      ),
                      itemBuilder: (context, index) => reservationCard(ReservationHistoryCubit.get(context).reservationHistoryModel!.data![index],context),
                    ),
                  ],
                ),
              ),
            )),
      ),
      fallback: (context)=> Center(child: const CircularProgressIndicator(color: Colors.purple,)),
    );
  },
);
  }

  Widget reservationCard(UserReservationModel model,context) {
    return InkWell(
      onTap: (){
        PublicProfileCubit.get(context).getPublicUserProfileModelData(model.user_id);
        Navigator.of(context).pushNamed('/public_user_profile');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
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
                    '${model.from}',
                    style: TextStyle(
                        color: Color.fromARGB(255, 43, 40, 40),
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                   Text(
                    //dayst,
                    '${model.dayName}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                   Text(
//dayi + ' ' +month + ' ' +year ,
                  '${model.day} ' + '${model.month} ' + '${model.year}',
                    //'17 january 2023',
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
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   Text(
                    //'type : ' + type,
                      '${LocaleKeys.Type.tr()} : ' + '${model.type}',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),

                   Text(
                    //name,
                    '${model.userName}',
                    //'Bassam Jawish',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const Icon(Icons.chevron_right_outlined)],
            )
          ],
        ),
      ),
    );
  }
}