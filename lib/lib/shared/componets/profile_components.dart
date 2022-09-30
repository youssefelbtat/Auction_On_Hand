

 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget SeparatorLine ()=>Container(
 width: double.infinity,
 height: 1,
 color: Colors.grey,
);

Widget heightSizedBox()=>SizedBox(height: 5);

Widget editItem(context, {isPassword=false,hint,TextInputType =TextInputType.text ,required TextEditingController controller,required String lapelName})=>Row(
 children: [
  Text(
   "$lapelName",
   style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.grey.shade700),
   textAlign: TextAlign.center,
  ),
  SizedBox(width: 10,),
  Expanded(
   child: TextFormField(
    controller: controller,
    keyboardType: TextInputType,
    obscureText: isPassword,
    style: Theme.of(context).textTheme.bodyText1,
    cursorColor: Colors.grey.shade700,
    decoration: InputDecoration(
     hintText:hint ,
     border: InputBorder.none,
    ) ,
   ),
  ),

 ],
);