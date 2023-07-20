class Cart{
  late final int ? id;
  final String? shirtId;
  final String? shirtName;
  final int? shirtPrice;
  final String? image;

  Cart({
   required this.id,
    required this.shirtId,
    required this.shirtName,
    required this.shirtPrice,
    required this.image
});

  Cart.fromMap(Map<dynamic,dynamic> res)
  :id=res['id'],
  shirtId=res['shirtId'],
  shirtName=res['shirtName'],
  shirtPrice=res['shirtPrice'],
  image=res['image'];

  Map<String, Object?> toMap(){
    return {
      'id':id,
      'shirtId':shirtId,
      'shirtName' : shirtName,
      'shirtPrice' : shirtPrice,
      'image' :image,
    };
  }
}
