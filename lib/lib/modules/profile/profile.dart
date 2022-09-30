import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/profile_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userdata = CubitApp.get(context).userDate;
    var cubit = CubitApp.get(context);
    var firstNameController = TextEditingController(text: userdata?.firstName);
    var lastNameController = TextEditingController(text: userdata?.lastName);
    var addressOneController = TextEditingController(text: userdata?.address1);
    var addressTwoController = TextEditingController(text: userdata?.address2);
    var phoneController = TextEditingController(text: userdata?.phone);
    var oldPassword = TextEditingController();
    var newPassword =TextEditingController();
    var conNewPassword=TextEditingController();

    return BlocConsumer<CubitApp, StatesApp>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Profile',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    // ignore: unnecessary_null_comparison
                    if(cubit.profileImage!=null){
                      cubit.uploadProfileImage();
                      print("Uploding......");
                    }
                    cubit.upDateUserData(
                        firstName: firstNameController.text.toString(),
                        lastName: lastNameController.text.toString(),
                        address1: addressOneController.text.toString(),
                        address2: addressTwoController.text.toString(),
                        phone: phoneController.text.toString());
                  },
                  icon: Icon(Icons.done)),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (state is UpDateUserDateLoadingState)
                      LinearProgressIndicator(),
                    Container(
                      height: 104,
                      width: 105,
                      child: Stack(
                        children: [
                          Container(
                              height: 100,
                              width: 95,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: cubit.profileImage == null
                                    ? NetworkImage("${userdata?.picture}")
                                    : FileImage(File(cubit.profileImage!.path))
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ))),
                          InkWell(
                            onTap: () {
                              print("your image");
                              cubit.getImage();
                            },
                            child: Container(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                radius: 16,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    heightSizedBox(),
                    SeparatorLine(),
                    editItem(
                      context,
                      lapelName: "First Name",
                      controller: firstNameController,
                    ),
                    heightSizedBox(),
                    SeparatorLine(),
                    editItem(
                      context,
                      lapelName: "Last Name",
                      controller: lastNameController,
                    ),
                    heightSizedBox(),
                    SeparatorLine(),
                    editItem(
                      context,
                      lapelName: "Address 1",
                      controller: addressOneController,
                    ),
                    heightSizedBox(),
                    SeparatorLine(),
                    editItem(
                      context,

                      lapelName: "Address 2",
                      controller: addressTwoController,
                    ),
                    heightSizedBox(),
                    SeparatorLine(),
                    editItem(
                      context,
                      lapelName: "phone",
                      controller: phoneController,
                      TextInputType: TextInputType.phone,
                    ),
                    heightSizedBox(),
                    SeparatorLine(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Change Your Password",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                    ),
                    editItem(
                        context,
                        controller: oldPassword,
                        isPassword: true,
                        lapelName: "Old Password",
                        hint: "*************"
                    ),
                    editItem(
                        context,
                        controller: newPassword,
                        isPassword: true,
                        lapelName: "New Password",
                        hint: "*************"
                    ),
                    editItem(
                        context,
                        isPassword: true,
                        controller: conNewPassword,
                        lapelName: "Confirm New Password",
                        hint: "*************"
                    ),
                    heightSizedBox(),
                    SeparatorLine(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
