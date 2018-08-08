import 'package:flutter/material.dart';
import '../models/product_detail.dart';
import '../blocs/products_bloc_provider.dart';
import '../models/coverage.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  ProductDetailsScreen({this.productId});

  @override
  ProductDetailsScreenState createState() {
    return new ProductDetailsScreenState();
  }
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _slideAnim;
  AnimationController _coveragesController;
  Animation<Offset> _coveragesAnim;

  //Coverage description ROW
  int _selectedCoverage;
  int _lastCoverageSelected;//La uso para hacer la animacion de guardado de descripcion
  AnimationController _descriptionRowController;
  Animation<double> _rowAnimation;

  @override
    void initState() {
      super.initState();
      //Main Animation
      _controller = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this
      );
      _slideAnim = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
        .animate(_controller)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _coveragesController.forward();
          }
        });
      
      //Coverages Animation
      _coveragesController = AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this
      );
      _coveragesAnim = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
          parent: _coveragesController,
          curve: Curves.elasticOut
        ));
      //FORWARD      
      _controller.forward();

      //Description Row Animation
      _descriptionRowController = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this
      );
      _rowAnimation = CurvedAnimation(
        parent: _descriptionRowController,
        curve: Curves.easeOut
      );
    }

  @override
  Widget build(BuildContext context) {
    ProductsBloc _bloc = ProductsBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Product ${widget.productId}'),),
      body: StreamBuilder(
        stream: _bloc.productDetail,
        builder: (BuildContext context, AsyncSnapshot<ProductDetail> snapshot) {
          if (!snapshot.hasData) {
            _bloc.getProductDetail(widget.productId);
            return Center(child: CircularProgressIndicator(),);
          }

          ProductDetail product = snapshot.data;
          return SlideTransition(
            position: _slideAnim,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 10.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset('assets/images/${product.riskCode}.png', fit: BoxFit.fitWidth),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                      //Widgets que tienen padding. Los separo de la img para que ocupe todo el width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTitle(product),
                          Divider(height: 20.0, color: Theme.of(context).primaryColor,),
                          Text(
                            'Coverages',
                            style: Theme.of(context).textTheme.headline
                          ),
                          _buildCoverages(product.coverages)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTitle(ProductDetail product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          product.name,
          style: Theme.of(context).textTheme.headline
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 4.0),
              child: Icon(Icons.info, color: Theme.of(context).accentColor)
            ),
            Column(
              children: <Widget>[
                Text(
                  product.insuranceCompany.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Theme.of(context).accentColor
                  ),
                ),
                Text(
                  product.validityCode,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).accentColor
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCoverages(List<Coverage> coverages) {
    return SlideTransition(
      position: _coveragesAnim,
      child: ListView(
        shrinkWrap: true,
        children: coverages.map((i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            //Detecto el tap para desplegar la cobertura
            child: GestureDetector(
              onTap: () => _coverageTapped(i.id),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.check, size: 20.0, color: Theme.of(context).accentColor,),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          i.name, 
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400
                          )
                        ),
                        _buildDetailRow(i)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList()
      ),
    );
  }

  Widget _buildDetailRow(Coverage coverage) {
    //Si es la coverage elegida, animo la descripcion
    if (coverage.id == _selectedCoverage) {
      return SizeTransition(
        sizeFactor: _rowAnimation,
        child: Text(
          coverage.description,
          style: TextStyle(
            fontWeight: FontWeight.w300
          ),
        ),
      );
    }
    //Si es la coverage anterior, animo el guardado de la descripcion
    if (coverage.id == _lastCoverageSelected) {
      return SizeTransition(
        sizeFactor: Tween<double>(begin: 1.0, end: 0.0).animate(_descriptionRowController),
        child: Text(
          coverage.description,
          style: TextStyle(
            fontWeight: FontWeight.w300
          ),
        ),
      );
    }
    return Container();
  }

  void _coverageTapped(int id) {
    setState(() {
      _lastCoverageSelected = _selectedCoverage;
      _selectedCoverage = id;
    });
    if (_rowAnimation.status == AnimationStatus.completed) {
      _descriptionRowController.reset();
      _descriptionRowController.forward();
    }
    else {
      _descriptionRowController.forward();
    }
  }

  @override
    void dispose() {
      _controller.dispose();
      _coveragesController.dispose();
      super.dispose();
    }
}