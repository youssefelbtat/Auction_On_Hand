import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shoping_app/lib/models/Auction_model.dart';
import 'package:shoping_app/lib/models/product_model.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/auctions_details_components.dart';
import '../../shared/componets/componets.dart';
import '../../shared/componets/homelayoutcomponets.dart';
import '../../shared/network/end_points.dart';

// ignore: must_be_immutable
class AuctionDetailsScreen extends StatelessWidget {
  AuctionModel model;
  AuctionDetailsScreen(
      this.model,
      );

  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);
    var formKey = GlobalKey<FormState>();
    TextEditingController bidController =TextEditingController();
    List<String> images=[
      model.product_model!.pro_image1.toString(),
      model.product_model!.pro_image2.toString(),
      model.product_model!.pro_image3.toString(),
      model.product_model!.pro_image4.toString(),
      model.product_model!.pro_image5.toString(),
      model.product_model!.pro_image6.toString(),

    ];
    var cBid=model.auc_current_bid;
    var quickBidValue=(model.auc_current_bid==0||model.auc_current_bid==null)?model.product_model?.pro_start_price:model.auc_current_bid;
    cubit.changeQuickBidValue=quickBidValue!;
    cubit.currentBid=quickBidValue;
    String cBidFunction(){
      if(cBid==null || cBid==0)
        return "No bid yet";
      return cBid.toString();
    }

    int endTime = DateTime.now().millisecondsSinceEpoch+ 60 * 150* 1000;
    return BlocConsumer<CubitApp, StatesApp>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Row(
                  children: [
                    Text(
                      "+${model.auc_win_points}",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    coinImage(),
                  ],
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: AspectRatio(
                                aspectRatio: 1.25,
                                child: Image.network(
                                    images[cubit.selectedSmallAuctionImage]==""?"${images[0]}":images[cubit.selectedSmallAuctionImage],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: favouriteIconButton(
                                context,
                                isFavourite: true,
                                onChange: (){},
                              ),
                            ),
                            if(model.auc_is_live)
                            liveAuctionsBar(),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (var item = 0; item < 6; item++)
                                  if(images[item]!="")
                                  buildSmallPreview(item, context,images[item]),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          " ${model.product_model!.pro_title} ",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Container(
                          width: double.infinity,
                          color: graycolor,
                          height: 1,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        buildDescriptionText(context,
                            title: "${model.product_model!.pro_Description}",
                            description: "description:"),
                        SizedBox(
                          height: 3,
                        ),
                        buildDescriptionText(context,
                            title: "${model.product_model!.pro_brand}", description: "Brand: "),
                        SizedBox(
                          height: 3,
                        ),
                        buildDescriptionText(context,
                            title: "${model.product_model!.pro_category}", description: "Category: "),

                        SizedBox(
                          height: 3,
                        ),
                        buildDescriptionText(context,
                            title: "${model.auc_seller}", description: "Seller: "),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Auction Details: ",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Container(
                          width: double.infinity,
                          color: graycolor,
                          height: 1,
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(
                              model.auc_is_live?"Time left: ": "End in: ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade700,
                                  ),
                            ),
                           if(model.auc_is_live)
                             CountdownTimer(
                              endTime: endTime,
                              widgetBuilder: (_, reminingTime) {
                                if (reminingTime == null)
                                  return Text("Auction Ended");
                                return viewCounterDate(
                                    hours: reminingTime.hours!=null?reminingTime.hours:00 ,
                                    minutes: reminingTime.min!=null?reminingTime.min:00 ,
                                    seconds: reminingTime.sec!=null?reminingTime.sec:00 );
                              },
                              textStyle:
                                  TextStyle(fontSize: 12, color: Colors.pink),
                            ),
                            if(model.auc_is_live==false)
                              Text(
                                "${model.auc_end_date}",
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        buildDescriptionText(context,
                            title: "${model.product_model!.pro_start_price}",
                            description: "Started price: "),
                        SizedBox(
                          height: 3,
                        ),
                        buildDescriptionText(context,
                            title: "${model.product_model!.pro_reverse_price}",
                            description: "Reverse price: "),
                        SizedBox(height: 5,),
                        buildDescriptionText(context, title:model.auc_is_live?"Live":"Non-live" , description:"Type: " ),
                        SizedBox(height: 5,),
                        buildDescriptionText(context, title:cubit.currentBid==0?"No bid yet":cubit.currentBid.toString() , description:"Current Bid: " ),
                        SizedBox(height: 5),
                        Form(
                          key: formKey,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                    height: 0.5,
                                  ),
                                  controller: bidController,
                                  keyboardType:TextInputType.number,
                                  validator: (text){
                                    // ignore: unnecessary_null_comparison
                                    if(text!.isEmpty || text==null || text=="")
                                      return "It must not be empty!";
                                    else if ((int.parse(bidController.text.toString()) ) <= (model.auc_current_bid!.toInt()))
                                      return "your bid must be more than the current bid";
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter your bid ',

                                )
                                ),
                              ),
                              SizedBox(width: 4,),
                              defaultButton(
                                isCircular: false,
                                color: primColor,
                                width: 92,
                                height: 46,
                                function: () {
                                 if(formKey.currentState!.validate())
                                   {
                                     cubit.addBid(model.auc_id, num.parse(bidController.text.toString()));
                                   }

                                },
                                text: "Bid",
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.cyan,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 3,
                                  ),
                                  child: Text(
                                    cubit.changeQuickBidValue.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                              ),
                              InkWell(
                                  child: Icon(Icons.remove, color: graycolor),
                                  onTap: () {
                                    cubit.DecrementBid(model,quickBidValue,cubit.changeQuickBidValue);
                                  }),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  child: Icon(Icons.add, color: primColor),
                                  onTap: () {
                                    cubit.IncrementBid(model,cubit.changeQuickBidValue);

                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: defaultButton(
                        isCircular: true,
                        color: primColor,
                        height: 46,
                        function: () async{
                           cubit.addBid(model.auc_id, num.parse(cubit.changeQuickBidValue.toString()));
                        },
                        text: "Quick Bid",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
