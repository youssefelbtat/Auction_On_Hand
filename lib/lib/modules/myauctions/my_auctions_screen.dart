

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/homelayoutcomponets.dart';

class MyAuctionScreen extends StatelessWidget {
  const MyAuctionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);
    return BlocConsumer<CubitApp,StatesApp>(
      listener:(context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text("My auctions"),
          ),
          // body: Container(
          //   padding: EdgeInsets.only(top: 8),
          //   height: double.infinity,
          //   color: Theme.of(context).brightness == Brightness.light
          //       ? Colors.grey[200]
          //       : Color(0xED171717),
          //   child: Padding(
          //     padding: const EdgeInsetsDirectional.only(
          //       start: 8,
          //       end: 8,
          //       bottom: 4,
          //     ),
          //     child: GridView.count(
          //       mainAxisSpacing: 4,
          //       crossAxisSpacing: 4,
          //       shrinkWrap: true,
          //       crossAxisCount: 2,
          //       childAspectRatio: 1 / 1.86,
          //       children: List.generate(1, (index) {
          //         return auctionItemInHome(context, cubit.allAuctionsList[index]);
          //       }),
          //       // cubit.auctionModelList.map((model) {
          //       //   return auctionItemInHome(context, model);
          //       // }).toList(),
          //     ),
          //   ),
          // ),
          body: tasksBuilder(model: cubit.myAuctionsList),
        );
      },
    );
  }
}
