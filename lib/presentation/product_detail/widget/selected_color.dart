import 'package:ecommerce/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:ecommerce/common/helper/color/color.dart';
import 'package:ecommerce/core/configs/theme/app_colors.dart';
import 'package:ecommerce/domain/product/entities/product_entity.dart';
import 'package:ecommerce/presentation/product_detail/bloc/color_selection_cubit.dart';
import 'package:ecommerce/presentation/product_detail/widget/product_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedColor extends StatelessWidget {
  final ProductEntity productEntity;
  const SelectedColor({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppBottomsheet.display(
          context,
          BlocProvider.value(
            value: BlocProvider.of<ProductColorSelectionCubit>(context),
            child: ProductColors(productEntity: productEntity),
          ),
        );
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            Row(
              children: [
                BlocBuilder<ProductColorSelectionCubit, int>(
                  builder:
                      (context, index) => Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: ColorHelper.getColor(
                            productEntity.colors[index].hexCode,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.keyboard_arrow_down, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
