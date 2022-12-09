import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/consulting_state.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  List<String> banners =['assets/banners/img1.png',
  'assets/banners/img2.png','assets/banners/img3.png'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultingCubit, ConsultingStates>(
      listener: (context, state) {
        if (state is SuccessChangeFavoritesState) {
          /*if (!state.model.status!) {
            showToast(
              text: state.model.message!,
              state: ToastStates.error,
            );
          }*/
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
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20,),
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
                                width: 270,
                              ),
                        )
                            .toList(),
                        options: CarouselOptions(
                          height: 160,
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
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Categories',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      SizedBox(
                          height: 120,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => const SizedBox(
                              width: 10.0,
                            ),
                            itemCount: categoriesList.length,
                            itemBuilder: (context, index)=> Categories(categoriesList[index].id,categoriesList[index].type,categoriesList[index].ImageURL),

                          ),
                        ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Available Experts',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      SizedBox(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 12,),
                          itemBuilder: (BuildContext context, int i) {
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
                                        image: AssetImage('assets/demo/img.png'),
                                      )
                                    ),
                                  ),
                                  SizedBox(width: 25,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('4.9',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),)
                                          ,SizedBox(width: 4,),
                                          Icon(Icons.star,color: Colors.yellow,size: 12,),

                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Text('AboTahseen Jawish',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),maxLines: 1,
                                        overflow: TextOverflow.ellipsis,),
                                      SizedBox(height: 10,),
                                      Text('Type: '+ 'Medicine',style: TextStyle(color: Colors.deepPurple,fontSize: 14,fontWeight: FontWeight.w600),maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                      SizedBox(height: 10,),
                                      Text("50\$",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),),

                                    ],
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
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            );

      },
    );
  }

  Widget Categories(int id,String type, String img){
    return InkWell(
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 70,
              child: Image.asset(img,color: ThemeColors.backgroundColor,),
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

}

class Categories{

  final int id;
  final String type;
  final String ImageURL;


  Categories(this.id,this.type,this.ImageURL);
}

List<Categories> categoriesList = [
  Categories(1, 'Medicine', 'assets/categories/medicine1.png'),
  Categories(2, 'Career', 'assets/categories/career.png'),
  Categories(3, 'Psychology', 'assets/categories/Psychology.png'),
  Categories(4, 'Family', 'assets/categories/family.png'),
  Categories(5, 'Management', 'assets/categories/manegment.png'),
  Categories(6, 'Others', 'assets/categories/others.png'),

];

/*List<Categories> categoriesList = [
  Categories(1, 'Medicine', 'assets/categories2/Medicine.png'),
  Categories(2, 'Career', 'assets/categories2/Career.png'),
  Categories(3, 'Psychology', 'assets/categories2/Psychology.png'),
  Categories(4, 'Family', 'assets/categories2/Family.png'),
  Categories(5, 'Management', 'assets/categories2/Management.png'),
  Categories(6, 'Others', 'assets/categories2/others.png'),

];*/
