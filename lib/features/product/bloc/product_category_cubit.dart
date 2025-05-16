import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeg_flutter_test/core/network/product_repository.dart';

part 'product_category_state.dart';

class ProductCategoryCubit extends Cubit<ProductCategoryState> {
  ProductCategoryCubit({required this.productRepository}) : super(const ProductCategoryState());

  final ProductRepository productRepository;

  Future<void> fetchProductCategory() async {
    emit(state.copyWith(status: ProductCategoryStatus.loading));
    try {
      final response = await productRepository.getProductCategory();
      if (response.data is List) {
        emit(state.copyWith(cat: (response.data as List).map((e) => e.toString()).toList(), status: ProductCategoryStatus.success));
        return;
      }
      emit(state.copyWith(status: ProductCategoryStatus.fail));
    } catch (e) {
      emit(state.copyWith(status: ProductCategoryStatus.fail));
    }
  }

  void filterCategory(String e) {
    if (e == state.selected) {
      emit(state.copyWith(selected: ''));
      return;
    }
    emit(state.copyWith(selected: e));
  }
}
