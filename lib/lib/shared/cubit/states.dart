
abstract class StatesApp {}

class InitialState extends StatesApp{}

class OnChangeAppModeState extends StatesApp {}

class onBoardingSkipedState extends StatesApp{}

class OnChangeAppLangState extends StatesApp {}

class LoginLoadingState extends StatesApp{}

class IsLoginPasswordState extends StatesApp{}

class ChangeOnBoardingIndexState extends StatesApp{}

class ChangeBottomNavBarIndexState extends StatesApp{}

class ChangeDrawerSelectedIndexState extends StatesApp{}

class ChangeFavoriteAuctionState extends StatesApp{}


class LoginSuccessState extends StatesApp{}

class LoginErrorState extends StatesApp{
   final String error;
   LoginErrorState(this.error);
}
class LogoutSuccessState extends StatesApp{}

class LogoutLoadingState extends StatesApp{}

class LogouErrorState extends StatesApp{
  final String error;
  LogouErrorState(this.error);
}
class CreateUserSuccessState extends StatesApp{}
class onChangedSelectedSmallAuctionImageState extends StatesApp{}

class CreateUserErrorState extends StatesApp{
   final String error;
   CreateUserErrorState(this.error);
}

class RegisterLodingState extends StatesApp{}

class RegisterSuccessedState extends StatesApp{}

class RegisterErrorState extends StatesApp{
     final String error;
     RegisterErrorState(this.error);
}

class GetUserDataSuccessState extends StatesApp{}

class GetUserDataLoadingState extends StatesApp{}

class GetUserDataErrorState extends StatesApp{
  final String error;
  GetUserDataErrorState(this.error);
}
class LoginFBSuccessState extends StatesApp{}
class LoginFBErrorState extends StatesApp{}
class LoginFBLoadingState extends StatesApp{}

class PickProfileImageSuccessState extends StatesApp{}
class PickProfileImageErrorState extends StatesApp{}

class UploadProfileImageSuccessState extends StatesApp{}

class UploadProfileImageErrorState extends StatesApp{}

class UpDateUserDateErrorState extends StatesApp{}
class UpDateUserDateLoadingState extends StatesApp{}

class OnSpinnerCategoriesChangeState extends StatesApp{}

class OnSpinnerTypeChangeState extends StatesApp{}

class AddAuctionRemoveSelectedPictureState extends StatesApp{}

class AddAuctionSelectImagesState extends StatesApp{}

class uploadAddAuctionSelectImagesLoadingState extends StatesApp{}

class uploadAddAuctionSelectImagesSuccessState extends StatesApp{}

class uploadAddAuctionSelectImagesErrorState extends StatesApp{}

class AddAuctionLoadingState extends StatesApp{}

class AddAuctionSuccessState extends StatesApp{}

class AddAuctionErrorState extends StatesApp{}

class GetAllAuctionsLoadingState extends StatesApp{}

class GetAllAuctionsSuccessState extends StatesApp{}

class GetAllAuctionsErrorState extends StatesApp{}

class CreateGoogleUserErrorState extends StatesApp{}

class CreateGoogleUserSuccessState extends StatesApp{}

class CreateGoogleUserLoadingState extends StatesApp{}

class GetUsersEmailsLoadingState extends StatesApp {}

class GetUsersEmailsErrorState extends StatesApp{}

class GetUsersEmailsSuccessState extends StatesApp{}

class BidIncrementState extends StatesApp{}

class BidDecrementState extends StatesApp{}

class AddBidLoadingState extends StatesApp{}

class AddBidSuccessState extends StatesApp{}

class AddBidErrorState extends StatesApp{}





