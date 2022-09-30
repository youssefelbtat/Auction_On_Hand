import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shoping_app/lib/modules/home/Categoryscreen.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../models/Auction_model.dart';
import '../../models/categories.dart';
import '../../models/product_model.dart';
import '../../modules/home/auctions_details.dart';
import '../../modules/search/search.dart';
import 'auctions_details_components.dart';

Widget searchBox(context, String search) {
  return Container(
    width: double.infinity,
    height: 55,
    color: primColor,
    child: Padding(
      padding: EdgeInsetsDirectional.only(start: 9, end: 9, top: 2, bottom: 15),
      child: InkWell(
        onTap: () {
          var outputFormat = DateFormat('MM-dd-yyyy hh:mm a');
          var outputDate = outputFormat.format(DateTime.now());
          DateTime.now().add(Duration());
          print(outputDate);
          navigateTo(context, SearchScreen());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey[100]
                : Colors.black,
          ),
          padding: EdgeInsets.only(
            left: 12,
            top: 6.5,
            bottom: 6.5,
            right: 6.5,
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 20,
                color: primColor,
              ),
              Center(
                child: SizedBox(
                  width: 7,
                ),
              ),
              Text(
                search,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget titlesRow({required context, required String title,isSeeMore=true}) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsetsDirectional.only(start: 8, top: 2),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      Spacer(),
      if(isSeeMore)
        Padding(
          padding: EdgeInsetsDirectional.only(end: 5),
          child: TextButton(
            onPressed: () {},
            child: Text(
              'See More',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),


    ],
  );
}

Widget brandLogoBox(context, String image) {
  return Container(
      height: 96,
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Image.asset(
        image,
      ));
}

Widget auctionItemInHome(
  BuildContext context,
  AuctionModel model,
) {
  return Stack(
      children: [
    Container(
      //height: 385,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 134,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(model.product_model!.pro_image1.toString()),
                        fit: BoxFit.cover,
                      )),
                ),
                if(model.auc_is_end)
                  Container(
                    height: 28,
                    width: double.infinity,
                    color: Color(0xFFEE0A0A,).withOpacity(0.85),
                    child: Text(
                      "Sold",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),
              ],
            ),


            SizedBox(
              height: 1,
            ),
            Expanded(
              child: Text(
                model.product_model!.pro_title.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              'LB. ${model.auc_current_bid} EGP',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  'Rp.${model.product_model!.pro_reverse_price} EGP',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            if(model.auc_is_end==false&&model.auc_is_live)
            Row(
              children: [
                Container(
                  width: 33,
                  height: 31,
                  decoration: BoxDecoration(
                    color: primColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${model.auc_hours_left}h',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  ':',
                  style: TextStyle(
                    fontSize: 24,
                    color: primColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: 33,
                  height: 31,
                  decoration: BoxDecoration(
                    color: primColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      model.auc_minutes_left==''||model.auc_minutes_left==null?"00m":'${model.auc_minutes_left}m',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  ':',
                  style: TextStyle(
                    fontSize: 24,
                    color: primColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: 33,
                  height: 31,
                  decoration: BoxDecoration(
                    color: primColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      model.auc_seconds_left==''||model.auc_seconds_left==null?"00s":'${model.auc_seconds_left}s',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'left',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if(model.auc_is_end==true&&model.auc_is_live==false)
              Text(
                "Ended in: ${model.auc_end_date}",
              ),
            if(model.auc_is_end==false&&model.auc_is_live==false)
              Text(
                "Ends in: ${model.auc_end_date}",
              ),
            SizedBox(
              height: 9,
            ),
            Container(
              width: double.infinity,
              height: 38,
              decoration: BoxDecoration(
                color: primColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: MaterialButton(
                onPressed: () {
                  if(model.auc_is_end)
                    Fluttertoast.showToast(
                      msg: "Sorry, Auction is Ended !",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  else
                  navigateTo(context, AuctionDetailsScreen(model));
                },
                child: Text(
                  'View',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    favouriteIconButton(
      context,
      onChange: (){
        //model.auc_is_favorite!=model.auc_is_favorite;
      },
      isFavourite: true,
      //isFavourite: model.auc_is_favorite,
    ),
    model.auc_is_live?liveAuctionsBar():Container(),
  ]);
}

Widget favouriteIconButton(context, {required bool? isFavourite,required Function onChange}) {
  return Container(
    alignment: AlignmentDirectional.topEnd,
    child: FavoriteButton(
      isFavorite: isFavourite,
      iconSize: 42,
      iconColor: Color(0xFFF31F10),
      valueChanged: (isFav) {
        onChange(){};
        isFavourite = isFav;
        Fluttertoast.showToast(
            msg: isFavourite!
                ? "Added to my Favorite successfully ! "
                : "Removed from my Favorite successfully !",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: graycolor,
            fontSize: 15);
      },
    ),
  );
}

Widget drawerItem({
  required String name,
  required IconData icon,
  int? selectedItem,
  void Function()? onTap,
}) =>
    ListTile(
      title: Row(children: [
        Icon(
          icon,
          size: 30,
          color: primColor,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          '${name}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
      onTap: onTap,
    );

Widget BuildCategoriesItem(context, model,onclick,
    {Color color = Colors.lightBlue}) {
  return Material(
    color: Theme.of(context).brightness == Brightness.light
        ? Color(0xF7EFEAEA)
        : Color(0xED171717),
    child: InkWell(
      splashColor: primColor,
      onTap: () {
        navigateTo(context, CategoryScreen(onclick));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
            child: CircleAvatar(
              radius: 51,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: color,
                child: Image.asset(
                  model.image,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            model.text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          )
        ],
      ),
    ),
  );
}

Widget viewCounterDate(
        {var hours, var minutes, var seconds, bool showLeftText = false}) =>
    Row(
      children: [
        Container(
          width: 33,
          height: 31,
          decoration: BoxDecoration(
            color: primColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '${hours}h',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          ':',
          style: TextStyle(
            fontSize: 24,
            color: primColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          width: 33,
          height: 31,
          decoration: BoxDecoration(
            color: primColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '${minutes}m',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          ':',
          style: TextStyle(
            fontSize: 24,
            color: primColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          width: 33,
          height: 31,
          decoration: BoxDecoration(
            color: primColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '${seconds}s',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        if (showLeftText)
          Text(
            'left',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
