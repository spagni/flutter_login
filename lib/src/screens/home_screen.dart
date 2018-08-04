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
        leading: Icon(Icons.menu),
        title: Text('Cautus'),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.send),
          )
        ],
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
        return Container(
          height: 210.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(19.0, 16.0,16.0,4.0),
                child: Text('Select a product', textAlign: TextAlign.left, style: Theme.of(context).textTheme.subhead),
              ),
              Expanded(
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 1,
                  mainAxisSpacing: 2.0,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  childAspectRatio: 6.0 /5.0,
                  children: _buildList(productsList),
                ),
              )
            ],
          ),
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