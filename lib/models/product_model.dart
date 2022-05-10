class ProductModel {
  int? status;
  List<Data>? data;

  ProductModel({this.status, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  int? categoryId;
  String? name;
  String? color;
  int? regularPrice;
  bool? onSale;
  int? salePrice;
  int? amount = 0;
  bool? isFavourite;
  bool? isFavLoading = false;
  String? amountDetails;
  Data(
      {this.id,
      this.categoryId,
      this.name,
      this.color,
      this.isFavourite,
      this.isFavLoading = false,
      this.amount = 0,
      this.regularPrice,
      this.salePrice,
      this.onSale,
      this.amountDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    color = json['color'];
    if (json['regular_price'] != null) {
      regularPrice = json['regular_price'];
    }
    if (json['on_sale'] != null) {
      onSale = json['on_sale'];
    }
    if (json['sale_price'] != null) {
      salePrice = json['sale_price'];
    }
    if (json['is_favourite'] != null) {
      isFavourite = json['is_favourite'];
    }
    amountDetails = json['amount_details'];
  }
}
