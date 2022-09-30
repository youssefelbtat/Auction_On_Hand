import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoping_app/lib/models/giftmodel.dart';
import 'package:shoping_app/lib/models/onbordingmodelclass.dart';
import 'package:shoping_app/lib/models/user_model.dart';
import 'package:shoping_app/lib/modules/about/about_screen.dart';
import 'package:shoping_app/lib/modules/feedback/feed_back_screen.dart';
import 'package:shoping_app/lib/modules/home/homescreen.dart';
import 'package:shoping_app/lib/modules/myauctions/my_auctions_screen.dart';
import 'package:shoping_app/lib/modules/mybids/mybidsscreen.dart';
import 'package:shoping_app/lib/modules/myfavorite/myfavoritescreen.dart';
import 'package:shoping_app/lib/modules/pointsstore/pointsstorescreen.dart';
import 'package:shoping_app/lib/modules/profile/profile.dart';
import 'package:shoping_app/lib/shared/componets/componets.dart';
import 'package:shoping_app/lib/shared/cubit/states.dart';
import 'package:shoping_app/lib/shared/network/local/sharedpreferences.dart';
import 'package:shoping_app/lib/shared/styel/my_flutter_app_icons.dart';

import '../../models/Auction_model.dart';
import '../../models/categories.dart';
import '../../models/product_model.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CubitApp extends Cubit<StatesApp> {
  CubitApp() : super(InitialState());

  static CubitApp get(context) => BlocProvider.of(context);
  int currentBoardingIndex = 0;
  UserModel? userDate;

  // for next onBoarding
  void Increment() {
    currentBoardingIndex++;
    emit(ChangeOnBoardingIndexState());
  }

  // for previous onBoarding
  void decrement() {
    currentBoardingIndex--;
    emit(ChangeOnBoardingIndexState());
  }

  // change onBoarding by swiping
  void onBoardingChanged(int index) {
    currentBoardingIndex = index;
    emit(ChangeOnBoardingIndexState());
  }

  //OnBoarding Items
  List<BoardingModel> boardingitems = [
    BoardingModel(
      'Register now for our app (Auction in Hand) and put your bid for free.',
      "assets/images/onboarding1.png",
      "Free Registration",
    ),
    BoardingModel(
      'place your bid at the same time as the auction is actually taking place.',
      "assets/images/onboarding2.png",
      "Live Auction",
    ),
    BoardingModel(
      'In our system it is easy to collect points every time you win an auction than you can exchange your points from the points store for great gifts.',
      "assets/images/onboarding3.png",
      "Collect points",
    ),
  ];


         int changeQuickBidValue=0;
  void DecrementBid(model,quickBidValue,changeQuickBid){
    if(changeQuickBidValue > quickBidValue!)
      {
        changeQuickBidValue=(changeQuickBid!-(10/100)*(model.product_model?.pro_start_price)!.toInt()).toInt();
        print(changeQuickBidValue);
        emit(BidDecrementState());
      }
  }
  void IncrementBid(model,changeQuickBid){
    changeQuickBidValue=(changeQuickBid!+(10/100)*(model.product_model?.pro_start_price)!.toInt()).toInt();
      print(changeQuickBidValue);
      emit(BidIncrementState());
  }

  int selectedSmallAuctionImage = 1;

  void onChangedSelectedSmallAuctionImage(int indexSelect) {
    selectedSmallAuctionImage = indexSelect;
    emit(onChangedSelectedSmallAuctionImageState());
  }

  var currentBottomNavIndex = 0;

  List<Widget> bottomNavScreens = [
    HomeScreen(),
    myBidsScreen(),
    pointsStoreScreen(),
    myFavoriteScreen(),
  ];

  List<String> screensTitles = [
    'Home',
    'My Bids',
    'Points Store',
    'My Favorite',
  ];

  List<BottomNavigationBarItem> bottomNavItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(MyFlutterApp.hammer),
      label: 'My Bids',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.storefront_outlined),
      label: 'Points Store',
    ),
    BottomNavigationBarItem(
      icon: Icon(MyFlutterApp.favorite),
      label: 'My Favorite',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentBottomNavIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  void clickDrawerItem(context, int selectItem) {
    switch (selectItem) {
      case 0:
        {
          navigateTo(context, ProfileScreen());
          emit(ChangeDrawerSelectedIndexState());
        }
        break;
      case 1:
        {
          navigateTo(context, MyAuctionScreen());
          emit(ChangeDrawerSelectedIndexState());
        }
        break;
      case 3:
        {
          navigateTo(context, FeedBackScreen());
          emit(ChangeDrawerSelectedIndexState());
        }
        break;
      case 4:
        {
          navigateTo(context, AboutScreen());
          emit(ChangeDrawerSelectedIndexState());
        }
        break;
    }
  }

  bool isPassLogin = false;

  void changeIsPassWhenLogin() {
    isPassLogin = !isPassLogin;
    emit(IsLoginPasswordState());
  }

  Future<void> signInWithGoogle() async {
    emit(CreateGoogleUserLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
   await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        List<String> spiltName =value.user!.displayName!.split(" ");
     CreateUser(userModel: UserModel(
       email: value.user!.email,
       userId: value.user!.uid,
       phone: value.user!.phoneNumber,
       firstName: spiltName.first,
       // ignore: unnecessary_null_comparison
       lastName: spiltName.last !=null ?spiltName.last : "",
       userName: "${spiltName.first}_${spiltName.last}",
       numOfPoints: 0,
       address1: "" ,
       address2: "",
       picture: value.user!.photoURL,
       isEmailVerified: true,
     ));
     emit(CreateGoogleUserSuccessState());
   }).catchError((err){
     print("Error when create Google user ${err.toString()}");
     emit(CreateGoogleUserErrorState());
   });
  }

  void create_Account({
    required UserModel userModel,
  }) {
    String errorMessage = '';
    emit(RegisterLodingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: userModel.email.toString(),
      password: userModel.password.toString(),
    )
        .then((value) {
      emit(RegisterSuccessedState());
      userModel.userId = value.user!.uid;
      CreateUser(userModel: userModel);
      print(userModel.lastName);
      print(value.user!.email);
    }).catchError((error) {
      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "Email already used. Go to login page.";
          break;
        case "invalid-email":
          errorMessage = "invalid email address.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "operation-not-allowed":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      emit(RegisterErrorState(errorMessage.toString()));
    });
  }

  void CreateUser({
    required UserModel userModel,
  }) {
    UserModel model = UserModel(
      userName: userModel.userName,
      picture: userModel.picture,
      password: userModel.password,
      numOfPoints: userModel.numOfPoints,
      isEmailVerified: userModel.isEmailVerified,
      lastName: userModel.lastName,
      firstName: userModel.firstName,
      address2: userModel.address1,
      address1: userModel.address2,
      phone: userModel.phone,
      email: userModel.email,
      userId: userModel.userId,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel.userId)
        .set(model.toJson())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void userLogin({
    required String email,
    required String passWord,
  }) {
    String errorMessage = '';
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: passWord,
    )
        .then((value) {
      emit(LoginSuccessState());
    }).catchError((error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "invalid email address.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "operation-not-allowed":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      print(error.code);
      emit(LoginErrorState(errorMessage.toString()));
    });
  }

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('Users')
        .doc((await FirebaseAuth.instance.currentUser)?.uid)
        .get()
        .then((value) {
      userDate = UserModel.fromJson(value.data() as Map<String, dynamic>);
      print(value.data().toString());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }
  void getUsersEmails()  {
    print("Loading emails");
    emit(GetUsersEmailsLoadingState());
    FirebaseFirestore.instance.collection('Users')
        .doc("email").get().then((value){
      emit(GetUsersEmailsSuccessState());
          print("Users Emails: ${value.data().toString()}");
    }).catchError((erorr){
      print("Error: ${erorr.toString()}");
      emit(GetUsersEmailsErrorState());
    });
  }


  bool isAppMode = false;

  void OnChangeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isAppMode = fromShared;
      emit(OnChangeAppModeState());
    } else {
      isAppMode = !isAppMode;
      CachHelper.setData(key: 'IsDark', value: isAppMode).then((value) {
        emit(OnChangeAppModeState());
      });
    }
  }

  // change profile picture
  File? profileImage;

  var picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      emit(PickProfileImageErrorState());
      print("There is no picture selected");
    }
  }
  var currentBid=0;
  List<AuctionModel> myBidList=[];
  List<AuctionModel> myAuctionsList=[];
  void addBid(auctionId,data){
    emit(AddBidLoadingState());
    FirebaseFirestore.instance.
    collection("auctions")
        .doc(auctionId)
        .update({"cBid":data})
        .then((value) {
          getAllAuctions(id:auctionId,list: myBidList);
          currentBid=data;
      emit(AddBidSuccessState());
    } ).catchError((error){
      print("Error when add bid ${error.toString()}");
      emit(AddBidErrorState());
    });
  }

  //upload profile picture to the firebase storage
  String profilImageUrl = "";

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
        'usersProfImage/${Uri
            .file(profileImage!.path)
            .pathSegments
            .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profilImageUrl = value.toString();
        FirebaseFirestore.instance
            .collection('Users')
            .doc((FirebaseAuth.instance.currentUser)?.uid)
            .update({"picture": profilImageUrl}).then((value) {
          getUserData();
          print(
              "The data updated Successed \n data after update:   ${userDate!
                  .picture}");
        }).catchError((err) {
          print("Error when add picture to  database: ${err.toString()}");
          emit(UploadProfileImageErrorState());
        });
        print("Picture value : ${value}");
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((Error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // upDate User data
  void upDateUserData({
    required String firstName,
    required String lastName,
    required String address1,
    required String address2,
    required String phone,
  }) {
    emit(UpDateUserDateLoadingState());
    // if(profileImage!=null||profileImage!=""){
    //   uploadProfileImage();
    // }
    UserModel model = UserModel(
      // ignore: unnecessary_null_comparison
      picture: profilImageUrl == "" ? userDate?.picture : profilImageUrl,
      password: userDate?.password,
      numOfPoints: userDate?.numOfPoints,
      isEmailVerified: userDate?.isEmailVerified,
      lastName: lastName,
      firstName: firstName,
      address2: address1,
      address1: address2,
      phone: phone,
      userName: userDate?.userName,
      email: userDate?.email,
      userId: userDate?.userId,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc((FirebaseAuth.instance.currentUser)?.uid)
        .update(model.toJson())
        .then((value) {
      getUserData();
      print(
          "The data updated Successed \n data after update: ${model.lastName}");
    }).catchError((err) {
      print("Error when update the data: ${err.toString()}");
      emit(UpDateUserDateErrorState());
    });
  }

  Future<void> signOut() async {
    emit(LogoutLoadingState());
    await FirebaseAuth.instance.signOut().then((value) {
      emit(LogoutSuccessState());
      print("Logout Succssfully");
    }).catchError((onError) {
      print("Error when login ${onError.toString()}");
      emit(LoginErrorState(onError));

    });
  }

  String? selectedCategoryValue;
  String? selectedAuctionType;

  List<String> AuctionSpinnerTypeItems = [
    "Live",
    "Non-Live",
  ];
  List<String> categoriesSpinnerItems = [
    'vehicles',
    'Buildings&lands',
    'Furniture',
    'SmartPhones',
    'Watches',
    'Electronics',
    'Electrical devices',
  ];

  void onSpinnerChange(var value) {
    emit(OnSpinnerCategoriesChangeState());
    selectedCategoryValue = value as String;
  }

  void onSpinnerAuctionTypeChange(var value) {
    emit(OnSpinnerTypeChangeState());
    selectedAuctionType = value as String;
  }

  List<String> addAuctionPictureList = [
    // "https://image.similarpng.com/very-thumbnail/2020/10/Computer-monitor-isolated-on-transparent-background-PNG.png",
    // "https://image.similarpng.com/very-thumbnail/2021/06/Windscreen-led-or-lcd-internet-tv-monitor-isolated-on-transparent-background-PNG.png",
    // "https://image.similarpng.com/very-thumbnail/2021/08/Frontal-view-of-widescreen-internet-tv-monitor-isolated-on-transparent-background-PNG.png",
  ];

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? AddAuctionSelectedImagesList = [];

  void AddAuctionSelectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      AddAuctionSelectedImagesList!.addAll(selectedImages);
      emit(AddAuctionSelectImagesState());
    }
    print(
        "Image List Length:" + AddAuctionSelectedImagesList!.length.toString());
  }

  void addAuctionRemoveSelectedPicture(int index) {
    AddAuctionSelectedImagesList!.removeAt(index);
    emit(AddAuctionRemoveSelectedPictureState());
  }

  //upload selected images to firebase
  List<String> selectedPicturesUrlList = [];

  Future<void> uploadAddAuctionSelectedImages() async {
    print(
        "LIST Length before upload picture ${selectedPicturesUrlList.length}");
    emit(uploadAddAuctionSelectImagesLoadingState());
    if (AddAuctionSelectedImagesList!.length < 1)
      print("There is no picture selected");

   await Future.forEach(AddAuctionSelectedImagesList!, await (element) async {

      await firebase_storage.FirebaseStorage.instance
           .ref()
           .child(
           'Auctions pictures/${userDate!.firstName} ${userDate!.lastName}/${Uri
               .file(element?.path)
               .pathSegments
               .last}')
           .putData(await element.readAsBytes())
           .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
       selectedPicturesUrlList.add(value.toString());
       print("LIST Length after upload picture ${selectedPicturesUrlList
           .length}");
       print("Select pictures----------> ${value}");
       emit(uploadAddAuctionSelectImagesSuccessState());
       }).catchError((error) {
       print(
       "error when uploading selected picture to fireStorage ${error
           .toString()}");
       emit(uploadAddAuctionSelectImagesErrorState());
       });
       }).catchError((error) {
       print(
       "error when uploading selected picture to fireStorage ${error
           .toString()}");
       emit(uploadAddAuctionSelectImagesErrorState());
       });
     } );

  }

  void addAuction({
    required Product_Model product_model,
    required isLive,
    auc_end_date,
    auc_start_date,
    auc_hours_left,
    isAuctionEnded,
  }) {
    String id = FirebaseFirestore.instance.collection('Posts').doc().id;
    print("add auction function executing");
    emit(AddAuctionLoadingState());
    AuctionModel model = AuctionModel(
      product_model: product_model,
      auc_is_live: isLive,
      auc_start_date: auc_start_date,
      auc_seller: "${userDate!.firstName} ${userDate!.lastName}",
      auc_is_end: isAuctionEnded,
      auc_hours_left: auc_hours_left,
      auc_end_date: auc_end_date,
      auc_id: id,
    );
    FirebaseFirestore.instance
        .collection("auctions")
        .doc(id)
        .set(model.toJson())
        .then((value) {
      print("Auction added successfully");
      getAllAuctions();
      getAllAuctions(id:id,list: myAuctionsList);
      emit(AddAuctionSuccessState());
    }).catchError((error) {
      print("Auction added Error  ${error.toString()}");
      emit(AddAuctionErrorState());
    }).catchError((error) {
      print("Auction added Error  ${error.toString()}");
    });
  }

  List<AuctionModel> allAuctionsList = [];
  List<AuctionModel> LiveAuctionsList = [];
  List<AuctionModel> NonLiveAuctionsList = [];
  List<AuctionModel> vehiclesList = [];
  List<AuctionModel> BuildingsList = [];
  List<AuctionModel> FurnitureList = [];
  List<AuctionModel> SmartPhonesList = [];
  List<AuctionModel> WatchesList = [];
  List<AuctionModel> ElectronicsList = [];
  List<AuctionModel> ElectricaldevicesList = [];

  late List<List<AuctionModel>> CategoriesLis=  [
    vehiclesList,
    BuildingsList,
    FurnitureList,
    SmartPhonesList,
    WatchesList,
    ElectronicsList,
    ElectricaldevicesList,
  ];

  void getAllAuctions({id,List<AuctionModel>? list})  {
    emit(GetAllAuctionsLoadingState());
    FirebaseFirestore.instance
        .collection("auctions")
        .get()
        .then((value) {
       value.docs.forEach((element) {
         var contain = allAuctionsList.where((e) => e.auc_id == element.get("id"));
         if(contain.isEmpty){
           allAuctionsList.add(AuctionModel.fromJson(element.data()));
           switch(element.get("productDate")["category"]){
             case "vehicles":
               vehiclesList.add(AuctionModel.fromJson(element.data()));
               break;
             case "Buildings&lands":
               BuildingsList.add(AuctionModel.fromJson(element.data()));
               break;
             case "Furniture":
               FurnitureList.add(AuctionModel.fromJson(element.data()));
               break;
             case "SmartPhones":
               SmartPhonesList.add(AuctionModel.fromJson(element.data()));
               break;
             case "Watches":
               WatchesList.add(AuctionModel.fromJson(element.data()));
               break;
             case "Electronics":
               ElectronicsList.add(AuctionModel.fromJson(element.data()));
               break;
             case "Electrical devices":
               ElectricaldevicesList.add(AuctionModel.fromJson(element.data()));
               break;
             default: null;
           }
           if(element.get("isLive")==true)
             LiveAuctionsList.add(AuctionModel.fromJson(element.data()));
           else
             NonLiveAuctionsList.add(AuctionModel.fromJson(element.data()));
         }
         if(element.get("id")==id)
           list!.add(AuctionModel.fromJson(element.data()));

       });
    }).catchError((error){
      print("Error when get all auctions : ${error.toString()}");
      emit(GetAllAuctionsErrorState());
    });
  }


  List<GiftModel> GiftItemsList =[
    GiftModel(price: "1000", text: " Google play Gift Card 5\$ ", image: "https://sc04.alicdn.com/kf/Hf1b8d853f9d44dd3b607a21027c14fdc0.jpg"),
    GiftModel(price: "2000", text: " Google play Gift Card 10\$ ", image: "https://etrot.com/image/cache/catalog/ETROT%205.0/Google/Google_gift_card_ETROT_com_10-800x800.jpg"),
    GiftModel(price: "3000", text: " Google play Gift Card 15\$ ", image: "https://gulfishan.com.bd/wp-content/uploads/2021/02/google-play-gift-card-15-us.jpg"),
    GiftModel(price: "4000", text: " Google play Gift Card 20\$ ", image: "https://sc04.alicdn.com/kf/H3f21ea218a7c4c5e853288a4ab9f4cc22.jpg"),
    GiftModel(price: "5000", text: " Google play Gift Card 25\$ ", image: "https://www.egygamer.com/media/catalog/product/cache/796b3d18b5db5152be06a3c06a2ed81b/e/6/e630d33b-51e2-4882-8123-a552479af90e.jpg"),
    GiftModel(price: "10000", text: " Google play Gift Card 50\$ ", image: "https://m.media-amazon.com/images/I/61OdJeN2lFL._SY550_.jpg"),
    GiftModel(price: "20000", text: " Google play Gift Card 100\$ ", image: "https://scene7.samsclub.com/is/image/samsclub/0079936643535_A"),
    GiftModel(price: "40000", text: " Google play Gift Card 200\$ ", image: "https://media.karousell.com/media/photos/products/2020/01/28/google_play_card_200_1580212481_a3e5fd2b.jpg"),
  ];
  List<CategoriesModel> CategoriesItemsList = [
    CategoriesModel(
      text: 'vehicles',
      image: 'assets/categories/cars.png',
    ),
    CategoriesModel(
      text: 'Buildings&lands',
      image: 'assets/categories/buildings.png',
    ),
    CategoriesModel(
      text: 'Furniture',
      image: 'assets/categories/furniture.png',
    ),
    CategoriesModel(
      text: 'SmartPhones',
      image: 'assets/categories/smartphone.png',
    ),
    CategoriesModel(
      text: 'Watches',
      image: 'assets/categories/watches.png',
    ),
    CategoriesModel(
      text: 'Electronics',
      image: 'assets/categories/electronics.png',
    ),
    CategoriesModel(
      text: 'Electrical devices',
      image: 'assets/categories/electricaldevices.png',
    ),
  ];

  Map<String, dynamic> map = {
    'id': 1,
    'seller': 'joe elbtat',
    'isLive': false,
    'isFavorite': true,
    'isEnd': false,
    'points': 10,
    'cBid': 1000,
    'startDate': '25/2/2022',
    'days': '10',
    'hours': '12',
    'minutes': '36',
    'second': '48',
    'productDate': {
      'title': 'Luxury Villa in Golf Al Sulaymaniya.',
      'description': 'Luxury Villa in Golf Al Sulaymaniya.',
      'images': ['assets/images/bmwx6.jpg', 'assets/images/villa.jpg'],
      'rPrice': 6000,
      'sPrice': 800,
    },
  };
}
