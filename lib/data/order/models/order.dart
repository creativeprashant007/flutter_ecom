// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce/data/order/models/order_status.dart';
import 'package:ecommerce/data/order/models/product_ordered.dart';
import 'package:ecommerce/domain/order/entities/order.dart';

class OrderModel {
  final List<ProductOrderedModel> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;
  final String code;
  final List<OrderStatusModel> orderStatus;

  OrderModel({
    required this.products,
    required this.createdDate,
    required this.shippingAddress,
    required this.itemCount,
    required this.totalPrice,
    required this.code,
    required this.orderStatus,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      products:
          (map['products'] as List<dynamic>?)
              ?.map(
                (e) => ProductOrderedModel.fromMap(e as Map<String, dynamic>),
              )
              .toList() ??
          [], // Default to empty list if null
      createdDate:
          map['createdDate'] as String? ?? '', // Default to empty string
      shippingAddress: map['shippingAddress'] as String? ?? '',
      itemCount: map['itemCount'] as int? ?? 0, // Default to 0
      totalPrice:
          (map['totalPrice'] as num?)?.toDouble() ?? 0.0, // Ensure double type
      code: map['code'] as String? ?? '',
      orderStatus:
          (map['orderStatus'] as List<dynamic>?)
              ?.map((e) => OrderStatusModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

extension OrderXModel on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
      products: products.map((e) => e.toEntity()).toList(),
      createdDate: createdDate,
      shippingAddress: shippingAddress,
      itemCount: itemCount,
      totalPrice: totalPrice,
      code: code,
      orderStatus: orderStatus.map((e) => e.toEntity()).toList(),
    );
  }
}
