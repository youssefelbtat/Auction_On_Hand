

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/homelayoutcomponets.dart';

class myFavoriteScreen extends StatelessWidget {
  const myFavoriteScreen({Key? key}) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 8,
              end: 8,
              bottom: 4,
            ),
            child: GridView.count(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.82,
              children: List.generate(5, (index) {
                    return auctionItemInHome(context, cubit.allAuctionsList[index+2]);

              }),
            ),
          ),
        );
      },
    );
  }
}
