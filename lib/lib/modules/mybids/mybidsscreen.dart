

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/homelayoutcomponets.dart';

class myBidsScreen extends StatelessWidget {
  const myBidsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);

    return BlocConsumer<CubitApp,StatesApp>(
        listener:(context,state){},
        builder: (context,state){
          return tasksBuilder(model: cubit.myBidList);
        },
    );
  }
}
