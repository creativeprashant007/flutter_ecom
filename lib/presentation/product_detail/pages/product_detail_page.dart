import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/domain/product/entities/product_entity.dart';
import 'package:ecommerce/presentation/product_detail/bloc/color_selection_cubit.dart';
import 'package:ecommerce/presentation/product_detail/bloc/favorite_icon_cubit.dart';
import 'package:ecommerce/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecommerce/presentation/product_detail/widget/add_to_bag.dart';
import 'package:ecommerce/presentation/product_detail/widget/favorite_button.dart';
import 'package:ecommerce/presentation/product_detail/widget/product_description.dart';
import 'package:ecommerce/presentation/product_detail/widget/product_images.dart';
import 'package:ecommerce/presentation/product_detail/widget/product_price.dart';
import 'package:ecommerce/presentation/product_detail/widget/product_quantity.dart';
import 'package:ecommerce/presentation/product_detail/widget/product_title.dart';
import 'package:ecommerce/presentation/product_detail/widget/selected_color.dart';
import 'package:ecommerce/presentation/product_detail/widget/selected_size.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductQuantityCubit()),
        BlocProvider(create: (context) => ProductColorSelectionCubit()),

        BlocProvider(
          create:
              (context) =>
                  FavoriteIconCubit()..isFavorite(productEntity.productId),
        ),
      ],
      child: Scaffold(
        appBar: BasicAppBar(
          hideBack: false,
          action: FavoriteButton(productEntity: productEntity),
        ),
        bottomNavigationBar: AddToBag(productEntity: productEntity),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImages(productEntity: productEntity),
              const SizedBox(height: 10),
              ProductTitle(productEntity: productEntity),
              const SizedBox(height: 7),
              ProductDescription(productEntity: productEntity),
              const SizedBox(height: 10),
              ProductPrice(productEntity: productEntity),
              const SizedBox(height: 20),
              SelectedSize(productEntity: productEntity),
              const SizedBox(height: 15),
              SelectedColor(productEntity: productEntity),
              const SizedBox(height: 15),
              ProductQuantity(productEntity: productEntity),
            ],
          ),
        ),
      ),
    );
  }
}
