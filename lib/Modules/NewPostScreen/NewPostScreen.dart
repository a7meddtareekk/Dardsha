import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Combonants/Combonant.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/Shared/styles/iconbroken.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: defultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              DefultTextButton(function: () {

                var now = DateTime.now();
                if (SocialCubit
                    .get(context)
                    .PostImage == null) {
                  SocialCubit.get(context).CreatePost(
                      dateTime: now.toString(), text: textController.text);
                } else {
                  SocialCubit.get(context).UploadPostImage(
                      dateTime: now.toString(), text: textController.text);
                }
              }, text: "POST")
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 5,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "https://cdn-2.tstatic.net/banten/foto/bank/images/wanita-beruntung-menurut-zodiak.jpg"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ahmed Tarek",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "Public",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: "what is in your mind ...  ",
                        border: InputBorder.none),

                  ),
                ),
                if (SocialCubit.get(context).PostImage!=null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image:  FileImage(SocialCubit.get(context).PostImage!),
                              fit: BoxFit.cover,
                            ))),
                    IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.close,
                              size: 16,
                            )))
                  ],
                ),
                Row(

                  children: [

                    Expanded(
                      child: TextButton(onPressed: () {
                        SocialCubit.get(context).getPostImage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Image, color: Colors.deepOrange,),
                          SizedBox(width: 5),
                          Text("Add Photo",
                            style: TextStyle(color: Colors.deepOrange),),
                        ],)),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () {}, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(IconBroken.Image, color: Colors.deepOrange,),
                          SizedBox(width: 5),
                          Text("Tags",
                            style: TextStyle(color: Colors.deepOrange),),
                        ],)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },

    );
  }
}
