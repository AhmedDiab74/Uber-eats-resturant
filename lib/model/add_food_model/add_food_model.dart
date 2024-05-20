class AddFoodModel {
  final String name;
  final String description;
  final String resturantUID;
  final String foodID;
  final DateTime uplaodTime;
  final String foodImageURL;
  final bool isVegetrian;
  final String price;

  AddFoodModel({
    required this.uplaodTime,
    required this.foodID,
    required this.resturantUID,
    required this.name,
    required this.description,
    required this.foodImageURL,
    required this.isVegetrian,
    required this.price,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'resturantUID': resturantUID,
      'uplaodTime': uplaodTime,
      'description': description,
      'foodImageURL': foodImageURL,
      'foodID': foodID,
      'isVegetrain': isVegetrian,
      'price': price,
    };
  }
}
