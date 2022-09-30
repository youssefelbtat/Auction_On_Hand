import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/lib/layout/home%20layout.dart';
import 'package:shoping_app/lib/modules/login/forget_pass.dart';
import 'package:shoping_app/lib/modules/sign%20up/registerscreen.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/regestration_components.dart';

class Login_Screen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);
    return BlocConsumer<CubitApp, StatesApp>(listener: (context, state) {
      if (state is LoginErrorState) {
        Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      if (state is LoginSuccessState || state is CreateUserSuccessState) {
        cubit.getUserData();
        navigateTo(context, HomeLayout());
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            darkModeButton(context),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logoInRegestration(context),
                      regesterText(
                        context,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      regesterSubTitleText(context),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: emailController,
                          fieldName: 'Email',
                          prefixIcon: const Icon(Icons.email_outlined),
                          validator: (s) {
                            if (s!.isEmpty) {
                              return 'Email must not be Empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          fieldName: 'Password',
                          isPassword: cubit.isPassLogin,
                          suffixIcon: IconButton(
                              onPressed: () {
                                cubit.changeIsPassWhenLogin();
                              },
                              icon: Icon(cubit.isPassLogin
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          validator: (s) {
                            if (s!.length < 6) {
                              return 'Password must be at least 8 char!';
                            } else if (s.isEmpty) {
                              return 'Password must not be Empty';
                            }
                            return null;
                          }),
                      forgetPassword(context, onPressed: () {
                        navigateTo(context, ForgetPassword());
                      }),
                      const SizedBox(
                        height: 4,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              CubitApp.get(context).getUserData();
                              CubitApp.get(context).userLogin(
                                  email: emailController.text,
                                  passWord: passwordController.text);
                            }
                          },
                          text: 'login',
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      orRegestreWith(context),
                      const SizedBox(
                        height: 15,
                      ),
                      loginWithGoogle(
                        context,
                        onGoPressed: () {
                          cubit.signInWithGoogle();
                        },
                      ),
                      alreadyHaveOrNot(context, onPressed: () {
                        navigateTo(
                          context,
                          RegisterScreen(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
