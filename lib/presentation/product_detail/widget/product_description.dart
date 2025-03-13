import 'package:ecommerce/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDescription({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        productEntity.description,
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      ),
    );
  }
}
