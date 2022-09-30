




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/componets/our_team_components.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/componets.dart';
import '../../shared/componets/homelayoutcomponets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=CubitApp.get(context);
    var SearchControl = TextEditingController();
    return BlocConsumer<CubitApp,StatesApp>(
      listener:(context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body:Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(8),
                child: defulteditTextx(
                      Controlar: SearchControl,
                      keyboardType: TextInputType.text,
                      Lable: 'Search',
                      InputDecorationn: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16,),
                          borderSide: BorderSide(
                            color: Colors.white ,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      onchanged: (value)
                      {
                        for(int i=0;i<cubit.vehiclesList.length;i++)
                        print("Cars: ${cubit.vehiclesList[i].product_model!.pro_title}");
                        for(int i=0;i<cubit.ElectronicsList.length;i++)
                          print("Electronic: ${cubit.ElectronicsList[i].product_model!.pro_title}");
                      }
                  ),
                ),
             SizedBox(height: 5,),

             //Search iteam
                // Expanded(child: articalbuilder(list , isSearch: true)),
            ],
          ) ,
        );

      },
    );
  }
}
