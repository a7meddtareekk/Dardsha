
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/model/CommentModel.dart';

import '../../Shared/styles/iconbroken.dart';
import '../../model/socialUserModel.dart';

class CommentScreen extends StatelessWidget {
 var textController=TextEditingController();
CommentModel? commentModel;
 SocialUserModel? userModel;
 String? postId;

 CommentScreen({this.postId});

  @override
  Widget build(BuildContext context) {
    String? postId = this.postId;
    return Builder(
      builder:(context) {
        SocialCubit.get(context).getComments(postId);
        return BlocConsumer<SocialCubit,SocialStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {

          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                      itemBuilder: (context,index){
                      var comment=SocialCubit.get(context).comment[index];
                      return buildCommentItem(comment);},
                      separatorBuilder: (BuildContext context,index)=>SizedBox(height: 5,),
                      itemCount: SocialCubit.get(context)
                          .comment
                          .length),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                "${SocialCubit.get(context).userModel!.image}"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.04,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 0.7
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
                                          style: TextStyle(fontSize: 12),
                                          controller: textController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Write Your Comment Here ',
                                              hintStyle: TextStyle(fontSize: 10,color: Colors.grey[400])
                                          ),
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        SocialCubit.get(context).CommentPost(
                                            postId: SocialCubit.get(context).userModel!.uId!,
                                            comment: textController.text,
                                            dateTime: DateTime.now().toString());
                                      },
                                      minWidth: 1,
                                      child: Icon(
                                        IconBroken.Arrow___Right_Square, size: 16, color: Colors.blue,),
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),

                    ),
                    InkWell(
                      child: Icon(IconBroken.Camera, size: 18, color: Colors.red),
                      onTap: () {},
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      child: Icon(Icons.emoji_emotions_outlined, size: 18, color: Colors.amber),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ) ;
        },

      );}
    );
  }

  Widget buildCommentItem(CommentModel commentModel)=> Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('${commentModel.image}'),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${commentModel.name}",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("${commentModel.text}",),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                  child: Row(
                    children: [
                      Text('${commentModel.dateTime}',style: TextStyle(color: Colors.grey,fontSize: 11),),
                      SizedBox(width: 8,),
                      InkWell(onTap: (){}, child: Text('Like',style: TextStyle(color: Colors.grey,fontSize: 11,fontWeight: FontWeight.bold)),),
                      SizedBox(width: 8,),
                      InkWell(onTap: (){}, child: Text('Reply',style: TextStyle(color: Colors.grey,fontSize: 11,fontWeight: FontWeight.bold))),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
}
