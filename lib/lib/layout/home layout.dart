import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/models/user_model.dart';
import 'package:shoping_app/lib/modules/add_auction/add_auction_screen.dart';
import 'package:shoping_app/lib/modules/home/homescreen.dart';
import 'package:shoping_app/lib/modules/login/loginscreen.dart';
import 'package:shoping_app/lib/modules/mybids/mybidsscreen.dart';
import 'package:shoping_app/lib/modules/myfavorite/myfavoritescreen.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/componets/homelayoutcomponets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';
import 'package:shoping_app/lib/shared/styel/my_flutter_app_icons.dart';

import '../modules/notifications/notification_screen.dart';
import '../shared/componets/auctions_details_components.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);
    int _counter = 5;
    return BlocConsumer<CubitApp, StatesApp>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: primColor,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 90,
                              bottom: 1,
                            ),
                            child: CircleAvatar(
                              radius: 38,
                              backgroundImage: NetworkImage(
                                "${cubit.userDate?.picture}",
                              ),
                            ),
                          ),
                          SizedBox(height: 4,),
                          Center(
                            child: Text(
                              '${cubit.userDate?.firstName} ${cubit.userDate?.lastName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '@ ${cubit.userDate?.userName}',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade700,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  drawerItem(
                      name: 'My Profile',
                      selectedItem: 0,
                      icon: Icons.account_circle_outlined,
                      onTap: () {
                        print('${cubit.userDate?.firstName} ${cubit.userDate?.lastName}');
                        cubit.clickDrawerItem(context, 0);
                      }),
                  drawerItem(
                    selectedItem: 1,
                      name: 'My Auctions',
                      icon: Icons.add_business_outlined,
                      onTap: () {
                        cubit.clickDrawerItem(context,1);
                      }),
                  drawerItem(
                      name: 'My Bids',
                      icon: MyFlutterApp.hammer,
                      onTap: () {
                        cubit.changeBottomNavBar(1);
                        Navigator.pop(context);
                  }),
                  drawerItem(
                      name: 'My favorite', icon: Icons.favorite,
                      onTap: () {
                        cubit.changeBottomNavBar(3);
                        Navigator.pop(context);
                  }),
                  drawerItem(
                      name: 'Points Store',
                      icon: Icons.storefront_outlined,
                      onTap: () {
                        cubit.changeBottomNavBar(2);
                        Navigator.pop(context);
                      }),
                  drawerItem(
                    selectedItem: 3,
                      name: 'Help & Feedback',
                      icon: Icons.feedback_outlined,
                      onTap: () {
                        cubit.clickDrawerItem(context,3);
                      }),
                  drawerItem(
                    selectedItem: 4,
                      name: 'About ', icon: Icons.info, onTap: () {
                    cubit.clickDrawerItem(context,4);
                  }),
                  SizedBox(height: 28),
                  ConditionalBuilder(
                    builder: (context)=> drawerItem(
                      selectedItem: 5,
                        name: 'Sign out ', icon: Icons.logout,
                        onTap: () {
                        Navigator.pop(context);
                        cubit.clickDrawerItem(context,5);
                        cubit.signOut();
                        navigateAndDelete(context, Login_Screen());
                    }),
                    condition: state is! LoginLoadingState,
                    fallback: (context) => const Center(
                        child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              backgroundColor: primColor,
              title: Text(
                '${cubit.screensTitles[cubit.currentBottomNavIndex]}',
              ),
              actions: [
                if(cubit.currentBottomNavIndex==2)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    child: Row(
                      children: [
                        Text(
                          "${cubit.userDate!.numOfPoints}",
                          style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        coinImage(),
                      ],
                    ),
                  ),
                if(cubit.currentBottomNavIndex!=2)
                IconButton(
                  onPressed: () {
                    //notification function
                    navigateTo(context, notificationScreen());
                  },
                  icon: notificationIcon(context, _counter),
                ),
                if(cubit.currentBottomNavIndex!=2)
                darkModeButton(context),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: primColor,
              onPressed: () {
                navigateTo(context, AddAuctionsScreen());
                //add Auction function
              },
              tooltip: 'Add Auction',
              child: Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentBottomNavIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomNavItem,
            ),
            body: cubit.bottomNavScreens[cubit.currentBottomNavIndex],
          );
        });
  }
}
