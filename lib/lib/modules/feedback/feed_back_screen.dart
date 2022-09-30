

import 'package:emoji_feedback/emoji_feedback.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/componets.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CubitApp,StatesApp>(
      listener:(context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primeColor,
            title:Text(
              'Help&Feedback',
            ) ,
          ),
          body:SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/logos/feedback.png'
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please rate your experience.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 6,),
                          Center(
                            child: Container(
                              child: EmojiFeedback(
                                currentIndex: 4,
                                onChange: (index){
                                  print(index);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            'Additional Comments',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          SizedBox(height: 4,),
                          TextFormField(
                            maxLines: 6,
                            cursorColor: primeColor,
                            decoration: InputDecoration(
                              border:InputBorder.none ,
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Write your problem or feedback experience here.',

                            ),

                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: defaultButton(
                              text: 'Submit',
                                function: () async{
                                Fluttertoast.showToast(
                                    msg: "Thank Your Feedback sent!",
                                    backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG,
                                  fontSize: 14,
                                );
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
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
