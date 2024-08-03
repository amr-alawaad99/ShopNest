import 'package:shopnest/models/home_model.dart';

class FavoritesData {
  int? currentPage;
  List<FavoritesModel> data = [];

  FavoritesData(this.currentPage, this.data);

  FavoritesData.fromJson(Map<String, dynamic> json) {

    json["data"].forEach((element){
      data.add(FavoritesModel.fromJson(element));
    });
    currentPage = json["current_page"];

  }

}

class FavoritesModel {
  int? id;
  ProductModel? favProductModel;

  FavoritesModel(this.id, this.favProductModel);

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    favProductModel = ProductModel.fromJson(json["product"]);
  }
}
