class MainState {}

final class MainInitState extends MainState{}

final class SignInLoadingState extends MainState{}
final class SignInSuccessState extends MainState{
  final bool state;
  final String message;

  SignInSuccessState({required this.state, required this.message});
}
final class SignInFailureState extends MainState{
  final String error;
  SignInFailureState({required this.error});
}