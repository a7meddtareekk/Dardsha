// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Combonants/Combonant.dart';
import 'package:social_app/Cubits/LoginCubits/SocialLoginStates.dart';
import 'package:social_app/Cubits/RegisterCubits/RegisterCubit.dart';
import 'package:social_app/Cubits/RegisterCubits/RegisterStates.dart';
import 'package:social_app/layout/SocialLayout.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey =GlobalKey<FormState>();
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  var phoneController= TextEditingController();
  var nameController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is SocialCreateUserSuccessState){
            navigateAndFinish(
                context,SocialLayout());
            // showToast(
            //   text: state.error,
            //   state: ToastStates.ERROR
            // )
          }        },
        builder: ( context, Object? state) {
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
                        Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text('Register now to communicate with friends ',style: TextStyle(fontSize: 14),),
                        SizedBox(height: 30,),

                        TextFormField(
                          controller:nameController ,
                          keyboardType: TextInputType.name,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter email address ';
                            }
                            return null ;
                          },
                          decoration: const InputDecoration(
                            labelText: 'User Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20,),
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
                        TextFormField(
                          controller:passwordController ,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter password ';
                            }
                            return null ;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(Icons.visibility),
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20,),
                        DefultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          lable: 'Password',
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please enter password';
                            }
                          },
                          Prefix: Icons.phone,
                        ),
                        SizedBox(height: 40,),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context)=>  Container(
                              color: Colors.deepOrange,
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    SocialRegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                  }
                                },
                                child: Text('Register',style: TextStyle(color: Colors.white),),)),
                          fallback: (context)=>Center(child: CircularProgressIndicator(),),
                        ),
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