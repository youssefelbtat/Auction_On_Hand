import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/shared/cubit/cubitobserve.dart';
import 'package:shoping_app/lib/shared/styel/theme.dart';

import 'lib/layout/home layout.dart';
import 'lib/modules/login/loginscreen.dart';
import 'lib/modules/onbording.dart';
import 'lib/shared/cubit/appcubit.dart';
import 'lib/shared/cubit/states.dart';
import 'lib/shared/network/local/sharedpreferences.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CachHelper.init();
  bool isdark = CachHelper.getData(key: 'IsDark');
  bool skipOnBording = CachHelper.getData(key: 'skipOnBording');
  runApp(MyApp(isdark,skipOnBording));
}

class MyApp extends StatelessWidget {
  final bool isdark ;
   final bool skipOnBording ;
  MyApp(this.isdark,this.skipOnBording);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return   BlocProvider(
      create: (BuildContext context) => CubitApp()..OnChangeAppMode(fromShared: isdark,)..getUserData()..getAllAuctions(),
      child: BlocConsumer<CubitApp, StatesApp>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = CubitApp.get(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: cubit.isAppMode ? ThemeMode.dark : ThemeMode.light,
             // home:HomeLayout(),
              home:OnBordingScreen() ,
            );
          }
      ),
    );
  }
}
//skipOnBording==false ? OnBordingScreen():Login_Screen()