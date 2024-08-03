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

/// Sign-up States
final class GetUserProfileLoadingState extends MainState {}

final class GetUserProfileSuccessState extends MainState {}

final class GetUserProfileFailureState extends MainState {
  final String errorMessage;
  GetUserProfileFailureState({required this.errorMessage});
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
