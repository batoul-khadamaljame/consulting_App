import 'package:consulting_app/Bloc/messanger/message_state.dart';
import 'package:consulting_app/UI/Components/constants.dart';
import 'package:consulting_app/models/create_chat_model.dart';
import 'package:consulting_app/models/get_chat_model.dart';
import 'package:consulting_app/models/get_message_model.dart';
import 'package:consulting_app/network/remote/dio_helper.dart';
import 'package:consulting_app/network/remote/end_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageStates> {
  MessageCubit() : super(MessageInitialState());

  static MessageCubit get(context) => BlocProvider.of(context);

  GetChatModel? getChatModel;

  void getChatData() {
    emit(LoadingCreatMessageState());
    DioHelper.getData(
      url: GETCHAT,
      token: token,
    ).then((value) {
      getChatModel = GetChatModel.fromJson(value.data);

      print(getChatModel!.data!.length);
      for(int i=0;i<getChatModel!.data!.length;i++) {
        print(getChatModel!.data![i].name);
        print(getChatModel!.data![i].lastMessage);
        print(getChatModel!.data![i].lastMessageTime);
      }
      emit(SuccessCreatMessageState(getChatModel!));
    }).catchError((error) {
      emit(ErrorCreatMessageState(error.toString()));
      print(error.toString());
    });
  }

  CreatChatmodel? creatChatmodel;

  void creatchat({
    required int expertid,
  }) {
    emit(LoadingCreatMessageState());
    DioHelper.postData(
      url: CREATECHAT,
      token: token,
      data: {
        'expert_id': expertid,
      },
    ).then((value) {
      creatChatmodel = CreatChatmodel.fromJson(value.data);
      emit(SuccessCreatChatState(creatChatmodel!));
    }).catchError((error) {
      emit(ErrorCreatMessageState(error.toString()));
      print(error.toString());
    });
  }

  GetMessagemodel? getMessageModel;

  void getmessage(id_chat) {
    emit(LoadingGetMessagMessageState());
    DioHelper.getData(
      url: 'getMessages/${id_chat}',
      token: token,
    ).then((value) {
      getMessageModel = GetMessagemodel.fromJson(value.data);
      print(getMessageModel!.status);
      emit(SuccessGetMessageState(getMessageModel!));
    }).catchError((error) {
      emit(ErrorGetMessageState(error.toString()));
      print(error.toString());
    });
  }

  GetMessagemodel? creatmessagemodel;

  void creatmessage({
    required String chatid,
    required String message,
  }) {
    emit(LoadingGetMessagMessageState());
    DioHelper.postData(
      url: CREATMESSAGES,
      token: token,
      data: {
        'chat_id': chatid,
        'message': message,
      },
    ).then((value) {
      //print(value.data);
      creatmessagemodel = GetMessagemodel.fromJson(value.data);
      emit(SuccessGetMessageState(creatmessagemodel!));
    }).catchError((error) {
      emit(ErrorGetMessageState(error.toString()));
      print(error.toString());
    });
  }
}