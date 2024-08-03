//
// class CategoriesList{
//   List<CategoriesModel> categories = [];
//
//   CategoriesList(this.categories);
//
//   CategoriesList.fromJson(Map<String,dynamic> json){
//     json["data"].forEach((element) {
//       categories.add(CategoriesModel.fromJson(element));
//     });
//   }
// }
//
// class CategoriesModel{
//
//   int? id;
//   String? name;
//   String? image;
//
//   CategoriesModel(this.id, this.name, this.image);
//
//   CategoriesModel.fromJson(Map<String,dynamic> json){
//     id = json["id"];
//     name = json["name"];
//     image = json["image"];
//   }
// }