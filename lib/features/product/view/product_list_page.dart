import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeg_flutter_test/core/extension.dart';
import 'package:myeg_flutter_test/features/product/bloc/product_list_bloc.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List'), backgroundColor: Colors.white),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder:
              (context, state) => switch (state) {
                ProductListLoading() => Center(child: CircularProgressIndicator.adaptive()),
                ProductListLoaded() => RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProductListBloc>().add(ProductListFetched());
                  },
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1 / 1.8, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final data = state.products[index];
                      return Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                        child: LayoutBuilder(
                          builder: (context, ly) {
                            return Column(
                              children: [
                                CachedNetworkImage(
                                  height: ly.maxHeight / 2,
                                  imageUrl: data.imageUrl ?? "",
                                  errorWidget: (context, url, error) => Text('ERROR'),
                                ),
                                Container(
                                  height: ly.maxHeight / 2,
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      10.ph,
                                      Text(data.title ?? "", maxLines: 3),
                                      3.ph,
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(border: Border.all(color: Colors.green[900]!)),
                                        child: Text(data.category ?? "", maxLines: 1, style: TextStyle(fontSize: 11, color: Colors.green[900]!)),
                                      ),
                                      Spacer(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(Icons.star, color: Colors.amber),
                                          3.pw,
                                          Text(data.rating?.count.toString() ?? ""),
                                          const Spacer(),
                                          Text(data.price?.toPrice()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                    itemCount: state.products.length,
                  ),
                ),
                _ => Center(child: Text('Error occured')),
              },
        ),
      ),
    );
  }
}
