import 'home_model.dart';

class CartModel{
  List<CartItemsModel> cartItemModel = [];

  CartModel(this.cartItemModel);

  CartModel.fromJson(Map<String, dynamic> json){
    json["cart_items"].forEach((element){
      cartItemModel.add(CartItemsModel.fromJson(element));
    });
  }

}


class CartItemsModel{
  int? id;
  int? quantity;
  ProductModel? cartProduct;

  CartItemsModel(this.id, this.quantity, this.cartProduct);

  CartItemsModel.fromJson(Map<String, dynamic> json){
    id = json["id"];
    quantity = json["quantity"];
    cartProduct = ProductModel.fromJson(json["product"]) ;
  }

  
}