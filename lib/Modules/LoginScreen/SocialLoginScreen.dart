// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Combonants/Combonant.dart';
import 'package:social_app/Cubits/LoginCubits/SocialLoginCubit.dart';
import 'package:social_app/Cubits/LoginCubits/SocialLoginStates.dart';
import 'package:social_app/Modules/RegisterScreen/SocialRegisterScreen.dart';
import 'package:social_app/Shared/CasheHelper.dart';
import 'package:social_app/layout/SocialLayout.dart';

import '../../Cubits/SocialCubits.dart';


class SocialLoginScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (BuildContext context, state) {
          if (state is SocialLoginErrorState){
            showToast(
              text: state.error,
              states: ToastStates.ERROR
            );
          }
          if(state is SocialLoginSuccessState)
          {
            CacheHelper.saveDate(
              key: 'uId',
              value:state.uId,
            ).then((value) async {
              SocialCubit.get(context).getUserData(uId);
              showToast(
                text: 'Welcome in Social App',
                states: ToastStates.SUCCESS,
              );
              navigateAndFinish(context, SocialLayout());
              SocialCubit.get(context).currentIndex = 0;


            });
          }
        },
        builder: (context, Object? state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text('login now to communicate with friends ',style: TextStyle(fontSize: 14),),
                        SizedBox(height: 30,),
                        DefultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: 'Email Address',
                          validate: (String value){
                            if(value.isEmpty){
                              return 'please enter email address';
                            }return null;
                          },
                          Prefix: Icons.email_outlined,
                        ),
                        SizedBox(height: 20,),
                        DefultFormField(
                          obscureText: true,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          Suffix: SocialLoginCubit.get(context).suffix,
                          SuffixPressed:() {SocialLoginCubit.get(context).changePasswordVisibility();},

                          lable: 'Password',
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter password';
                            }
                          },
                          Prefix: Icons.lock_outline,
                        ),
                        SizedBox(height: 40,),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context)=>  DefultTextButton(
                            text: "Login", style: TextStyle(color:Colors.deepOrange),
                            isUpperCase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);

                              }
                            },
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator(),),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('do you have account ?'),
                            DefultTextButton(
                                function: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialRegisterScreen()));
                                },
                                text:'Registration'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );},

      ),
    );
  }
}
