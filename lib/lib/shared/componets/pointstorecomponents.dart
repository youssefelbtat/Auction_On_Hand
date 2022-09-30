


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/lib/models/giftmodel.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import 'auctions_details_components.dart';

Widget googleCardItem(
    BuildContext context,
    GiftModel model,

) {
  return Container(
    child: Card(
      child: Column(
        children: [
          Image.network(
              "${model.image}",
            width: 110,
            height: 160,
            fit: BoxFit.cover,
          ),
          Text(
            "${model.text}",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 7,),
              Text(
                "${model.price.toString()}",
                style: TextStyle(
                  fontSize: 16,
                   color: Colors.black,
                   fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5,),
              coinImage(),
            ],
          ),
          MaterialButton(
            color: primColor,
            height: 30,
              onPressed: (){
              if( (CubitApp.get(context).userDate?.numOfPoints)!< num.parse(model.price.toString())  )
                Fluttertoast.showToast(
                    msg: "Sorry, you don't have enough points!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            child: Text(
              "Replace",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

        ],
      ),
      elevation: 8,
      shadowColor: Colors.lightBlue,
      margin: EdgeInsets.all(8),
    ),
  );
}