import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/core/extension.dart';
import 'package:myeg_flutter_test/core/model/product.dart';

typedef st = TextStyle;

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Center(
        child: LayoutBuilder(
          builder: (context, ly) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 1,
                    maxScale: 4,
                    child: CachedNetworkImage(imageUrl: product.imageUrl ?? "", height: ly.maxHeight * 0.45, width: double.maxFinite),
                  ),
                ),
                10.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.price.toPrice(), style: st(fontWeight: FontWeight.bold, fontSize: 20)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              3.pw,
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${product.rating?.count ?? "-"} people had rated.")));
                                },
                                child: Text("${product.rating?.rate.toString()}(${product.rating?.count.toString()}) Rating", style: st(decoration: TextDecoration.underline),)),
                            ],
                          ),
                        ],
                      ),
                      3.ph,
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(border: Border.all(color: Colors.green[900]!)),
                        child: Text(product.category ?? "", maxLines: 1, style: TextStyle(fontSize: 11, color: Colors.green[900]!)),
                      ),
                      15.ph,
                      Text(product.title ?? "", style: st(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.left, maxLines: 5),
                      10.ph,
                      Text(product.description ?? "", style: st(fontSize: 15), maxLines: 5, textAlign: TextAlign.left),
                    ],
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    height: ly.maxHeight * 0.15,
                    width: double.maxFinite,
                    child: Row(children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          height: 150,
                          color: Colors.amber[800],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Add to Cart', style: st(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                              10.pw,
                              Icon(CupertinoIcons.cart_badge_plus, color: Colors.white,)
                            ],
                          )
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
