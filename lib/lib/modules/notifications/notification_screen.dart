import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/componets/our_team_components.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

class notificationScreen extends StatelessWidget {
  const notificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StatesApp>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            //backgroundColor: primColor,
            title: Text(
              'Notifications',
            ),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bmwx6.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " A new auction is added you can see it: ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          " BMW x6 car  ",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          " 22/03/2022 15:36",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1,
              color: graycolor,
            ),
            itemCount: 4,
          ),
        );
      },
    );
  }
}
