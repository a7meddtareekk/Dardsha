// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Cubits/SocialStates.dart';
import 'package:social_app/Modules/NewPostScreen/NewPostScreen.dart';
import 'package:social_app/Modules/chats/Chats.dart';
import 'package:social_app/Modules/feeds/Feeds.dart';
import 'package:social_app/Modules/settings/Settings.dart';
import 'package:social_app/model/CommentModel.dart';
import 'package:social_app/model/messageModel.dart';
import 'package:social_app/model/postModel.dart';
import 'package:social_app/model/socialUserModel.dart';
import '../Combonants/Combonant.dart';
import '../Modules/CommentScreen/CommentScreen.dart';
import '../Modules/users/Users.dart';
import '../Shared/CasheHelper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? userModel;

  void getUserData(String? uId) {
    emit(SocialGetUserLoadingState());
    uId = CacheHelper.getData(key: 'uId');
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  int currentIndex = 0;

  List<Widget> Screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }

    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  var _picker = ImagePicker();
  File? ProfileImage;

  Future<void> getProfileImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image Selected');
      emit(SocialProfileImagePickedErrorState());
    }
    ;
  }

  File? CoverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('no image Selected');
      emit(SocialCoverImagePickedErrorState());
    }
    ;
  }

  void removePostImage() {
    PostImage = null;
    emit(SocialRemovePostImageState());
  }

  void UploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(ProfileImage!.path)
        .pathSegments
        .last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImagePickedSuccessState());
        print(value);
        UpdateUser(phone: phone, bio: bio, name: name, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImagePickedErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImagePickedErrorState());
    });
  }

  void UploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateCoverLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(CoverImage!.path)
        .pathSegments
        .last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImagePickedSuccessState());
        print(value);
        UpdateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImagePickedErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImagePickedErrorState());
    });
  }

  // void UpdateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (CoverImage != null) {
  //     UploadCoverImage();
  //   } else if (ProfileImage != null) {
  //     UploadProfileImage();
  //   } else {
  //     UpdateUser(name: name,phone: phone,bio: bio);
  //   }
  // }

  void UpdateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
        bio: bio,
        name: name,
        phone: phone,
        email: userModel!.email,
        cover: cover ?? userModel!.cover,
        image: image ?? userModel!.image,
        uId: userModel!.uId,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData(uId);
    }).catchError((onError) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? PostImage;

  Future<void> getPostImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      PostImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('no image Selected');
      emit(SocialPostImagePickedErrorState());
    }
    ;
  }

  void UploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(PostImage!.path)
        .pathSegments
        .last}')
        .putFile(PostImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadCoverImagePickedSuccessState());
        print(value);
        CreatePost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void CreatePost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((onError) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel>posts = [];
  List<String>postsId = [];
  List<int>likes = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('likes')
            .get()
            .then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
            .catchError((onError) {

        });
      });
      emit(SocialGetPostsSuccessState());
    })
        .catchError((onError) {
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }


  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true
    })
        .then((value) {
      emit(SocialLikePostsSuccessState());
    })
        .catchError((onError) {
      emit(SocialLikePostsErrorState(onError.toString()));
    });
  }
  List<CommentModel>comment = [];
  //List<int>comments = [];

  void CommentPost({
   required String postId,

   required String dateTime,
   String ? comment
  }) {

    CommentModel commentModel=CommentModel(
      dateTime: dateTime,
      text: comment,
      image: userModel!.image,
      name: userModel!.name,
    );
    emit(SocialCommentPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .add(commentModel.toMap())
        .then((value) {
      emit(SocialCommentPostsSuccessState());
    })
        .catchError((onError) {
      emit(SocialCommentPostsErrorState(onError.toString()));
    });
  }


  void getComments(postId) {
    emit(SocialGetCommentPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection("comment")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comment=[];
      event.docs.forEach((element) {
        comment.add(CommentModel.fromJson(element.data()));
        emit(SocialGetCommentPostsSuccessState());
      });
    });
  }


  List<SocialUserModel>users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if(element.data()['uId']!=userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessState());
      })
          .catchError((onError) {
        emit(SocialGetAllUserErrorState(onError.toString()));
      });
    }
  }


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        text: text,
        senderId: userModel!.uId,
        dateTime: dateTime,
        receiverId: receiverId
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
          emit(SocialSendMessageSuccessState());
    })
        .catchError((onError){
          emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SocialSendMessageSuccessState());
    })
        .catchError((onError){
      emit(SocialSendMessageErrorState());
    });


  }

  List<MessageModel>message=[];
  void getMessages({
    required String receiverId,
  }){
    FirebaseFirestore
        .instance
        .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots()
    .listen((event) {
      message=[];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    })

    ;
  }
  ShowAppthem(context){
    showBottomSheet(builder: (buildContext){
      //return ShowBottomSheet();
      return CommentScreen(postId: userModel!.uId,); }, context: context);
  }
}
