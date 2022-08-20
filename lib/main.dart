// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubits/SocialCubits.dart';
import 'package:social_app/Modules/RegisterScreen/SocialRegisterScreen.dart';
import 'package:social_app/Shared/CasheHelper.dart';
import 'package:social_app/Shared/DioHelper.dart';
import 'Combonants/Combonant.dart';
import 'Modules/LoginScreen/SocialLoginScreen.dart';
import 'Shared/AppCubit/cubit.dart';
import 'Shared/AppCubit/states.dart';
import 'Shared/styles/themes.dart';
import 'layout/SocialLayout.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  print(message.data.toString());
  showToast(text: 'on background message', states: ToastStates.SUCCESS);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = FirebaseMessaging.instance.getToken();
  print("token is :$token");
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message', states: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'on message opened app', states: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler) ;

  await CacheHelper.init();
  bool ? isDarkMode = CacheHelper.getData(key: 'isDarkMode');
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  // if ( uId !=null)
  //   {
  //
  //   }
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }
  runApp(MyApp(widget ,isDarkMode,uId ));
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;
  String? uId;
  bool ? isDarkMode;

  String? postId;

  MyApp(this.startWidget, this.isDarkMode,String? uId, {Key? key}) : super(key: key) ;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (BuildContext context)  => AppCubit()..changeAppMode(fromShared: isDarkMode,),

        ),
        BlocProvider(
            create: ( context) => SocialCubit()..getUserData(uId)..getPosts()..getComments(postId))
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: ( context, state) {},
        builder: ( context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: MyTheme.lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
