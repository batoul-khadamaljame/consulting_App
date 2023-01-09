
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consulting_app/Bloc/messanger/message_cubit.dart';
import 'package:consulting_app/Bloc/messanger/message_state.dart';
import 'package:consulting_app/Bloc/public_profile/public_profile_cubit.dart';
import 'package:consulting_app/models/get_message_model.dart';
import 'package:consulting_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var messageController = TextEditingController();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageStates>(
        listener: (context, state) {},
        builder: (
            context,
            state,
            ) {
          return ConditionalBuilder(
            condition: state is! LoadingGetMessagMessageState,
            builder:(context)=> Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Row(
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
                    SizedBox(
                      width: 15.0,
                    ),
                    ClipOval(
                      child: Image.asset(
                        "assets/images/imageprofile.jpeg",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        //PublicProfileCubit.get(context).publicExpertProfileModel!.data!.user!.name!,
                        'soos',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color.fromARGB(255, 39, 36, 36),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildMessage(),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: 6
                        //SocialCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: ThemeColors.icon,
                            child: MaterialButton(
                              onPressed: () {
                               // MessageCubit.get(context).creatmessage(chatid: MessageCubit.get(context).getMessageModel!.data![0].chat_id!, message: messageController.text);
                                messageController.clear();
                              },
                              minWidth: 1.0,
                              child: Icon(
                                Icons.send_outlined,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(color: Colors.purple,),),
          );
        });
  }

  Widget buildMessage() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 84, 162, 226),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(
                      10.0,
                    ),
                    topStart: Radius.circular(
                      10.0,
                    ),
                    topEnd: Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  //'${model.message}',
                  'sdgksfdksdfsdfsf',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                //'${model.messageDate}',
                '12/2/2023',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 83, 76, 76),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}