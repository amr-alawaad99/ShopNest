class UserModel{
  int? uId;
  String? name;
  String? image;
  String? phone;
  String? email;
  String? token;


  UserModel({
    this.uId,
    this.name,
    this.image,
    this.phone,
    this.email,
    this.token
  });

  UserModel.fromJson(Map<String,dynamic> json){
    uId = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toMap(){
    return{
      'id' : uId,
      'name' : name,
      'image' : image,
      'phone' : phone,
      'email' : email,
      'token' : token,
    };
  }
}