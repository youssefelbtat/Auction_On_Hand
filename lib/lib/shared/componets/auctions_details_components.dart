import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';

Widget coinImage() => Container(
      height: 29,
      width: 29,
      child: Image.network(
          "https://firebasestorage.googleapis.com/v0/b/auction-in-hand-f2f47.appspot.com/o/dollar.png?alt=media&token=946dfdf5-7e6c-4235-9d74-9df6d877bd59"),
    );

Widget buildSmallPreview(int index, context,image) => GestureDetector(
  onTap: (){
    CubitApp.get(context).onChangedSelectedSmallAuctionImage(index);
  },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        padding: EdgeInsets.all(4),
        width: 66,
        height: 66,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: CubitApp.get(context).selectedSmallAuctionImage == index
                  ? Colors.lightBlue
                  : Colors.transparent),
        ),
        child: Image.network(
          "${image.toString()}",
          fit: BoxFit.fill,
        ),
      ),
    );

Widget buildDescriptionText(context,{required String title,required String description})=>RichText(
  text: TextSpan(
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade700,
    ),
    children: <TextSpan>[
      TextSpan(text: description),
      TextSpan(
        text:title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  ),
);

Widget liveAuctionsBar()=>Container(
  margin: EdgeInsets.all(8),
  height: 20,
  width: 50,
  color: Color(0xffE6F10505),
  child: Text(
    "LIVE",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
);

