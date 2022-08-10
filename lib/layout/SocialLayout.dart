import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Combonants/Combonant.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/Modules/NewPostScreen/NewPostScreen.dart';
import 'package:social_app/Shared/styles/iconbroken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (BuildContext context, state) {
          if (state is SocialNewPostState )
            navigateTo(context, NewPostScreen());
        },
        builder: (context,  state) {
          var cubit = SocialCubit.get(context);

          return
            Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(cubit.titles[cubit.currentIndex],style: TextStyle(fontWeight: FontWeight.bold),),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
                  IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
                ],
              ),
              body:cubit.Screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeBottomNav(index);
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Feeds'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),
                ],
              ),
            );
          },
         );
  }
}
