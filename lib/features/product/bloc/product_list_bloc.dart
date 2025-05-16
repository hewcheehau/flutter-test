import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeg_flutter_test/core/model/product.dart';
import 'package:myeg_flutter_test/core/network/product_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc({required this.productRepository}) : super(ProductListLoading()) {
    on<ProductListFetched>(_onProductListFetched);
    on<ProductSearched>(_onProductSearched);
  }

  final ProductRepository productRepository;

  _onProductListFetched(ProductListFetched event, Emitter<ProductListState> emitter) async {
    emitter(ProductListLoading());
    try {
      final response = await productRepository.getProductList();
      if (response != null && response is Response) {
        emitter(ProductListLoaded(products: (response.data as List).map((e) => Product.fromJson(e)).toList()));
      } else {
        emitter(ProductError());
      }
    } catch (e) {
      emitter(ProductError());
    }
  }

  _onProductSearched(ProductSearched event, Emitter<ProductListState> emitter) async {
    final list = (state as ProductListLoaded).products;
    emitter(ProductListLoading());
    final newList = list.where((item) => (item.title ?? "").toLowerCase().contains(event.keyword.toLowerCase())).toList();
    emitter(ProductSearchLoaded(products: newList));
  }
}
