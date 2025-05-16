import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myeg_flutter_test/core/extension.dart';
import 'package:myeg_flutter_test/features/product/bloc/product_category_cubit.dart';
import 'package:myeg_flutter_test/features/product/bloc/product_list_bloc.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        // TextFormField(
        //   decoration: InputDecoration(
        //     isDense: true,
        //     hintText: 'Searchi Product Name...',
        //     border: OutlineInputBorder(),
        //     suffixIcon: Icon(CupertinoIcons.search),
        //   ),
        //   onChanged: (value) {
        //     if (value.isNotEmpty) {
        //       _debounce = Timer(Duration(milliseconds: 500), () {
        //         context.read<ProductListBloc>().add(ProductSearched(keyword: value));
        //       });
        //     }
        //   },
        // ),
        backgroundColor: Colors.amberAccent[800],
        actions: [IconButton(onPressed: () => context.push('/cart'), icon: Icon(Icons.shopping_cart))],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
              builder: (context, catState) {
            return Column(
              children: [
                SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...catState.cat.map(
                            (e) => InkWell(
                              onTap: () {
                                context.read<ProductCategoryCubit>().filterCategory(e);
                              },
                              child: _CategoryWidget(name: e, fontSize: 15, bgColor: Colors.grey, isSelected: e == catState.selected,))
                          ),
                        ],
                      ),
                    ),
                20.ph,
                Expanded(
                  child: BlocBuilder<ProductListBloc, ProductListState>(
                    builder:
                        (context, state) => switch (state) {
                          ProductListLoading() => Center(child: CircularProgressIndicator.adaptive()),
                          ProductListLoaded() => RefreshIndicator(
                            onRefresh: () async {
                              context.read<ProductListBloc>().add(ProductListFetched());
                            },
                            child:
                                state.products.isEmpty
                                    ? Container(
                                      alignment: Alignment.center,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.search), 10.ph, Text('No results')]),
                                    )
                                    : Builder(
                                      builder: (context) {
                                        final filterProduct = catState.selected.isNotEmpty ? state.products.where((e) => e.category == catState.selected).toList() : state.products;
                                        return GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1 / 1.8, crossAxisCount: 2),
                                          itemBuilder: (context, index) {
                                            final data = filterProduct[index];
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
                                                            _CategoryWidget(name: data.category ??"",),
                                                            Spacer(),
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              children: [
                                                                Icon(Icons.star, color: Colors.amber),
                                                                3.pw,
                                                                Text(data.rating?.rate.toString() ?? ""),
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
                                          itemCount: filterProduct.length,
                                        );
                                      }
                                    ),
                          ),
                          _ => Center(child: Text('Error occured')),
                        },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({this.name = "", this.fontSize, this.bgColor, this.isSelected = false});
  final String name;
  final double? fontSize;
  final Color? bgColor;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final color = Colors.green[900]!;
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(border: Border.all(color: isSelected ? color : (bgColor) ?? color)),
      child: Row(
        children: [
          Text(name, maxLines: 1, style: TextStyle(fontSize: fontSize ?? 11, color:isSelected ? color : Colors.black)),
          if (bgColor != null && isSelected) 
          ... [
            3.pw,
            Icon(Icons.cancel_presentation, color: color,)
          ]
        ],
      ),
    );
  }
}
