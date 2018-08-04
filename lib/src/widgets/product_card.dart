import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/catalog_detail_response.dart';

class ProductCard extends StatelessWidget {
  final CatalogDetailResponse product;
  
  ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString());

    return Card(
      elevation: 3.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18.0/10.0,
            child: Image.asset('assets/images/${product.riskCode}.png', fit: BoxFit.fill)
          ),
          Divider(height: 1.0, indent: 20.0,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    product.name, 
                    style: theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
                    softWrap: true,
                    textAlign: TextAlign.center,
                    //overflow: TextOverflow.ellipsis,
                    //maxLines: 1
                  ),
                  SizedBox(height: 8.0),
                  Text(formatter.format(product.price), style: theme.textTheme.subhead,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}