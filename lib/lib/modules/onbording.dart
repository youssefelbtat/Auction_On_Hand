// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/network/end_points.dart';
import 'package:shoping_app/lib/shared/network/local/sharedpreferences.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login/loginscreen.dart';



class OnBordingScreen extends StatelessWidget {
  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp, StatesApp>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CubitApp.get(context);
          return Scaffold(
            appBar: AppBar(
              title: darkModeButton(context),
              actions: [
                TextButton(
                    onPressed: () {
                      skipOnBording(context);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          cubit.onBoardingChanged(index);
                          print("current index is:${cubit.currentBoardingIndex}");
                        },
                        physics: const BouncingScrollPhysics(),
                        controller: boardController,
                        itemBuilder: (context, index) =>
                            buildBoardingItem(cubit.boardingitems[index],context),
                        itemCount: cubit.boardingitems.length,
                      ),
                    ),
                    Row(mainAxisSize: MainAxisSize.max, children: [
                      Expanded(
                        child: TextButton(
                            onPressed: cubit.currentBoardingIndex != 0
                                ? () {
                              cubit.decrement();
                              boardController.previousPage(
                                duration:
                                const Duration(milliseconds: 300),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                            }
                             :  null,
                            child: Text(
                              'Previous',
//textAlign: TextAlign.left,
                              style:  TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).brightness == Brightness.dark && cubit.currentBoardingIndex==0
                                    ? Colors.grey
                                    : null,
                              ),
                            )),
                      ),
                      Expanded(
                        child: Center(
                          child: SmoothPageIndicator(
                              controller: boardController,
                              effect: const WormEffect(
                                dotColor: Colors.grey,
                                activeDotColor: primColor,
                              ),
                              count: cubit.boardingitems.length),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              if (cubit.currentBoardingIndex == 2) {
                                     skipOnBording(context);
                              } else {
                                boardController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                );
                              }
                              cubit.Increment();
                            },
                            child: const Text(
                              'Next',
                              textAlign: TextAlign.end,
//textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
                      ),
                    ]),
                  ]),
            ),
          );
        });
  }
  void skipOnBording(context){
    CachHelper.setData(key: 'skipOnBording', value: true).then((value) {
      if(value){
        navigateAndDelete(context, Login_Screen());
      }
    });

  }
}
