import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping_app/lib/models/categories.dart';
import 'package:shoping_app/lib/shared/componets/homelayoutcomponets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/cubit/appcubit.dart';
import '../../shared/network/end_points.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isFavourite = true;
    var cubit = CubitApp.get(context);
    return BlocConsumer<CubitApp, StatesApp>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: Theme.of(context).brightness == Brightness.light
                ? Color(0xF7EFEAEA)
                : Color(0xED171717),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              searchBox(context, 'Search for an auction'),
              CarouselSlider(
                  items: [
                    Image(
                      image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/005/020/298/non_2x/limited-time-offer-design-in-red-and-black-with-stop-watch-free-vector.jpg'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Image(
                      image: NetworkImage(BANNER_LINK2),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Image(
                      image: NetworkImage(BANNER_LINK3),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    // Image(image:
                    // NetworkImage('https://drive.google.com/uc?export=view&id=1ggN4YCBd_00-TKE-8i8ILPZ9vlK1yP8L',),
                    //   width: double.infinity,
                    //   fit: BoxFit.cover,
                    // ),
                  ],
                  options: CarouselOptions(
                    height: 250,
                    //aspectRatio: 16/9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,

                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    // enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(height: 5,),
              titlesRow(context: context, title: 'Categories',isSeeMore: false),
              Padding(
                padding: const EdgeInsets.only(
                    top: 4, bottom: 4, right: 10, left: 10),
                child: Container(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 6,
                    ),
                    itemBuilder: (context, index) => BuildCategoriesItem(
                        context, cubit.CategoriesItemsList[index],
                        cubit.CategoriesLis[index],
                        color: index % 2 == 0
                            ? Colors.lightBlue
                            : Colors.blue),
                    itemCount: cubit.CategoriesItemsList.length,
                  ),
                ),
              ),
              titlesRow(context: context, title: 'Auctions',isSeeMore: false),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 8,
                  bottom: 4,
                ),
                child: GridView.count(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.82,
                  children: cubit.allAuctionsList.map((model) {
                      return auctionItemInHome(context, model);
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              titlesRow(context: context, title: 'Live Auctions',isSeeMore: false),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 8,
                  bottom: 4,
                ),
                child: GridView.count(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.82,
                  children: cubit.LiveAuctionsList
                      .map((e) => auctionItemInHome(context, e))
                      .toList(),
                ),
                // GridView.builder(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //   itemBuilder:(context,index)=> auctionItemInHome(context, cubit.auctionModelList[index]),
                //   itemCount: 2,
                // ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     auctionItemInHome(
                //       context,
                //       isFavorite: _isFavourite,
                //       image: "assets/images/bmwx6.jpg",
                //       auctionTitle: 'BMW car 2022 X6 M' ,
                //       hourLeft: '1',
                //       minutesLeft: '25',
                //       secondLeft: '16',
                //       reversePrice: '100.000.000',
                //       lastBid:'40.000.000',
                //     ),
                //
                //     SizedBox(width: 10,),
                //     auctionItemInHome(
                //       context,
                //       isFavorite: _isFavourite,
                //       image: "assets/images/villa.jpg",
                //       auctionTitle: 'Luxury Villa in Golf Al Sulaymaniya.' ,
                //       hourLeft: '2',
                //       minutesLeft: '15',
                //       secondLeft: '55',
                //       reversePrice: '110.000.000',
                //       lastBid:'60.000.000',
                //     ),
                //   ],
                // ),
              ),
              SizedBox(
                height: 4,
              ),
              titlesRow(context: context, title: 'Non-Live Auctions',isSeeMore: false),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                  end: 8,
                  bottom: 4,
                ),
                child: GridView.count(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1 / 1.82,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: cubit.NonLiveAuctionsList
                      .map((e) => auctionItemInHome(context, e))
                      .toList(),
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     auctionItemInHome(
                //       context,
                //       isFavorite: true,
                //       image: "assets/images/iphone13.jpeg",
                //       auctionTitle: 'iPhone 13 pro max 512G.' ,
                //       hourLeft: '1',
                //       minutesLeft: '20',
                //       secondLeft: '48',
                //       reversePrice: '22.100',
                //       lastBid:'15.600',
                //     ),
                //     SizedBox(width: 10,),
                //     auctionItemInHome(
                //       context,
                //       isFavorite:false,
                //       image: "assets/images/car1.jpg",
                //       auctionTitle: 'Mercedes Car model S400.' ,
                //       hourLeft: '5',
                //       minutesLeft: '10',
                //       secondLeft: '45',
                //       reversePrice: '1.000.000',
                //       lastBid:'600.000',
                //     ),
                //   ],
                // ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
