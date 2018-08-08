import 'package:flutter/material.dart';
import '../models/product_detail.dart';
import '../blocs/products_bloc_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  ProductDetailsScreen({this.productId});

  @override
  Widget build(BuildContext context) {
    ProductsBloc _bloc = ProductsBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('$productId'),),
      body: StreamBuilder(
        stream: _bloc.productDetail,
        builder: (BuildContext context, AsyncSnapshot<ProductDetail> snapshot) {
          if (!snapshot.hasData) {
            _bloc.getProductDetail(productId);
            return Center(child: CircularProgressIndicator(),);
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Product Fetched: ${snapshot.data.name}'),
              Divider(height: 10.0,),
              Text('Number of coverages: ${snapshot.data.coverages.length}')
            ],
          );
        },
      ),
    );
  }
}