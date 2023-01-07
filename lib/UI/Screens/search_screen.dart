import 'package:consulting_app/Bloc/consulting_cubit.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/Bloc/reservation/reservation_cubit.dart';
import 'package:consulting_app/Bloc/search/search_cubit.dart';
import 'package:consulting_app/Bloc/search/search_state.dart';
import 'package:consulting_app/UI/Screens/home_guest.dart';
import 'package:consulting_app/models/search_model.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

var searchCategoryController = TextEditingController();
var searchExpertController = TextEditingController();

var formKey = GlobalKey<FormState>();

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState(){
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;

    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeColors.backgroundColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.purple,
              icon: const Icon(Icons.chevron_left),
            ),
            elevation: 0.0,
          ),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Center(child: Text('Search',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                    const SizedBox(height: 20,),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[400],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TabBar(
controller: tabController,
                        indicator: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                        labelStyle: const TextStyle(fontSize: 18),
                        tabs:  [
                          const Tab(
                            text: 'Category',
                          ),
                          const Tab(
                            text: 'Expert',

                          ),
                        ],
                      ),
                    ),
                     SizedBox(
                      height: heightscreen*0.02,
                    ),
                    Expanded(
                        child: TabBarView(
controller: tabController,
                          physics: const BouncingScrollPhysics(),

                          children: [
                            Scaffold(
                              backgroundColor: ThemeColors.backgroundColor,
                              body: ListView(
                                shrinkWrap: true,
                                children: [
                                  const SizedBox(height: 5,),
                                  TextFormField(
                                    cursorColor: Colors.deepPurple,
                                    keyboardType: TextInputType.text,
                                    onFieldSubmitted: (String value) {
                                      SearchCubit.get(context).searchCategory(value);
                                    },
                                    onChanged: (String text) {
                                      SearchCubit.get(context).searchCategory(text);
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Search",
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: ThemeColors.icon,
                                      ),
                                      labelStyle: const TextStyle(
                                        color: ThemeColors.highlight,
                                      ),
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
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),

                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (state is SearchCategoryLoadingState)
                                    const Padding(
                                      padding: EdgeInsets.all(100.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.purple,
                                      ),
                                    ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  if (state is SearchCategorySuccessState)
                                    SearchCubit.get(context).searchCategoryModel!.status == true
                                        ? Expanded(
                                            child: ListView.separated(
                                                shrinkWrap: true,
                                                physics: const BouncingScrollPhysics(),
                                                //itemCount: expertsList.length,
                                                itemCount:
                                                SearchCubit.get(context)
                                                    .searchCategoryModel!.data!.length,
                                                separatorBuilder:
                                                    (BuildContext context,
                                                            int index) =>
                                                        SizedBox(
                                                          height:
                                                              heightscreen * 0.02,
                                                        ),
                                                /*itemBuilder: (context, index) =>
                                                    buildExpertCard(
                                                        expertsList[index].id,
                                                        expertsList[index]
                                                            .rate
                                                            .toString(),
                                                        expertsList[index].name,
                                                        expertsList[index].type,
                                                        expertsList[index]
                                                            .price
                                                            .toString(),
                                                        expertsList[index].image,
                                                        expertsList[index]
                                                            .inFavorites)
*/
                                              /*itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false,),*/
                                              itemBuilder: (context, index) => buildExpertCard(SearchCubit.get(context).searchCategoryModel!.data![index],context),

                                            ),
                                          )
                                        : Container(
                                          width: widthscreen*0.9,
                                          height: heightscreen*0.2,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.white24,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'NOT FOUND  :(',
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.purple),
                                              ),
                                              SizedBox(width: 40,),
                                              Icon(
                                                Icons.search_off,
                                                size: 50,
                                                color: Colors.purple
                                                ,
                                              ),
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                            Scaffold(
                              backgroundColor: ThemeColors.backgroundColor,
                              body:ListView(
                                shrinkWrap: true,
                              children: [
                                const SizedBox(height: 5,),
                                TextFormField(
                                  cursorColor: Colors.deepPurple,
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (String value) {
                                    SearchCubit.get(context).searchExpert(value);
                                  },
                                  onChanged: (String text) {
                                    SearchCubit.get(context).searchExpert(text);
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Search",
                                    prefixIcon: const Icon(
                                      Icons.search,
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
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                if (state is SearchExpertLoadingState)
                                  const Padding(
                                    padding: EdgeInsets.all(100.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.purple,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                if (state is SearchExpertSuccessState)
                                  SearchCubit.get(context).searchExpertModel!.status == true
                                      ? Expanded(
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                      const BouncingScrollPhysics(),
                                      //itemCount: expertsList.length,
                                      itemCount:
                                      SearchCubit.get(context)
                                          .searchExpertModel!.data!.length,
                                      separatorBuilder:
                                          (BuildContext context,
                                          int index) =>
                                          SizedBox(
                                            height:
                                            heightscreen * 0.02,
                                          ),
                                      /*itemBuilder: (context, index) =>
                                                  buildExpertCard(
                                                      expertsList[index].id,
                                                      expertsList[index]
                                                          .rate
                                                          .toString(),
                                                      expertsList[index].name,
                                                      expertsList[index].type,
                                                      expertsList[index]
                                                          .price
                                                          .toString(),
                                                      expertsList[index].image,
                                                      expertsList[index]
                                                          .inFavorites)
*/
                                      /*itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false,),*/
                                      itemBuilder: (context, index) => buildExpertCard(SearchCubit.get(context).searchExpertModel!.data![index],context),

                                    ),
                                  )
                                      : Container(
                                    width: widthscreen*0.9,
                                    height: heightscreen*0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white24,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'NOT FOUND  :(',
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.purple),
                                        ),
                                        SizedBox(width: 40,),
                                        Icon(
                                          Icons.search_off,
                                          size: 50,
                                          color: Colors.purple
                                          ,
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),),
                          ],
                        ),

                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildExpertCard(ExpertCardSearchModel model, context) {
  return InkWell(
    onTap:(){
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
                Text('Type: ' + '${model.type}',
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
                    '${model.price}\$'.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700

                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children:  [
              LoginCubit.get(context).isLoginAsGuest == false?
          LikeButton(
            onTap: (bool isLiked) async {
              print('isLiked= $isLiked');
              ConsultingCubit.get(context).changeFavorites(model.id!);
            },
            likeBuilder: (isLiked) {
              print('isLiked= $isLiked');

              return Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.grey,
                size: 25,
              );
            },
          )

        : Container(),
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
