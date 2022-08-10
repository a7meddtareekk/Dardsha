import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/model/messageModel.dart';
import 'package:social_app/model/socialUserModel.dart';

import '../../../Shared/styles/iconbroken.dart';

class ChatsDetailsScreen extends StatelessWidget {

  SocialUserModel? userModel;

  ChatsDetailsScreen({this.userModel});

  var messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder:(BuildContext context){
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(

        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userModel!.image!),
                      ),
                      SizedBox(width: 10,),
                      Text(userModel!.name!)

                    ],),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                     Expanded(
                       child: ListView.separated(
                         physics: BouncingScrollPhysics(),
                           itemBuilder:(context,index){
                             var message=SocialCubit.get(context).message[index];
                             if(SocialCubit.get(context).userModel!.uId==message.senderId){
                               return buildMyMessage(message);
                             }
                             return buildMessage(message);
                           } ,
                           separatorBuilder: (context,index)=>SizedBox(height: 15,),
                           itemCount: SocialCubit.get(context).message.length),
                     ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.blue,

                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text);
                                },
                                minWidth: 1,
                                child: Icon(
                                  IconBroken.Send, size: 16, color: Colors.white,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
              },
      );}
    );
  }

  Widget buildMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
            ),
            child: Text(model.text!)),
      );

  Widget buildMyMessage(MessageModel model) =>
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
            ),
            child: Text(model.text!)),
      );
}
