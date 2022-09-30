// import 'dart:convert';
//
// import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
//
// List<AuctionModel> auctionModelFromJson(String str)=>List<AuctionModel>.from(json.decode(str).map((x)=>AuctionModel.fromJson(x)));
// String auctionModelToJson(List<AuctionModel>data)=>json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
//
// class AuctionModel {
//   int? auc_id;
//   String? auc_seller;
//   bool? auc_is_live;
//   bool? auc_is_favorite;
//   bool? auc_is_end;
//   int? auc_win_points;
//   int? auc_current_bid;
//   String? auc_start_date;
//   String? auc_days_left;
//   String? auc_hours_left;
//   String? auc_minutes_left;
//   String? auc_seconds_left;
//   Product_Model? product_model;
//
//   AuctionModel(
//       {this.auc_id,
//         this.auc_seller,
//         this.auc_is_live,
//         this.auc_is_favorite,
//         this.auc_is_end,
//         this.auc_win_points,
//         this.auc_current_bid,
//         this.auc_start_date,
//         this.auc_days_left,
//         this.auc_hours_left,
//         this.auc_minutes_left,
//         this.auc_seconds_left,
//         this.product_model});
//
//   factory AuctionModel.fromJson(Map<String, dynamic> json) => AuctionModel(
//
//     auc_id: json['id'],
//     auc_seller: json['seller'],
//     auc_is_live: json['isLive'],
//     auc_is_favorite: json['isFavorite'],
//     auc_is_end: json['isEnd'],
//     auc_win_points: json['points'],
//     auc_current_bid: json['cBid'],
//     auc_start_date: json['startDate'],
//     auc_days_left: json['days'],
//     auc_hours_left: json['hours'],
//     auc_minutes_left: json['minutes'],
//     auc_seconds_left: json['second'],
//     product_model: Product_Model.fromJson(json['productDate']),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'id': auc_id,
//     'seller': auc_seller,
//     'isLive': auc_is_live,
//     'isFavorite': auc_is_favorite,
//     'isEnd': auc_is_end,
//     'points': auc_win_points,
//     'cBid': auc_current_bid,
//     'startDate': auc_start_date,
//     'days': auc_days_left,
//     'hours': auc_hours_left,
//     'minutes': auc_minutes_left,
//     'second': auc_seconds_left,
//     'productDate': product_model!.toJson(),
//   };
// }
//
// class Product_Model {
//   Product_Model({
//     this.pro_start_price,
//     this.pro_reverse_price,
//     this.pro_title,
//     this.pro_images,
//     this.pro_Description,
//   });
//
//   String? pro_title;
//   String? pro_Description;
//   List<String>? pro_images;
//   int? pro_reverse_price;
//   int? pro_start_price;
//
//   factory Product_Model.fromJson(Map<String, dynamic> json) => Product_Model(
//     pro_title: json['title'],
//     pro_Description: json['description'],
//     pro_images: json['images'],
//     pro_reverse_price: json['rPrice'],
//     pro_start_price: json['sPrice'],
//   );
//
//   Map <String, dynamic> toJson() => {
//     'title': pro_title,
//     'description': pro_Description,
//     'images': pro_images,
//     'rPrice': pro_reverse_price,
//     'sPrice': pro_start_price,
//   };
// }

import 'dart:convert';

import 'package:shoping_app/lib/shared/cubit/appcubit.dart';

class Product_Model {
  Product_Model(
      {this.pro_start_price,
      this.pro_reverse_price,
      this.pro_title,
      this.pro_image1,
      this.pro_image2,
      this.pro_image3,
      this.pro_image4,
      this.pro_image5,
      this.pro_image6,
      this.pro_Description,
      this.pro_category,
      this.pro_brand});

  String? pro_title;
  String? pro_Description;
  String? pro_image1;
  String? pro_image2;
  String? pro_image3;
  String? pro_image4;
  String? pro_image5;
  String? pro_image6;
  int? pro_reverse_price;
  int? pro_start_price;
  String? pro_brand;
  String? pro_category;

  Product_Model.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) {
      return;
    }
    pro_title = json['title'];
    pro_Description = json['description'];
    pro_image1 = json['image1'];
    pro_image2 = json['image2'];
    pro_image3 = json['image3'];
    pro_image4 = json['image4'];
    pro_image5 = json['image5'];
    pro_image6 = json['image6'];

    pro_reverse_price = json['rPrice'];
    pro_start_price = json['sPrice'];
    pro_brand = json['brand'];
    pro_category = json['category'];
  }

  Map<String, dynamic> toJson() => {
        'title': pro_title,
        'description': pro_Description,
        'image1': pro_image1,
        'image2': pro_image2,
        'image3': pro_image3,
        'image4': pro_image4,
        'image5': pro_image5,
        'image6': pro_image6,
        'rPrice': pro_reverse_price,
        'sPrice': pro_start_price,
        'brand': pro_brand,
        'category': pro_category,
      };
}
