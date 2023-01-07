import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/Bloc/home_guest/home_guest_cubit.dart';
import 'package:consulting_app/Bloc/home_guest/home_guest_state.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/Bloc/reservation/reservation_cubit.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/home_model.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:consulting_app/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

class HomeGuest extends StatelessWidget {
  HomeGuest({Key? key}) : super(key: key);

  List<String> banners = [
    'assets/banners/img1.png',
    'assets/banners/img2.png',
    'assets/banners/img3.png'
  ];



  @override
  Widget build(BuildContext context) {
    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;
    var model = HomeGuestCubit.get(context);
    return BlocConsumer<HomeGuestCubit, HomeDataGuestStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeColors.backgroundColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: ThemeColors.icons),
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
                      Text(LocaleKeys.Settings.tr(),
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
                      Text(LocaleKeys.Language.tr(),
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
                            LocaleKeys.English.tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                      Switch(
                        value: switchValue,
                        onChanged: (value) async{
                          print(value);
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
                            LocaleKeys.Arabic.tr(),
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
                    Text(LocaleKeys.About_us.tr(),
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),),
                  ],),
                  SizedBox(
                    height: heightscreen * 0.03,
                  ),
                  switchValue?Text('تم إنشاء هذا التطبيق من قبل المطورين بسام وبتول ورجائي وعبادة (BBRO). يمكنك التسجيل كمستخدم أو خبير ، ثم بيع وشراء بعض الخدمات من أنواع مختلفة. نحن سعداء جدًا بتقديم هذا التطبيق الذي يمكن استخدامه على هاتفك',style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 2)):Text('This app was created by the developers Bassam,Batoul,Rajaei and Obada(BBRO).           You can sign up as a User or an Expert, then sell and buy some services of different types. We are so glad by offer this app that can be used on your phone',style: TextStyle(color: Colors.black,fontSize: 20,letterSpacing: 2)),
                ],
              ),
            ),
          )),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: widthscreen * 0.02),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: heightscreen * 0.025,
                  ),
                  CarouselSlider(
                    items: banners
                        .map(
                          (e) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                image: ExactAssetImage(e),
                                fit: BoxFit.fill,
                              ),
                            ),
                            width: widthscreen * 0.8,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: heightscreen * 0.19,
                      viewportFraction: 0.7,
                      enlargeCenterPage: true,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: heightscreen * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      Text(
                        LocaleKeys.Categories.tr(),
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightscreen * 0.01,
                  ),
                  SizedBox(
                    height: heightscreen * 0.14,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(
                        width: widthscreen * 0.025,
                      ),
                      itemCount: categoriesListGuest.length,
                      itemBuilder: (context, index) => buildCategories(
                          categoriesListGuest[index].id,
                          categoriesListGuest[index].type,
                          categoriesListGuest[index].ImageURL,
                          context),
                    ),
                  ),
                  SizedBox(
                    height: heightscreen * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      Text(
                        LocaleKeys.Available_Services.tr(),
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightscreen * 0.015,
                  ),
                  ConditionalBuilder(
                    condition: state is! LoadingHomeDataGuestState,
                    builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          HomeGuestCubit.get(context).homeGuestModel!.data!.length,
                      //itemCount: 5,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: heightscreen * 0.02,
                      ),

                      //itemBuilder: (context, index) => buildExpertCardDummy(expertsList[index].id,expertsList[index].rate.toString() ,expertsList[index].name, expertsList[index].type, expertsList[index].price.toString(), expertsList[index].image, expertsList[index].inFavorites,context)

                      itemBuilder: (context, index) => buildExpertCard(
                          HomeGuestCubit.get(context).homeGuestModel!.data![index],
                          context),
                    ),
                    fallback: (context) => const Padding(
                        padding: EdgeInsets.all(100),
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategories(int id, String type, String img, context) {
    return InkWell(
      onTap: () {
        HomeGuestCubit.get(context).changeCatIndexGuest(id);
        HomeGuestCubit.get(context).getHomeDataGuest(id);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: id == HomeGuestCubit.get(context).catIndexGuest
              ? Colors.blue
              : Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 70,
              child: Image.asset(
                img,
                color: ThemeColors.backgroundColor,
              ),
            ),
            Container(
              child: Text(
                type == 'All'?LocaleKeys.All.tr():
                type == 'Medicine'?LocaleKeys.Medicine.tr():
                    type == 'Career'?LocaleKeys.Career.tr():
                    type == 'Psychology'?LocaleKeys.Psychology.tr():
                    type == 'Family'?LocaleKeys.Family.tr():
                    type == 'Management'?LocaleKeys.Management.tr():
                    type == 'Others'?LocaleKeys.Others.tr():LocaleKeys.Others.tr()

                ,
                style: const TextStyle(
                  color: ThemeColors.backgroundColor,
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpertCardDummy(int id, String rate, String name, String type,
      String price, String image, bool inFavorites, context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/reservation');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
            Container(
              height: 105,
              width: 110,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(image),
                  )),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        rate,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(LocaleKeys.Type.tr() + type,
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$price\$",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Container(),
                const SizedBox(
                  height: 50,
                ),
                const Icon(Icons.chevron_right_outlined)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildExpertCard(ExpertCardModel model, context) {
    return InkWell(
      onTap: () {
        ReservationCubit.get(context).initDate();
        ReservationCubit.get(context).getReservationData(model.id);
        Navigator.of(context).pushNamed('/reservation');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
            Container(
              height: 105,
              width: 110,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/demo/img.png'),
                    //Image.file(model.image!) as ImageProvider,
                  )),
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        //model.rate.toString(),
                        '4.5',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(LocaleKeys.Type.tr() + '${model.type}',
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('${model.price}\$'.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Container(),
                const SizedBox(
                  height: 50,
                ),
                const Icon(Icons.chevron_right_outlined)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Categories {
  final int id;
  final String type;
  final String ImageURL;

  Categories(this.id, this.type, this.ImageURL);
}

List<Categories> categoriesListGuest = [
  Categories(0, 'All', 'assets/categories/all.png'),
  Categories(1, 'Medicine', 'assets/categories/medicine1.png'),
  Categories(2, 'Career', 'assets/categories/career.png'),
  Categories(3, 'Psychology', 'assets/categories/Psychology.png'),
  Categories(4, 'Family', 'assets/categories/family.png'),
  Categories(5, 'Management', 'assets/categories/manegment.png'),
  Categories(6, 'Others', 'assets/categories/others.png'),
];

//dummy data
class Experts {
  final int id;
  final dynamic rate;
  final String name;
  final String type;
  final dynamic price;
  final String image;
  final bool inFavorites;

  Experts(this.id, this.rate, this.name, this.type, this.price, this.image,
      this.inFavorites);
}

List<Experts> expertsList = [
  Experts(
      1, 5.0, 'Bassam Jawish', 'Medicine', 120, 'assets/demo/tech.png', false),
  Experts(2, 4.5, 'Batoul kh', 'Family', 100, 'assets/demo/img.png', false),
  Experts(
      3, 4.8, 'Obada Jaiwsh', 'Career', 550, 'assets/demo/lawyer.png', false),
  Experts(
      1, 5.0, 'Bassam Jawish', 'Medicine', 10, 'assets/demo/doc.jpg', false),
  Experts(2, 3.8, 'BBRO', 'Family', 25, 'assets/demo/kk.png', false),
  Experts(3, 4.8, 'Messi', 'Career', 55, 'assets/demo/doc.jpg', false),
];
