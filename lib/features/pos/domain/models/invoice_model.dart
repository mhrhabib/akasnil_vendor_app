import 'package:sixvalley_vendor_app/features/addProduct/domain/models/edt_product_model.dart';

import '../../../product/domain/models/product_model.dart';

class InvoiceModel {
  double? orderAmount;
  double? paidAmount;
  String? createdAt;
  double? discountAmount;
  double? extraDiscount;
  String? extraDiscountType;
  String? paymentMethod;
  List<Details>? details;

  InvoiceModel(
    {
      this.orderAmount,
      this.paidAmount,
      this.createdAt,
      this.extraDiscount,
      this.extraDiscountType,
      this.paymentMethod,
      this.details
    }
  );

  InvoiceModel.fromJson(Map<String, dynamic> json) {


    if(json['order_amount'] != null){
      try{
        orderAmount = json['order_amount'].toDouble();
      }catch(e){
        orderAmount = double.parse(json['order_amount'].toString());
      }
    }

    if(json['paid_amount'] != null){
      try{
        paidAmount = json['paid_amount'].toDouble();
      }catch(e) {
        paidAmount = double.parse(json['paid_amount'].toString());
      }
    }

    createdAt = json['created_at'];
    paymentMethod = json['payment_method'];

    if(json['discount_amount'] != null){
      try{
        discountAmount = json['discount_amount'].toDouble();
      }catch(e){
        discountAmount = double.parse(json['discount_amount'].toString());
      }
    }
    if(json['extra_discount'] != null){
      try{
        extraDiscount = json['extra_discount'].toDouble();
      }catch(e){
        extraDiscount = double.parse(json['extra_discount'].toString());
      }
    }

    if(json['extra_discount_type'] != null){
      try{
        extraDiscountType = json['extra_discount_type'];
      }catch(e){
        extraDiscountType = json['extra_discount_type'];
      }
    }

    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_amount'] = orderAmount;
    data['paid_amount'] = paidAmount;
    data['created_at'] = createdAt;
    data['discount_amount'] = discountAmount;
    data['extra_discount'] = extraDiscount;
    data['payment_method'] = paymentMethod;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  ProductDetails? productDetails;
  int? qty;
  double? price;
  double? tax;
  double? discount;
  String? discountType;
  String? variant;
  String? taxModel;


  Details(
      {this.id,
        this.productDetails,
        this.qty,
        this.price,
        this.tax,
        this.discount,
        this.discountType,
        this.variant,
        this.taxModel
        });

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
    qty = json['qty'];
    if(json['price'] != null){
      try{
        price = json['price'].toDouble();
      }catch(e){
        price = double.parse(json['price'].toString());
      }
    }

    if(json['tax'] != null){
      try{
        tax = json['tax'].toDouble();
      }catch(e){
        tax = double.parse(json['tax'].toString());
      }
    }

    if(json['discount'] != null){
      try{
        discount = json['discount'].toDouble();
      }catch(e){
        discount = double.parse(json['discount'].toString());
      }
    }
    discountType = json['discount_type'];

    variant = json['variant'];

    taxModel = json['tax_model'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (productDetails != null) {
      data['product_details'] = productDetails!.toJson();
    }
    data['qty'] = qty;
    data['price'] = price;
    data['tax'] = tax;
    data['discount'] = discount;
    data['discount_type'] = discountType;
    data['variant'] = variant;
    return data;
  }
}

class ProductDetails {

  String? name;
  String? taxModel;
  double? discount;
  double? unitPrice;
  String? discountType;
  String? productType;
  List<DigitalVariation>? digitalVariation;


  ProductDetails(
    {
      this.name,
      this.taxModel,
      this.discount,
      this.discountType,
      this.digitalVariation,
      this.productType,
      this.unitPrice
    });

  ProductDetails.fromJson(Map<String, dynamic> json) {

    name = json['name'];
    taxModel = json['tax_model'];
    discount = json['discount'] != null?
    json['discount'].toDouble() : 0;
    discountType = json['discount_type'];
    productType = json['product_type'];
    unitPrice = double.parse(json['unit_price'].toString());
    if (json['digital_variation'] != null) {
      digitalVariation = <DigitalVariation>[];
      json['digital_variation'].forEach((v) {
        digitalVariation!.add(DigitalVariation.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['discount'] = taxModel;
    data['tax_model'] = taxModel;

    return data;
  }
}

