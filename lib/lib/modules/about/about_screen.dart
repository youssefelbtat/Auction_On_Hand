

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/componets/our_team_components.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitApp,StatesApp>(
      listener:(context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            //backgroundColor: primColor,
            title:Text('About Us',) ,
          ),
          body:Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Our Team',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: primColor,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      outTeamMember(
                        image: 'assets/ourteam/joe.jpg',
                        name: 'Youssef Elbtat'
                      ),
                      SizedBox(width: 7,),
                      outTeamMember(
                          image: 'assets/ourteam/abdo.jpeg',
                          name: 'Abdalhy Elkemary'
                      ),
                      SizedBox(width: 7,),
                      outTeamMember(
                          image: "assets/ourteam/ahmed.jpeg",
                          name: 'Ahmed Alkady'
                      ),

                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      outTeamMember(
                          image: 'assets/ourteam/mostafa.jpg',
                          name: 'Moustafa Mahmoud',
                      ),
                      SizedBox(width: 7,),
                      outTeamMember(
                          image: 'assets/ourteam/mawi.jpg',
                          name: 'Youssef Elmawi',
                      ),
                      SizedBox(width: 7,),
                      outTeamMember(
                          image: 'assets/ourteam/Romeo.JPG',
                          name: 'Ramadan Elkemary',
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ) ,
        );

      },
    );
  }
}
