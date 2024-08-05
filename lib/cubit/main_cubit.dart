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
  int itemsInCart = 0;

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
      response["status"] == true
          ? CacheHelper()
          .saveData(key: ApiKey.token, value: response["data"]["token"])
          : null;
      emit(SignUpSuccessState(
        state: response["status"],
        message: response["message"],
      ));
    } on ServerException catch (e) {
      emit(SignUpFailureState(errorMessage: e.errorModel.errorMessage));
    }
  }

  /// Logout
  logout(){
    CacheHelper().removeData(key: ApiKey.token);
    homeModel = null;
    userModel = null;
    currentPageIndex = 0;
    itemsInCart = 0;
  }

  int currentPageIndex = 0;
  /// change bottom nav bar
  changeBottomNavBar(int value){
    currentPageIndex = value;
    emit(BottomNavBarChangeState());
  }


  UserModel? userModel;
  /// Get User Data
  Future<UserModel?> getUserProfile() async {
    emit(GetUserProfileLoadingState());
    try {
      final response = await api.get(
        EndPoint.profile,
      );
      userModel = UserModel.fromJson(response["data"]);
      emit(GetUserProfileSuccessState());
      return userModel;
    } on ServerException catch (e) {
      emit(GetUserProfileFailureState(errorMessage: e.errorModel.errorMessage));
      return null;
    }
  }
  
//   updateUserData({
//     required String name,
//     required String email,
//     required String phoneNumber,
// }) async {
//     try {
//       emit(UpdateUserProfileLoadingState());
//       final response = await api.put(EndPoint.updateProfile, data: {
//         ApiKey.name : name,
//         ApiKey.email : email,
//         ApiKey.phoneNumber : phoneNumber,
//       });
//       userModel!.name = name;
//       userModel!.email = email;
//       userModel!.phone = phoneNumber;
//
//       emit(UpdateUserProfileSuccessState(status: response["status"], message: response["message"]));
//     } on ServerException catch (e) {
//       emit(UpdateUserProfileFailureState(errorMessage: e.errorModel.errorMessage));
//     }
// }

  HomeModel? homeModel;
  ///Get Home Page Data
  Future<HomeModel?> getHomeData() async {
    try {
      emit(GetHomeDataLoadingState());
      final response = await api.get(EndPoint.home);
      homeModel = HomeModel.fromJson(response);
      itemsInCart = homeModel!.homeData!.products.where((element) => element.inCart!,).length;
      emit(GetHomeDataSuccessState());
      return homeModel;
    } on ServerException catch (e) {
      emit(GetHomeDataFailureState(errorMessage: e.errorModel.errorMessage));
    }
    return null;
  }

  /// Add/Delete a product item to/from your favorites
  addXdeleteFavorite(int productId, ProductModel p) async {
      await api.post(EndPoint.favorites, data: {
        ApiKey.productId : productId,
      });
      p.inFavorites = !p.inFavorites!;
      emit(AddedxDeletedFavoriteItemState());
  }

  /// Add/Delete a product item to/from your cart
  addXdeleteCart(int productId, ProductModel p) async {
    await api.post(EndPoint.cart, data: {
      ApiKey.productId : productId,
    });
    p.inCart = !p.inCart!;
    emit(AddedxDeletedCartItemState());
  }

  /// Remove all items in your Cart
  removeAllItemsInCart(List<int> productsId) async {
    try {
      emit(RemoveAllCartItemsLoadingState());
      for (int itemId in productsId) {
        print(itemId);
        await api.post(EndPoint.cart, data: {
          ApiKey.productId : itemId,
        });
      }
      currentPageIndex = 0;
      await getHomeData();
      emit(RemoveAllCartItemsSuccessState());
    } on ServerException catch (e) {
      emit(RemoveAllCartItemsFailureState(errorMessage: e.errorModel.errorMessage));
    }
  }

  updateState(){
    emit(MainInitState());
  }

}