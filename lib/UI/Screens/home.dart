import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/models/home_model.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<String> banners = [
    'assets/banners/img1.png',
    'assets/banners/img2.png',
    'assets/banners/img3.png'
  ];

  @override
  Widget build(BuildContext context) {

    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;
    final state1 = context.watch<ConsultingCubit>().state;
    return BlocConsumer<ConsultingCubit, ConsultingStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavoritesState) {
          if (!state.model.status!) {
            showToast(
              text: state.model.message!,
              state: ToastState.error,
            );
          }
        }
      },
      builder: (context, state) {
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
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: widthscreen*0.02),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: heightscreen*0.025,
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
                        width: widthscreen*0.8,
                      ),
                    )
                        .toList(),
                    options: CarouselOptions(
                      height: heightscreen*0.19,
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
                    height: heightscreen*0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightscreen*0.01,
                  ),
                  SizedBox(
                    height: heightscreen*0.14,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>  SizedBox(
                        width: widthscreen*0.025,
                      ),
                      itemCount: categoriesList.length,
                      itemBuilder: (context, index) => buildCategories(
                          categoriesList[index].id,
                          categoriesList[index].type,
                          categoriesList[index].ImageURL,context),
                    ),
                  ),
                  SizedBox(
                    height: heightscreen*0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Available Experts',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightscreen*0.015,
                  ),
                  //ConditionalBuilder(
                  //condition: ConsultingCubit.get(context).homeModel != null,
                  //builder:(context) =>
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: expertsList.length,
                      /*ConsultingCubit.get(context)
                            .homeModel!
                            .data!
                            .experts
                            .length,*/
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                            height: heightscreen*0.02,
                          ),

                      itemBuilder: (context, index) => buildExpertCard(expertsList[index].id,expertsList[index].rate.toString() ,expertsList[index].name, expertsList[index].type, expertsList[index].price.toString(), expertsList[index].image, expertsList[index].inFavorites)


                    /*itemBuilder: (context, index) => buildExpertCard(
                            ConsultingCubit.get(context)
                                .homeModel!
                                .data!
                                .experts[index],
                            context)*/
                  ),
                  // fallback: (context) => Padding(
                  //padding: EdgeInsets.all(100),
                  //child: CircularProgressIndicator()),
                  //),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCategories(int id, String type, String img,context) {
    return InkWell(
      onTap: (){
        ConsultingCubit.get(context).changeCatIndex(id);
        ConsultingCubit.get(context).getHomeData(id);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: id == ConsultingCubit.get(context).catIndex? Colors.blue:Colors.deepPurple,
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
                type,
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


  Widget buildExpertCard(int id, String rate, String name, String type,String price, String image, bool inFavorites){
    return Container(
      padding: EdgeInsets.all(12),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,3),
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
                border: Border.all(
                    width: 0.5,
                    color: Colors.deepPurple
                ),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(image),
                )
            ),
          ),
          SizedBox(width: 25,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(rate,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),)
                    ,SizedBox(width: 4,),
                    Icon(Icons.star,color: Colors.yellow,size: 12,),

                  ],
                ),
                SizedBox(height: 10,),
                Text(name,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),maxLines: 1,
                  overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),
                Text('Type: '+ type,style: TextStyle(color: Colors.deepPurple,fontSize: 14,fontWeight: FontWeight.w600),maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 10,),
                Text("$price\$",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),

              ],
            ),
          ),
          SizedBox(width: 20,),
          Column(
            children: [
              LikeButton(

                size: 25,
              ),
              SizedBox(height: 50,),
              Icon(Icons.chevron_right_outlined)
            ],
          )
        ],
      ),
    );
  }

/*
Widget buildExpertCard(ExpertModel model, context) {
    return Container(
      padding: EdgeInsets.all(12),
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
          Container(
            height: 105,
            width: 110,
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.file(model.image!) as ImageProvider,
                )),
          ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      model.rate,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '$model.name',
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
                Text('Type: ' + '$model.type',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "$model.price\$",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children:  [
              LikeButton(
                onTap: (isLiked) async{
                  print('x');
                  ConsultingCubit.get(context).changeFavorites(model.id!);
                },
                size: 25,
              ),
              SizedBox(
                height: 50,
              ),
              Icon(Icons.chevron_right_outlined)
            ],
          )
        ],
      ),
    );
  }
*/

}

class Categories {
  final int id;
  final String type;
  final String ImageURL;

  Categories(this.id, this.type, this.ImageURL);
}

List<Categories> categoriesList = [
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
      1, 5.0, 'Bassam Jawish', 'Medicine', 12, 'assets/demo/img.png', false),
  Experts(2, 4.5, 'BBRO', 'Family', 25, 'assets/demo/img.png', false),
  Experts(3, 4.8, 'Messi', 'Career', 55, 'assets/demo/img.png', false),
  Experts(
      1, 5.0, 'Bassam Jawish', 'Medicine', 12, 'assets/demo/img.png', false),
  Experts(2, 4.5, 'BBRO', 'Family', 25, 'assets/demo/img.png', false),
  Experts(3, 4.8, 'Messi', 'Career', 55, 'assets/demo/img.png', false),
];
