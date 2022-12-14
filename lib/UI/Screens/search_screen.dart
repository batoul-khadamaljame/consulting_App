import 'package:consulting_app/Bloc/search/search_cubit.dart';
import 'package:consulting_app/Bloc/search/search_state.dart';
import 'package:consulting_app/UI/Screens/home.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';


var searchController = TextEditingController();
var formKey = GlobalKey<FormState>();

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double heightscreen = MediaQuery.of(context).size.height;
    double widthscreen = MediaQuery.of(context).size.width;


    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String text){
                        SearchCubit.get(context).search(text);
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
                    ),
                    SizedBox(height: 15,),
                    if(state is SearchLoadingState)
                      const CircularProgressIndicator(),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if(state is SearchSuccessState)
                      Expanded(child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: expertsList.length,
                          /*itemCount: SearchCubit.get(context).model!.data!.data!.length,*/
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                                height: heightscreen*0.02,
                              ),

                          itemBuilder: (context, index) => buildExpertCard(expertsList[index].id,expertsList[index].rate.toString() ,expertsList[index].name, expertsList[index].type, expertsList[index].price.toString(), expertsList[index].image, expertsList[index].inFavorites)

                        /*itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false,),*/
                      ),)
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
            children: [
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


  }*/