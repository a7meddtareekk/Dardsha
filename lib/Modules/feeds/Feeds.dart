import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Combonants/Combonant.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/Modules/CommentScreen/CommentScreen.dart';
import 'package:social_app/Shared/styles/iconbroken.dart';
import 'package:social_app/model/postModel.dart';

class FeedsScreen extends StatelessWidget {
  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context, state) {
        return ConditionalBuilder(
        condition:SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel !=null ,
        builder:(context)=>SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                elevation: 10,
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      image: const NetworkImage(
                          'https://www.cyberlink.com/prog/learning-center/html/6221/PDR19-YouTube-49_The_Best_Intro_Maker_App_for_iPhone_Android/img/IntroMaker.png'),
                      fit: BoxFit.cover,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Communicate with friends',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                itemCount: SocialCubit.get(context).posts.length,
                separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 10,),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ) ,
        fallback:(context)=>Center(child: CircularProgressIndicator()) ,
      );},
    );
  }

  Widget buildPostItem(PostModel model,context,index) => Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "${SocialCubit.get(context).userModel!.image}"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${model.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 15,
                            )
                          ],
                        ),
                        Text(
                          "${model.dateTime}",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 17,
                    ),
                    color: Colors.black,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  color: Colors.grey[300],
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Text(
                '${model.text} ',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Container(
                          height: 20,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '#AhmedTarek',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                            padding: EdgeInsets.zero,
                            minWidth: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Container(
                          height: 20,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              '#AhmedTarek',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 12),
                            ),
                            padding: EdgeInsets.zero,
                            minWidth: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(model.postImage!='')
                Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${model.postImage}'),
                          fit: BoxFit.cover,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(IconBroken.Heart,
                                  size: 18, color: Colors.red),
                              Text(
                                '${SocialCubit.get(context).likes[index]} Likes',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(IconBroken.Chat,
                                  size: 18, color: Colors.amber),
                              Text(
                                '0 comment',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  color: Colors.grey[300],
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Heart,color: Colors.red,size: 18,),
                          Text("Like",style:TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                      onTap: (){
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Chat,color: Colors.amber,size: 18,),
                          Text("Comment",style:TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                      onTap: (){
                        SocialCubit.get(context).ShowAppthem(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Send,color: Colors.blue,size: 18,),
                          Text("Share",style:TextStyle(color: Colors.grey[500])),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),


                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  color: Colors.grey[300],
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                ),
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
              ),
            ],
          ),
        ),
      );
}
