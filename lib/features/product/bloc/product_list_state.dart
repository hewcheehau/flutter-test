part of 'product_list_bloc.dart';

@immutable
sealed class ProductListState extends Equatable {
  const ProductListState();
}


final class ProductListLoading extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductListLoaded extends ProductListState {
  const ProductListLoaded({this.products = const []});

  final List<Product> products;

  @override
  List<Object> get props => [products];
}

final class ProductError extends ProductListState {
  @override
  List<Object> get props => [];
}