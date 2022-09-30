import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styel/colors.dart';
import 'componets.dart';

Widget regesterText(
  context, {
  String text = 'Login',
}) {
  return Container(
    alignment: AlignmentDirectional.centerStart,
    child: Text(
      text,
      style: TextStyle(
          fontSize: 38, color: primColor, fontWeight: FontWeight.bold),
    ),
  );
}

Widget logoInRegestration(
  context, {
  String image = 'assets/logos/locoicon.png',
}) {
  return Center(
    child: Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: Image.asset(
          image,
          width: 160,
          height: 110,
          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}

Widget regesterSubTitleText(
  context, {
  String text = 'please fill the inputs below here',
}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText2,
  );
}

Widget forgetPassword(
  context, {
  required Function() onPressed,
}) {
  return Container(
    alignment: AlignmentDirectional.centerEnd,
    child: TextButton(
      onPressed: onPressed,
      child: const Text(
        'Forget Password?',
        style: TextStyle(
          color: Color(0xFFF11909),
        ),
      ),
    ),
  );
}

Widget orRegestreWith(context,{
  String text='Or login with',
}){
  return Center(
    child: Text(
      text,
      style: TextStyle(
        color: graycolor,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    ),
  );
}

Widget loginWithGoogle (context,{
  required Function() onGoPressed,
}){
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   height: 44,
        //   width: 44,
        //   child: IconButton(
        //     icon: Image.asset(
        //         'assets/logos/facebookicon.png'),
        //     onPressed: onFdPressed,
        //   ),
        // ),
        // SizedBox(
        //   width: 8,
        // ),
        Container(
          height: 70,
          width: 70,
          child: IconButton(
            icon: Image.asset(
                'assets/logos/googleicon.png'),
            onPressed: onGoPressed,
          ),
        ),
      ],
    ),
  );
}

Widget alreadyHaveOrNot(context,{
  String text='Don\'t have an account ?',
  String buttonText='Register Now',
  required Function() onPressed,
}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      TextButton(
        onPressed: onPressed,
        child:  Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  );
}
