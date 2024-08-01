import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/cache/cache_helper.dart';
import 'package:shopnest/core/api/api_consumer.dart';
import 'package:shopnest/core/api/end_points.dart';
import 'package:shopnest/core/error/exceptions.dart';
import 'package:shopnest/models/home_model.dart';
import 'package:shopnest/models/user_model.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(this.api) : super(MainInitState());

  final ApiConsumer api;

  // /// Pick Profile Picture
  // XFile? profilePic;
  // pickProfileImage() async {
  //   final XFile? file =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   profilePic = file;
  //   emit(PickProfilePictureState());
  // }

  /// Sign-in
  signIn({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    try {
      final response = await api.post(EndPoint.login, data: {
        ApiKey.email: email,
        ApiKey.password: password,
      });
      response["status"] == true
          ? CacheHelper()
              .saveData(key: ApiKey.token, value: response["data"]["token"])
          : null;
      emit(SignInSuccessState(
        state: response["status"],
        message: response["message"],
      ));
    } on ServerException catch (e) {
      emit(SignInFailureState(errorMessage: e.errorModel.errorMessage));
    }
  }

  /// Sign-up
  signUp({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required String profilePic,
  }) async {
    try {
      emit(SignUpLoadingState());
      final response = await api.post(EndPoint.register, data: {
        ApiKey.name: name,
        ApiKey.email: email,
        ApiKey.phoneNumber: phoneNumber,
        ApiKey.password: password,
      });
      CacheHelper()
          .saveData(key: ApiKey.token, value: response["data"]["token"]);
      emit(SignInSuccessState(
        state: response["status"],
        message: response["message"],
      ));
    } on ServerException catch (e) {
      emit(SignUpFailureState(errorMessage: e.errorModel.errorMessage));
    }
  }

  UserModel? userModel;

  /// Get User Data
  getUserProfile() async {
    emit(GetUserProfileLoadingState());
    try {
      final response = await api.get(
        EndPoint.profile,
      );
      userModel = UserModel.fromJson(response["data"]);
      emit(GetUserProfileSuccessState());
    } on ServerException catch (e) {
      emit(GetUserProfileFailureState(errorMessage: e.errorModel.errorMessage));
    }
  }

  HomeModel? homeModel;
  ///Get Home Page Data
  getHomeData() async {
    try {
      emit(GetHomeDataLoadingState());
      final response = await api.get(EndPoint.home);
      homeModel = HomeModel.fromJson(response);
      emit(GetHomeDataSuccessState());
    } on ServerException catch (e) {
      emit(GetHomeDataFailureState(errorMessage: e.errorModel.errorMessage));
    }
  }
}
