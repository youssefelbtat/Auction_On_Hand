import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';

Widget buildUploadAuctionPictureList({required context, required  picLink,required index}) =>
    Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          child: Image.file(File(picLink.path)
)),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 12,
          child: IconButton(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              right: 8,
            ),
            onPressed: () {
              CubitApp.get(context).addAuctionRemoveSelectedPicture(index);
              //Cancel Image function
            },
            color: Colors.red[600],
            icon: Icon(Icons.cancel),),
        ),

      ],
    );
