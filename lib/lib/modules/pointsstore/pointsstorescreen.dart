

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/models/giftmodel.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/auctions_details_components.dart';
import '../../shared/componets/homelayoutcomponets.dart';
import '../../shared/componets/pointstorecomponents.dart';

class pointsStoreScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);
    return BlocConsumer<CubitApp,StatesApp>(
      listener:(context,state){},
      builder: (context,state){

        return Container(
          height: double.infinity,
          padding: EdgeInsets.only(top: 8),
          color: Theme.of(context).brightness == Brightness.light
              ? Color(0xF7EFEAEA)
              : Color(0xED171717),
          child: GridView.count(
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.50,
            children: List.generate(cubit.GiftItemsList.length, (index) {
              return googleCardItem(context, cubit.GiftItemsList[index]);
            }),
            // cubit.auctionModelList.map((model) {
            //   return auctionItemInHome(context, model);
            // }).toList(),
          ),
        );
      },
    );
  }
}
