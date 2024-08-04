import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopnest/cache/cache_helper.dart';
import 'package:shopnest/core/api/api_consumer.dart';
import 'package:shopnest/core/api/end_points.dart';
import 'package:shopnest/core/error/exceptions.dart';
import 'package:shopnest/models/cart_model.dart';
import 'package:shopnest/models/favorites_model.dart';
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

  int currentPageIndex = 0;
  /// change bottom nav bar
  changeBottomNavBar(int value){
    currentPageIndex = value;
    emit(BottomNavBarChangeState());
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
  Future<HomeModel?> getHomeData() async {
    try {
      emit(GetHomeDataLoadingState());
      final response = await api.get(EndPoint.home);
      homeModel = HomeModel.fromJson(response);
      emit(GetHomeDataSuccessState());
      return homeModel;
    } on ServerException catch (e) {
      emit(GetHomeDataFailureState(errorMessage: e.errorModel.errorMessage));
    }
    return null;
  }

  // /// Get Categories data
  // getCategories() async {
  //   try {
  //     final response = await api.get(EndPoint.categories);
  //     print(response["data"]["data"]);
  //   } on ServerException catch (e) {
  //
  //     print("error");
  //   }
  // }

  FavoritesData? favoritesModel;
  ///Get Home Page Data
  Future<FavoritesData?> getMyFavorites() async {
      try {
        emit(GetMyFavoritesDataLoadingState());
        final response = await api.get(EndPoint.favorites);
        favoritesModel = FavoritesData.fromJson(response["data"]);
        emit(GetMyFavoritesDataSuccessState());
        return favoritesModel;
      } on ServerException catch (e) {
        emit(GetMyFavoritesDataFailureState(errorMessage: e.errorModel.errorMessage));
      }
      return null;
  }

  CartModel? cartModel;
  ///Get Home Page Data
  Future<CartModel?> getMyCart() async {
    try {
      emit(GetMyCartDataLoadingState());
      final response = await api.get(EndPoint.cart);
      cartModel = CartModel.fromJson(response["data"]);
      emit(GetMyCartDataSuccessState());
      return cartModel;
    } on ServerException catch (e) {
      emit(GetMyCartDataFailureState(errorMessage: e.errorModel.errorMessage));
    }
    return null;
  }

  addXdeleteFavorite(int productId) async {
      await api.post(EndPoint.favorites, data: {
        ApiKey.productId : productId,
      });
      emit(AddedxDeletedFavoriteItemState());
  }

  addXdeleteCart(int productId) async {
    await api.post(EndPoint.cart, data: {
      ApiKey.productId : productId,
    });
    emit(AddedxDeletedCartItemState());
  }
}
