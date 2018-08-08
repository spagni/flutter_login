import 'package:flutter/material.dart';
import '../blocs/products_bloc_provider.dart';
import '../models/catalog_detail_response.dart';
import '../widgets/products_scroll_list.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductsBloc _bloc = ProductsBlocProvider.of(context);

    return StreamBuilder(
      stream: _bloc.catalog,
      builder: (BuildContext context, AsyncSnapshot<List<CatalogDetailResponse>> snapshot) {
        if (!snapshot.hasData) {
          _bloc.getCatalog(null);
          return Center(child: CircularProgressIndicator());
        }
        var productsList = snapshot.data;
        return RefreshIndicator(
          child: ListView(
            children: <Widget>[
              ProductsScrollList(
                icon: Icon(Icons.cloud_queue, color: Colors.lime),
                title: 'Top Sellers',
                productsList: productsList,
              ),
              ProductsScrollList(
                icon: Icon(Icons.airplanemode_active, color: Colors.green),
                title: 'Travel',
                productsList: productsList.where((i)=> i.riskCode == 'CT_RISK_TRAVEL').toList(),
              ),
              ProductsScrollList(
                icon: Icon(Icons.phone_iphone, color: Colors.lightBlue),
                title: 'Phones',
                productsList: productsList.where((i)=> i.riskCode == 'CT_RISK_MOBILE').toList(),
              ),
              ProductsScrollList(
                icon: Icon(Icons.child_care, color: Colors.deepOrange),
                title: 'Pets',
                productsList: productsList.where((i)=> i.riskCode == 'CT_RISK_PET').toList(),
              ),
              ProductsScrollList(
                icon: Icon(Icons.data_usage, color: Colors.purple),
                title: 'Bikes',
                productsList: productsList.where((i)=> i.riskCode == 'CT_RISK_BIKE').toList(),
              ),
            ],
          ),
          onRefresh: () async {
            await _bloc.handleGetCatalog(null);
          },
        );
      },
    );
  }
}