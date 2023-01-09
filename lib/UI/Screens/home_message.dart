
import 'package:consulting_app/Bloc/messanger/message_cubit.dart';
import 'package:consulting_app/Bloc/messanger/message_state.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_cubit.dart';
import 'package:consulting_app/models/get_chat_model.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/login/login_cubit.dart';
import 'package:consulting_app/Bloc/login/login_state.dart';
import 'package:consulting_app/Bloc/register/register_cubit.dart';
import 'package:consulting_app/UI/Components/components.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/network/local/cash_helper.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/src/widgets/container.dart';



class HomeMessageScreen extends StatefulWidget {
  const HomeMessageScreen({super.key});

  @override
  State<HomeMessageScreen> createState() => _HomeMessageScreenState();
}

class _HomeMessageScreenState extends State<HomeMessageScreen> {
  @override
  Widget build(BuildContext context) {
    var model = MessageCubit.get(context).getChatModel;
    return BlocConsumer<MessageCubit, MessageStates>(
      listener: (context, state) {},
      builder: (
          context,
          state,
          ) {
        return ConditionalBuilder(
          condition: state is! LoadingCreatMessageState,
          builder: (context) => Scaffold(
            backgroundColor: ThemeColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: ThemeColors.backgroundColor,
              elevation: 0.0,
              titleSpacing: 20.0,
              title: Row(
                children: [
                  SizedBox(
                    width: 15.0,
                  ),
                  Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.notifications_active,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.edit,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 3,
                        color: Colors.black12,
                      ),
                      itemBuilder: (context, index) => buildChatItem(
                          MessageCubit.get(context).getChatModel!.data![index],
                          context),
                      itemCount:
                      MessageCubit.get(context).getChatModel!.data!.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => CircularProgressIndicator(
            color: Colors.purple,
          ),
        );
      },
    );
  }

  Widget buildChatItem(ChatDadtaModel model, context) => InkWell(
    onTap: () {
      MessageCubit.get(context)
          .getmessage(model.chat_id);

      Navigator.of(context)
          .pushReplacementNamed('/chat');
    },
    child: Container(
      padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
      height: 100,
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/imageprofile.jpeg",
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  //'user name',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${model.lastMessage}',
                        //'hello my name nnmnjmjnj',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Container(
                        width: 7.0,
                        height: 7.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text(
                      '',//'${model..lasttime}',
                      //'07:00',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}