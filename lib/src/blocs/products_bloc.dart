import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import '../resources/products_api_provider.dart';
import '../models/catalog_detail_response.dart';

class ProductsBloc {
  final ProductApiProvider api = ProductApiProvider();

  final BehaviorSubject<List<CatalogDetailResponse>> _catalog = BehaviorSubject<List<CatalogDetailResponse>>();
  final PublishSubject _getCatalog = PublishSubject();

  Observable<List<CatalogDetailResponse>> get catalog => _catalog.stream;
  Function get getCatalog => _getCatalog.sink.add;

  ProductsBloc() {
    _getCatalog.stream.listen(handleGetCatalog);
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

  dispose() {
    _catalog.close();
    _getCatalog.close();
  }
}