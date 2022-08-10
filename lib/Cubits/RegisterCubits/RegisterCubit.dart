// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/socialUserModel.dart';
import '../../Shared/DioHelper.dart';

import '../LoginCubits/SocialLoginStates.dart';
import 'RegisterStates.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(uId: value.user!.uid, phone: phone, name: name, email: email);
    }).catchError((onError) {
      print(onError.toString());

      emit(SocialRegisterErrorState(onError.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model =
        SocialUserModel(
            email: email,
            bio: 'write bio',
            name: name,
            phone: phone,
            image:'https://api.time.com/wp-content/uploads/2019/12/time-person-of-the-year-joe-biden-portrait.jpg?w=700&w=700',
            cover:'https://api.time.com/wp-content/uploads/2019/12/time-person-of-the-year-joe-biden-portrait.jpg?w=700&w=700',
            uId: uId,
            isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SocialCreateUserErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  }
}
