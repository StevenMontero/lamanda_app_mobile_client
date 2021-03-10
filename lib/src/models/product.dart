class Product {
  String? codeProduct;
  String? name;
  String? description;
  double? price;
  String? photoUrl;
  int? stock;
  String? category;

  Product(
    this.name,
    this.description,
    this.price, 
    this.photoUrl,
    this.codeProduct,
    this.stock, 
    this.category);

    Product.fromJson(Map<String, dynamic> json){
      this.codeProduct = json['code'];
      this.name = json['name'];
      this.description = json['description'];
      this.price = json['price'];
      this.photoUrl = json['photoUrl'];
      this.stock = json['stock'];
      this.category = json['category'];    
  }
  
  Map<String, dynamic> toJson(){
    return {
      'code': this.codeProduct,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'photoUrl': this.photoUrl,
      'stock': this.stock,
      'category': this.category,
    };
  }
}
