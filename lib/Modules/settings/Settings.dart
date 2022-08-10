import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/Shared/styles/iconbroken.dart';

import '../../Combonants/Combonant.dart';
import '../EditProfile/EditProfile.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){} ,
      builder:(context,state){
        var usermodel=SocialCubit.get(context).userModel;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                          height: 140,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${usermodel!.cover}'),
                                fit: BoxFit.cover,
                              ))),
                    ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                            "${usermodel.image}"),
                      ),
                    ),
                  ],
                ),
              ),
              Text("${usermodel.name}",style:TextStyle(fontWeight: FontWeight.bold,)),
              Text("${usermodel.bio}",style:TextStyle(color: Colors.grey[500])),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("100",style:TextStyle(fontWeight: FontWeight.bold,)),
                            Text("post",style:TextStyle(color: Colors.grey[500])),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("262",style:TextStyle(fontWeight: FontWeight.bold,)),
                            Text("photos",style:TextStyle(color: Colors.grey[500])),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("10k",style:TextStyle(fontWeight: FontWeight.bold,)),
                            Text("followers",style:TextStyle(color: Colors.grey[500])),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text("102",style:TextStyle(fontWeight: FontWeight.bold,)),
                            Text("following",style:TextStyle(color: Colors.grey[500])),

                          ],
                        ),
                        onTap: (){},
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: (){}, child: Text("Add Photos"))),
                  SizedBox(width: 5,),
                  OutlinedButton(onPressed: (){navigateTo(context, EditProfile());}, child: Icon(
                    IconBroken.Edit,
                    size: 14 ,
                  )),
                ],
              )


            ],
          ),
        );
      } ,
    );
  }
}
