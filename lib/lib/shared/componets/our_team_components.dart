

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

Widget outTeamMember(
{
  required String name,
required String image,

}
){
  return  Expanded(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5),
          height: 138,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              )),
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: GoogleFonts.abrilFatface(
            textStyle: TextStyle(
              fontSize: 13,
              color: primeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  ) ;
}