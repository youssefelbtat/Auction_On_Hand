import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shoping_app/lib/models/product_model.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/appcubit.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/styel/colors.dart';

import '../../shared/componets/add_auction_components.dart';

class AddAuctionsScreen extends StatelessWidget {
  const AddAuctionsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var cubit = CubitApp.get(context);
    var IsUpload =false;
    var titleController = TextEditingController();
    var brandController = TextEditingController();
    var AuctionHoursController = TextEditingController();
    var ReversePriceController = TextEditingController();
    var initialPriceController = TextEditingController();
    var TimeEndAuctionController = TextEditingController();
    var DateEndAuctionController = TextEditingController();
    var descriptionController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<CubitApp, StatesApp>(
      listener: (context, state) {
              if(state is AddAuctionSuccessState){
               cubit. selectedPicturesUrlList.clear();
                Fluttertoast.showToast(
                    msg: "Your auction added successfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green.shade700,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add an Auction',
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(state is AddAuctionLoadingState)
                      LinearProgressIndicator(),
                    Text(
                      'Upload pictures',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                height: 60,
                                width: 60,
                                color: Colors.grey.shade400,
                                child: Icon(
                                  Icons.add_photo_alternate_rounded,
                                  size: 30,
                                ),
                              ),
                            ),
                            onTap: () {
                              //add photos function
                              print("User picture: ${cubit.userDate!.picture} \n");
                              print("selected picture: ${cubit.profilImageUrl}");
                              cubit.AddAuctionSelectImages();
                              print(cubit.AddAuctionSelectedImagesList!.length);
                            },
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    buildUploadAuctionPictureList(
                                        context: context,
                                        index: index,
                                        picLink:
                                            cubit.AddAuctionSelectedImagesList![index]),
                                separatorBuilder: (context, index) => SizedBox(
                                  width: 5,
                                ),
                                itemCount: cubit.AddAuctionSelectedImagesList!.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          color: Colors.grey[200],
                          child: DropdownButtonFormField2(
                            validator: (value) =>
                                value == null ? 'field required !' : null,
                            selectedItemHighlightColor: Colors.blueGrey,
                            hint: Text(
                              'Select Category',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: cubit.categoriesSpinnerItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: cubit.selectedCategoryValue,
                            onChanged: (value) {
                              cubit.onSpinnerChange(value);
                            },
                            buttonHeight: 20,
                            buttonWidth: 150,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Title',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Auction title must not be Empty !';
                            }
                            return null;
                          },
                          controller: titleController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: 'Enter auction title',
                          )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Auction description must not be Empty !';
                            }
                            return null;
                          },
                          controller: descriptionController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: 'Enter auction description',
                          )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Brand',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Auction brand must not be Empty !';
                            }
                            return null;
                          },
                          controller: brandController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: 'Enter auction brand',
                          )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Initial price',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Initial price must not be Empty !';
                            }
                            return null;
                          },
                          controller: initialPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: 'Enter auction initial price',
                          )),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Reverse price',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Reverse price must not be Empty !';
                            }
                            if (double.parse(value) <
                                double.parse(initialPriceController.text))
                              return 'The Reverse price must be > The initial price !';
                            return null;
                          },
                          controller: ReversePriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: 'Enter auction Reverse price',
                          )),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Type',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          color: Colors.grey[200],
                          child: DropdownButtonFormField2(
                            validator: (value) =>
                                value == null ? 'field required !' : null,
                            selectedItemHighlightColor: Colors.blueGrey,
                            hint: Text(
                              'Select Auction Type',
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: cubit.AuctionSpinnerTypeItems.map(
                                (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    )).toList(),
                            value: cubit.selectedAuctionType,
                            onChanged: (value) {
                              cubit.onSpinnerAuctionTypeChange(value);
                            },
                            buttonHeight: 20,
                            buttonWidth: 180,
                            itemHeight: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    if (cubit.selectedAuctionType == "Live")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Live hours',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Initial price must not be Empty !';
                                  }
                                  if (num.parse(value) > 20 ||
                                      num.parse(value) <= 0)
                                    return "Auction live hours must be between (0&20)!";
                                  return null;
                                },
                                controller: AuctionHoursController,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  hintText:
                                      'Enter number of auction live hours',
                                )),
                          ),
                        ],
                      ),
                    if (cubit.selectedAuctionType == "Non-Live")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          defaultFormField(
                            controller: DateEndAuctionController,
                            fieldName: 'Auction end data',
                            readonly: true,
                            showCursor: true,
                            onTap: () {
                              print('aaa');
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-08-31'),
                              ).then((value) => {
                                    DateEndAuctionController.text =
                                        DateFormat.yMMMd().format(value!),
                                    print(DateFormat.yMMMd().format(value))
                                  });
                            },
                            prefixIcon: Icon(Icons.calendar_today),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Data Must not be empty';
                              return null;
                            },
                            type: TextInputType.datetime,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          defaultFormField(
                            controller: TimeEndAuctionController,
                            readonly: true,
                            showCursor: true,
                            fieldName: 'Auction end time',
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) => {
                                    TimeEndAuctionController.text =
                                        value!.format(context).toString(),
                                    print(value.format(context)),
                                  });
                            },
                            prefixIcon: Icon(Icons.watch_later_outlined),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Time Must not be empty';
                              return null;
                            },
                            type: TextInputType.datetime,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    defaultButton(
                        text: "Save",
                        isCircular: true,
                        function: () {
                          if (cubit.AddAuctionSelectedImagesList!.length == 0 ||
                              cubit.AddAuctionSelectedImagesList!.length > 6) {
                            IsUpload=false;
                            Fluttertoast.showToast(
                                msg: "upload at lest 1 picture and at most 6",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          else
                            IsUpload=true;

                          if (formKey.currentState!.validate() &&
                              (IsUpload)) {

                              cubit.uploadAddAuctionSelectedImages().then((value) => cubit.addAuction(
                                product_model: Product_Model(
                                  pro_Description: descriptionController.text,
                                  pro_title: titleController.text,
                                  pro_start_price: int.parse(initialPriceController.text),
                                  pro_reverse_price: int.parse(ReversePriceController.text),
                                  pro_brand: brandController.text,
                                  pro_category: cubit.selectedCategoryValue,
                                  pro_image1: cubit.selectedPicturesUrlList[0],
                                  pro_image2: cubit.selectedPicturesUrlList.length>=2? cubit.selectedPicturesUrlList[1]: "",
                                  pro_image3: cubit.selectedPicturesUrlList.length>=3? cubit.selectedPicturesUrlList[2]: "",
                                  pro_image4: cubit.selectedPicturesUrlList.length>=4? cubit.selectedPicturesUrlList[3]: "",
                                  pro_image5: cubit.selectedPicturesUrlList.length>=5? cubit.selectedPicturesUrlList[4]: "",
                                  pro_image6: cubit.selectedPicturesUrlList.length>=6? cubit.selectedPicturesUrlList[5]: "",
                                ),
                                isLive: cubit.selectedAuctionType=="Live"?true:false,
                                auc_hours_left: AuctionHoursController.text,
                                auc_start_date: DateTime.now().toString(),
                                auc_end_date: "",
                                isAuctionEnded: false,
                              ));

                          }

                        }),
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
