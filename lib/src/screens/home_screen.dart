import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../utils/shared_preferences.dart';
import '../blocs/products_bloc_provider.dart';
import '../models/catalog_detail_response.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductsBloc _bloc = ProductsBlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cautus'),
      ),
      body: _buildProductsList(_bloc),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () => _onPressed(context),
      ),
    );
  }

  Widget _buildProductsList(ProductsBloc bloc) {
    return StreamBuilder(
      stream: bloc.catalog,
      builder: (BuildContext context, AsyncSnapshot<List<CatalogDetailResponse>> snapshot) {
        if (!snapshot.hasData) {
          bloc.getCatalog(null);
          return Center(child: CircularProgressIndicator());
        }
        var productsList = snapshot.data;
        return RefreshIndicator(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(16.0),
            childAspectRatio: 8.0 / 9.0,
            children: _buildList(productsList),
          ),
          onRefresh: () async {
            await bloc.handleGetCatalog(null);
          },
        );
      },
    );
  }

  List<ProductCard> _buildList(List<CatalogDetailResponse> productsList) {
    return productsList.map((product) {
      return ProductCard(product: product);
    }).toList();
  }

  void _onPressed(BuildContext context) async {
    await Preferences.clearValues();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (BuildContext context) => LoginScreen()
    ), (Route<dynamic> route) => false);
  }
}