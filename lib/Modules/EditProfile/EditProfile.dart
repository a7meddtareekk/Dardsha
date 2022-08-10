import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Combonants/Combonant.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/Shared/styles/iconbroken.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).ProfileImage;
        var CoverImage = SocialCubit.get(context).CoverImage;
        nameController.text = usermodel!.name!;
        bioController.text = usermodel.bio!;
        phoneController.text = usermodel.phone!;

        return Scaffold(
          appBar:
              defultAppBar(context: context, title: 'Edit Profile', actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: DefultTextButton(
                  function: () {
                    SocialCubit.get(context).UpdateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: "update"),
            )
          ]),
          body: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateProfileLoadingState|| state is SocialUserUpdateCoverLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUserUpdateProfileLoadingState|| state is SocialUserUpdateCoverLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                  height: 140,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: (CoverImage == null
                                            ? NetworkImage('${usermodel.cover}')
                                            : FileImage(
                                                CoverImage)) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ))),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16,
                                      )))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: (profileImage == null
                                    ? NetworkImage("${usermodel.image}")
                                    : FileImage(profileImage)) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16,
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).ProfileImage !=null || SocialCubit.get(context).CoverImage !=null)
                    Row(
                    children: [
                      if(SocialCubit.get(context).ProfileImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: "UPLOAD PROFILE",
                                  function: () {
                                    SocialCubit.get(context).UploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                  }),
                              if (state is SocialUserUpdateProfileLoadingState)
                                SizedBox(height: 5,),
                              if (state is SocialUserUpdateProfileLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      if(SocialCubit.get(context).CoverImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: "UPLOAD COVER",
                                  function: () {
                                    SocialCubit.get(context).UploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                  }),
                              if (state is SocialUserUpdateCoverLoadingState)
                                SizedBox(height: 5,),
                              if (state is SocialUserUpdateCoverLoadingState)
                                LinearProgressIndicator(),
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefultFormField(
                      controller: nameController,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must be not empty';
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      lable: "Name",
                      Prefix: IconBroken.User),
                  SizedBox(
                    height: 10,
                  ),
                  DefultFormField(
                      controller: bioController,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'bio must be not empty';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      lable: "Bio....",
                      Prefix: IconBroken.Info_Circle),
                  SizedBox(
                    height: 10,
                  ),
                  DefultFormField(
                      controller: phoneController,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must be not empty';
                        }
                        return null;
                      },
                      type: TextInputType.phone,
                      lable: "Phone Number",
                      Prefix: IconBroken.Call),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
