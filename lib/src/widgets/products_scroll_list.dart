import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../models/catalog_detail_response.dart';

class ProductsScrollList extends StatelessWidget {
  final List<CatalogDetailResponse> productsList;
  final String title;
  final Icon icon;

  ProductsScrollList({@required this.productsList, @required this.title, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(19.0, 16.0,16.0,4.0),
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 5.0),child: this.icon),
                Text(this.title, textAlign: TextAlign.left, style: Theme.of(context).textTheme.title)
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 1,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              childAspectRatio: 6.0 /5.0,
              children: _buildList(productsList),
            ),
          )
        ],
      ),
    );
  }

  List<ProductCard> _buildList(List<CatalogDetailResponse> productsList) {
    return productsList.map((product) {
      return ProductCard(product: product);
    }).toList();
  }
}