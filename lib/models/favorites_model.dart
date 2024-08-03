import 'package:shopnest/models/home_model.dart';

class FavoritesData {
  int? currentPage;
  List<ProductModel> data = [];

  FavoritesData(this.currentPage, this.data);

  FavoritesData.fromJson(Map<String, dynamic> json) {

    json["data"].forEach((element){
      data.add(ProductModel.fromJson(element["product"]));
    });
    currentPage = json["current_page"];
  }

}
