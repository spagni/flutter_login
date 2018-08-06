import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  ProductDetailsScreen({this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$productId'),),
      body: Container(
        alignment: Alignment.topCenter,
        child: Image.asset('assets/images/CT_RISK_TRAVEL.png', fit: BoxFit.cover,)
      ),
    );
  }
}