

part of 'product_category_cubit.dart';

enum ProductCategoryStatus {
  loading, success, fail, init
}

class ProductCategoryState extends Equatable {
  const ProductCategoryState({this.status = ProductCategoryStatus.init, this.cat  = const [], this.selected = ''});
  final ProductCategoryStatus status;
  final List<String> cat;
  final String selected;
  ProductCategoryState copyWith({
    ProductCategoryStatus? status,
    List<String>? cat,
    String? selected,
  }) {
    return ProductCategoryState(
      status: status ?? this.status,
      cat: cat ?? this.cat,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object?> get props => [status, cat, selected];
}
