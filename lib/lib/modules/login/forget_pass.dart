import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/modules/login/email_sent.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';

import '../../shared/componets/regestration_components.dart';
import '../../shared/cubit/appcubit.dart';
import '../../shared/cubit/states.dart';
import 'loginscreen.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<CubitApp, StatesApp>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Forget your password?",
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
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
                          "  Enter your registered email below  ",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Center(
                        child: Text(
                          "to receive your password reset instruction.",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/auction-in-hand-f2f47.appspot.com/o/ForgetPassword%20icons%2Freceivepassword1.png?alt=media&token=d33c15c2-bd3e-46ac-a78b-b4b77f60d637",
                        height: 230,
                        width: 250,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: email,
                        fieldName: "Email",
                        type: TextInputType.emailAddress,
                        prefixIcon: Icon(Icons.email),
                        validator: (value) {
                          if (value!.isEmpty || !EmailValidator.validate(value))
                            return "please enter valid email!";
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      alreadyHaveOrNot(
                        context,
                        buttonText: "Login",
                        text: "Remember password?",
                        onPressed: () {
                          navigateTo(context, Login_Screen());
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          isUpperCase: false,
                          isCircular: true,
                          height: 55,
                          CircularValue: 25,
                          text: "Send",
                          function: () {
                            if (formKey.currentState!.validate()) {
                              navigateTo(context, EmailSent());
                            }
                            CubitApp.get(context).getUsersEmails();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
