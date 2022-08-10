import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/Modules/chats/ChatsDetailsScreen/chatsDetails.dart';
import 'package:social_app/model/socialUserModel.dart';

import '../../Combonants/Combonant.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0 ,
          builder:(context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: SocialCubit.get(context).users.length),
          fallback: (context)=>Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('no Chats Yet'),
              SizedBox(height: 10,),
              CircularProgressIndicator(),
            ],
          )),
        );},

    ) ;
  }

  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    onTap: (){
      navigateTo(context, ChatsDetailsScreen(userModel:model));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                "${model.image}"),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "${model.name}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14),
          ),

        ],
      ),
    ),
  );
}
