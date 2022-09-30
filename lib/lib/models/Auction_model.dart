

import 'package:shoping_app/lib/models/product_model.dart';

class AuctionModel {
  String? auc_id;
  String? auc_seller;
  late bool auc_is_live;
  late bool auc_is_end;
  int? auc_win_points;
  int? auc_current_bid;
  String? auc_start_date;
  String? auc_winner;
  String? auc_end_date;
  String? auc_hours_left;
  String? auc_minutes_left;
  String? auc_seconds_left;
  Product_Model? product_model;

  AuctionModel(
      {this.auc_id,
        this.auc_seller,
        this.auc_is_live=false,
        this.auc_is_end=false,
        this.auc_winner,
        this.auc_win_points,
        this.auc_current_bid,
        this.auc_start_date,
        this.auc_end_date,
        this.auc_hours_left,
        this.auc_minutes_left,
        this.auc_seconds_left,
        this.product_model});

  AuctionModel.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if(json==null){
      return;
    }

    auc_id= json['id'];
    auc_seller=json['seller'];
    auc_winner=json["winner"];
    auc_is_live= json['isLive'];
    auc_is_end= json['isEnd'];
    auc_win_points= json['points'];
    auc_current_bid= json['cBid'];
    auc_start_date=json['startDate'];
    auc_end_date= json['days'];
    auc_hours_left= json['hours'];
    auc_minutes_left= json['minutes'];
    auc_seconds_left= json['second'];
    product_model= Product_Model.fromJson(json['productDate']);

  }
  Map<String, dynamic> toJson() => {
    'id': auc_id,
    "winner":auc_winner,
    'seller': auc_seller,
    'isLive': auc_is_live,
    'isEnd': auc_is_end,
    'points': auc_win_points,
    'cBid': auc_current_bid,
    'startDate': auc_start_date,
    'days': auc_end_date,
    'hours': auc_hours_left,
    'minutes': auc_minutes_left,
    'second': auc_seconds_left,
    'productDate': product_model!.toJson(),
  };
}