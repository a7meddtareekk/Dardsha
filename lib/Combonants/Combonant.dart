// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/Shared/styles/iconbroken.dart';

AppBar defultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
})=>AppBar(
leading: IconButton(
  onPressed: (){
    Navigator.pop(context);
  },
  icon: Icon(
    IconBroken.Arrow___Left
  ),
),
  titleSpacing: 5,
  title: Text(title!),
  actions: actions,
);


Widget myDivider() => Padding(
  padding: const EdgeInsets.all(5.0),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[400],
  ),
);





Widget DefultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  bool isClickable = true,
  // Function? onSubmit,
  // Function? onChange,
  Function? validate,
  bool obscureText=false,
  Function? SuffixPressed,
  required String lable,
  required IconData Prefix,
  IconData? Suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText:obscureText ,
      validator: (s){return validate!(s);},
      // onChanged: (s){onChange!(s);},
      decoration: InputDecoration(
        labelText: '${lable},',
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Prefix),
        suffixIcon:Suffix!=null? IconButton(icon:Icon(Suffix),onPressed: (){SuffixPressed!();},):null,

        border: OutlineInputBorder(),
      ),
     // onFieldSubmitted: (s){onSubmit!(s);},
    );


Widget DefultTextButton ({
  bool isUpperCase = true,
  TextStyle? style,
  required Function function,
  required String text ,
})=>TextButton(onPressed: (){function();}, child: Text('${text.toUpperCase()}',style: TextStyle(color: Colors.deepOrange,),),);

void showToast({
  required String text ,
  required ToastStates states,
})=>Fluttertoast.showToast(
    msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity:  ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: ChooseToastColor(states),
  textColor: Colors.white,
  fontSize: 16,

);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color ChooseToastColor(ToastStates states){
  Color color ;
  switch(states)
      {
        case ToastStates.SUCCESS:
          color= Colors.green;
            break;
             case ToastStates.ERROR:
          color= Colors.red;
            break;
             case ToastStates.WARNING:
          color= Colors.amber;
            break;

      }
      return color;
}
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route)
  {
    return false;
  },
);
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  TextStyle? style,
  String ? label,
  TextStyle? labelStyle,
  required String text,
  bool isUpperCase = true,
  double radius = 3,
  required Function function,

}) =>
    Container(
      height: 40,
      width: width,
      child: MaterialButton(
        // ignore: unnecessary_statements
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text ,
          style: TextStyle(color: Colors.white),

        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,

        ),
        color: background,

      ),
    );




String token = '';
String? uId = '';
