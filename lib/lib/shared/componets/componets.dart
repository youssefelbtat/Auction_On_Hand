import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoping_app/lib/models/Auction_model.dart';
import 'package:shoping_app/lib/models/onbordingmodelclass.dart';
import 'package:shoping_app/lib/modules/onbording.dart';
import 'package:shoping_app/lib/shared/componets/homelayoutcomponets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/network/end_points.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType type = TextInputType.name,
  bool isPassword = false,
  required String fieldName,
  required Icon prefixIcon,
  Function? onchanged,
  IconButton? suffixIcon,
  void Function()? onTap,
  void Function()? onSubmint,
  void Function()? pressedSuffixIcon,
  bool showCursor = false,
  bool readonly = false,
  required FormFieldValidator<String> validator,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        focusColor: primColor,
        labelText: fieldName,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onFieldSubmitted: (value) => onSubmint!(),
      // onChanged: (value) {
      //   onchanged!(value);
      // },
      onTap: onTap,
      validator: validator,
      showCursor: showCursor,
      readOnly: readonly,
    );

Widget defulteditTextx({
  required TextEditingController Controlar,
  required TextInputType keyboardType,
  Function? onfiled,
  Function? onchanged,
  GestureTapCallback? ontab,
  FormFieldValidator<String>? validator,
  required String Lable,
  IconData? prefix,
  IconData? sufix,
  bool? obscureText = false,
  InputDecoration? InputDecorationn ,
}) =>
    TextFormField(
      onTap: ontab,
      obscureText: obscureText!,
      controller: Controlar,
      keyboardType: keyboardType,
      onFieldSubmitted: (s) {
        onfiled!(s);
      },
      onChanged: (s) {
        onchanged!(s);
      },
      validator: validator,
      decoration: InputDecorationn ,
    );

Widget tasksBuilder({required List<AuctionModel> model,})=>ConditionalBuilder(
    condition: model.length>0,
    fallback: (context)=>Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey[400],
          ),
          Text(
            'Not Items Yet, add some',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    ),
    builder: (context)=>Container(
      padding: EdgeInsets.all(8),
      height: double.infinity,
      color: Theme.of(context).brightness == Brightness.light
          ? Color(0xF7EFEAEA)
          : Color(0xED171717),
      child: GridView.count(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.86,
        children: List.generate(1, (index) {
          return auctionItemInHome(context, model[index]);
        }),
        // cubit.auctionModelList.map((model) {
        //   return auctionItemInHome(context, model);
        // }).toList(),
      ),
    ),);
Widget buildBoardingItem(BoardingModel boardingModel, context) =>
    Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(boardingModel.image),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            boardingModel.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: primColor,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          Text(
            boardingModel.body,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    });

Widget defaultButton({
  double width = double.infinity,
  Color color = primColor,
  bool isCircular=true,
  double height=55,
  double CircularValue=45,
  required  Function() function,
  String text = '',
  isUpperCase=true,
}) =>
    Container(
      width: width,
      height: height,
      decoration:  BoxDecoration(
        color: color,
        borderRadius:isCircular? BorderRadius.circular(CircularValue):null,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase?
          text.toUpperCase():text,
          style:  TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );


Widget darkModeButton(context) => IconButton(
    onPressed: () {
      CubitApp.get(context).OnChangeAppMode();
    },
    icon: const Icon(Icons.dark_mode),
    tooltip: CubitApp.get(context).isAppMode ? 'Light' : 'Dark');

Widget changeLangButton(context) => IconButton(
      onPressed: () {},
      icon: const Icon(Icons.language_outlined),
      tooltip: 'Arabic \u{1F1EA}\u{1F1EC}',
    );

Widget notificationIcon(context,var numOfNoti)=>Container(
  width: 30,
  height: 30,
  child: Stack(
    children: [
      Icon(
        Icons.notifications_none,
        size: 30,
      ),
      Container(
        width: 30,
        height: 30,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 5),
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xfffa0215),
              border:
              Border.all(color: Color(0xfffa0215), width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Text(
                numOfNoti.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[100],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
);


Future navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndDelete(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

// \u{1f60e}
