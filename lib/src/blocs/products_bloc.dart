import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import '../resources/products_api_provider.dart';
import '../models/catalog_detail_response.dart';
import '../models/product_detail.dart';

class ProductsBloc {
  final ProductApiProvider api = ProductApiProvider();

  final BehaviorSubject<List<CatalogDetailResponse>> _catalog = BehaviorSubject<List<CatalogDetailResponse>>();
  final PublishSubject<ProductDetail> _productDetail = PublishSubject<ProductDetail>();
  final PublishSubject _getCatalog = PublishSubject();
  final PublishSubject<int> _getProductDetail = PublishSubject<int>();


  Observable<List<CatalogDetailResponse>> get catalog => _catalog.stream;
  Function get getCatalog => _getCatalog.sink.add;
  Observable<ProductDetail> get productDetail => _productDetail.stream;
  Function(int) get getProductDetail => _getProductDetail.sink.add;

  ProductsBloc() {
    _getCatalog.stream.listen(handleGetCatalog);
    _getProductDetail.stream.listen(_handleGetProduct);
  }

  //_ porque listen() si o si requiere un parametro de entrada
  ///Lo hago publico para poder llamarlo desde onRefresh, que necesita que se devuelva un Future
  Future<void> handleGetCatalog(_) async {
    final response = await api.getProducts();

    if (response.code == HttpStatus.OK) {
      _catalog.add(response.catalogList);
    }
    else {
      _catalog.sink.addError("ERROR");
    }
  }

  void _handleGetProduct(int id) async {
    final response = await api.getProductDetail(id);

    //No valido el codigo porque no estoy usando BaseResponse por cuestiones de reflection del lenguaje
    if (response != null) {
      _productDetail.add(response);
    }
    else {
      _productDetail.sink.addError("ERROR");
    }
  }

  dispose() {
    _catalog.close();
    _getCatalog.close();
    _productDetail.close();
    _getProductDetail.close();
  }
}