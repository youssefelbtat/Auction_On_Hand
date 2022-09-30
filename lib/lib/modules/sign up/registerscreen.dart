// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_app/lib/models/user_model.dart';
import 'package:shoping_app/lib/modules/login/loginscreen.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../layout/home layout.dart';
import '../../shared/componets/regestration_components.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressOneController = TextEditingController();
  var addressTwoController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var isPass = false;

  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);
    return BlocConsumer<CubitApp, StatesApp>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is RegisterSuccessedState|| state is CreateUserSuccessState) {
          cubit.getUserData();
          navigateTo(context, HomeLayout());
        }

      },
      builder: (context, state) {
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
                          text: 'Sign Up',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        regesterSubTitleText(context),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                child: defaultFormField(
                                    controller: firstNameController,
                                    fieldName: 'First Name',
                                    prefixIcon:
                                        const Icon(Icons.perm_identity_rounded),
                                    validator: (s) {
                                      if (s!.isEmpty) {
                                        return 'must not be Empty !';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                child: defaultFormField(
                                    controller: lastNameController,
                                    fieldName: 'Last Name',
                                    prefixIcon:
                                        const Icon(Icons.perm_identity_rounded),
                                    validator: (s) {
                                      if (s!.isEmpty) {
                                        return 'must not be Empty !';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        defaultFormField(
                            controller: userNameController,
                            fieldName: 'Username',
                            prefixIcon: const Icon(Icons.perm_identity_rounded),
                            validator: (s) {
                              if (s!.isEmpty) {
                                return 'Username must not be Empty !';
                              } else if (s.toLowerCase() == 'ahmed') {
                                return 'Username is already existing';
                              } else if (s.length < 3) {
                                return 'Username is too short !';
                              }
                              else if (s.length > 20) {
                                return 'Username is too long !';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 11,
                        ),
                        defaultFormField(
                            controller: addressOneController,
                            fieldName: 'Address 1',
                            prefixIcon:
                                const Icon(Icons.location_city_outlined),
                            validator: (s) {
                              if (s!.isEmpty) {
                                return 'Address 1 must not be Empty !';
                              } else if (s.length < 15) {
                                return 'Address 1 Must be more at least 15 character';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 11,
                        ),
                        defaultFormField(
                            controller: addressTwoController,
                            fieldName: 'Address 2',
                            prefixIcon: const Icon(Icons.location_on),
                            validator: (s) {
                              if (s!.isEmpty) {
                                return 'Address 2 must not be Empty !';
                              } else if (s.length < 15) {
                                return 'Address 2 must be more at least 15 character';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 11,
                        ),
                        defaultFormField(
                            type: TextInputType.phone,
                            controller: phoneNumberController,
                            fieldName: 'Phone Number',
                            prefixIcon: const Icon(Icons.phone),
                            validator: (s) {
                              if (s!.isEmpty) {
                                return 'Phone Number must not be Empty !';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 11,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            fieldName: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            validator: (s) {
                              if (s!.isEmpty) {
                                return 'Email must not be Empty !';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 11,
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
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined)),
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
                        const SizedBox(
                          height: 11,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLodingState,
                          builder: (context) => defaultButton(
                            function: () async{
                              if (formKey.currentState!.validate()) {
                                cubit.create_Account(
                                  userModel: UserModel(
                                    isEmailVerified: false,
                                    numOfPoints: 0,
                                    picture: 'https://images.pexels.com/photos/842548/pexels-photo-842548.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    userName: userNameController.text,
                                    address1: addressOneController.text,
                                    address2: addressTwoController.text,
                                    phone: phoneNumberController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              }
                            },
                            text: 'Sign Up',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        orRegestreWith(
                          context,
                          text: 'Or Sign up with',
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        loginWithGoogle(
                          context,
                          onGoPressed: () {
                            cubit.signInWithGoogle();
                          },
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        alreadyHaveOrNot(
                          context,
                          onPressed: () {
                            navigateTo(
                              context,
                              Login_Screen(),
                            );
                          },
                          text: 'Already have an account ?',
                          buttonText: 'Login Now',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
