part of 'product_list_bloc.dart';

@immutable
sealed class ProductListEvent extends Equatable {
  const ProductListEvent();
}

final class ProductListInitial extends ProductListEvent {
  @override
  List<Object> get props => [];
}

final class ProductListFetched extends ProductListEvent {
  const ProductListFetched();

  @override
  List<Object> get props => [];
}
