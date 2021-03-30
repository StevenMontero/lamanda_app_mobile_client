class Service {
  String name = '';
  double price = 0;

  Service({required this.name, required this.price});

  Service.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'price': this.price,
     
    };
  }
}
