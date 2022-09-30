import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/modules/login/loginscreen.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';

import '../../shared/componets/regestration_components.dart';
import '../../shared/cubit/appcubit.dart';
import '../../shared/cubit/states.dart';

class EmailSent extends StatelessWidget {
  const EmailSent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    return BlocConsumer<CubitApp, StatesApp>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Email has been sent!",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                      child: Text(
                        "  Please check your inbox and click  ",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Center(
                      child: Text(
                        "in the received link to reset a password ",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/auction-in-hand-f2f47.appspot.com/o/ForgetPassword%20icons%2Freceivepassword2.png?alt=media&token=e31d8ad2-829c-4760-be66-3a3bdf4586da",
                      height: 230,
                      width: 250,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    defaultButton(
                        isUpperCase: false,
                        isCircular: true,
                        height: 55,
                        CircularValue: 25,
                        text: "Login",
                        function: () async {
                          navigateTo(context, Login_Screen());
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    alreadyHaveOrNot(
                      context,
                      buttonText: "Resend",
                      text: "Didn't receive the link?",
                      onPressed: () {
                        // Resent Function()
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
