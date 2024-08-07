class MainState {}

final class MainInitState extends MainState {}

/// Pick Profile Image State
final class PickProfilePictureState extends MainState {}

/// Sign-in States
final class SignInLoadingState extends MainState {}

final class SignInSuccessState extends MainState {
  final bool state;
  final String message;

  SignInSuccessState({required this.state, required this.message});
}

final class SignInFailureState extends MainState {
  final String errorMessage;

  SignInFailureState({required this.errorMessage});
}

/// Sign-up States
final class SignUpLoadingState extends MainState {}

final class SignUpSuccessState extends MainState {
  final bool state;
  final String message;

  SignUpSuccessState({required this.state, required this.message});
}

final class SignUpFailureState extends MainState {
  final String errorMessage;

  SignUpFailureState({required this.errorMessage});
}

/// Get User Profile States
final class GetUserProfileLoadingState extends MainState {}

final class GetUserProfileSuccessState extends MainState {}

final class GetUserProfileFailureState extends MainState {
  final String errorMessage;

  GetUserProfileFailureState({required this.errorMessage});
}

/// Update User Profile States
final class UpdateUserProfileLoadingState extends MainState {}

final class UpdateUserProfileSuccessState extends MainState {
  final bool status;
  final String message;

  UpdateUserProfileSuccessState({required this.status, required this.message});

}

final class UpdateUserProfileFailureState extends MainState {
  final String errorMessage;

  UpdateUserProfileFailureState({required this.errorMessage});
}

/// Get home screen data states
final class GetHomeDataLoadingState extends MainState {}

final class GetHomeDataSuccessState extends MainState {}

final class GetHomeDataFailureState extends MainState {
  final String errorMessage;

  GetHomeDataFailureState({required this.errorMessage});
}

/// Get my favorites screen data states
final class GetMyFavoritesDataLoadingState extends MainState {}

final class GetMyFavoritesDataSuccessState extends MainState {}

final class GetMyFavoritesDataFailureState extends MainState {
  final String errorMessage;

  GetMyFavoritesDataFailureState({required this.errorMessage});
}

/// Get my cart screen data states
final class GetMyCartDataLoadingState extends MainState {}

final class GetMyCartDataSuccessState extends MainState {}

final class GetMyCartDataFailureState extends MainState {
  final String errorMessage;

  GetMyCartDataFailureState({required this.errorMessage});
}


/// Change BottomNavigationBar state
final class BottomNavBarChangeState extends MainState{}
/// Add/Delete to/from Favorites state
final class AddedxDeletedFavoriteItemState extends MainState{}
/// Add/Delete to/from Cart state
final class AddedxDeletedCartItemState extends MainState{}

/// Remove all items in Cart state
final class RemoveAllCartItemsLoadingState extends MainState {}

final class RemoveAllCartItemsSuccessState extends MainState {}

final class RemoveAllCartItemsFailureState extends MainState {
  final String errorMessage;

  RemoveAllCartItemsFailureState({required this.errorMessage});
}