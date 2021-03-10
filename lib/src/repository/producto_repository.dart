import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lamanda_petshopcr/src/models/product.dart';

class ProductRepository{
  final CollectionReference _ref = FirebaseFirestore.instance.collection('products');

  Future<Product?> getProduct(String productID) async{
    Product product;
    DocumentSnapshot snapshot;
    snapshot = await _ref.doc(productID).get();
    if(snapshot.exists){
      return product = Product.fromJson(snapshot.data()!);
    }else{
      return null;
    }
  }

  Future<List<Product>> getListProducts() async {
    List<Product> productList = [];
    QuerySnapshot snapshot = await _ref.get();
    snapshot.docs.forEach((element) {
      productList.add(Product.fromJson(element.data()!));
    });
    return productList;
  }

  Future<List<Product>> getProductsSearch(String name) async {
    List<Product> productList = [];
    QuerySnapshot snapshot = await _ref.where('name', arrayContains: name).get();
    snapshot.docs.forEach((element) {
      productList.add(Product.fromJson(element.data()!));
    });
    return productList;
  }
}