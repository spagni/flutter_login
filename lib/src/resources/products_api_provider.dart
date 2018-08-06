import 'dart:async';
import 'dart:convert';
import '../utils/shared_preferences.dart';
import '../models/dataContracts/base_parameter.dart';
import '../models/catalog_response.dart';
import '../utils/http_requests_helper.dart';

class ProductApiProvider {
  final String _serverUri = 'http://oficina.kimn.com.ar:21000/CautusNew/ProductManager.svc/';

  Future<CatalogResponse> getProducts() async {
    BaseParameter _parameter = BaseParameter(token: await Preferences.getStringValue('Token'));
    final response = await HttpRequest.postAsync('${_serverUri}GetCatalog', json.encode(_parameter.toMap()));
    
    return CatalogResponse.fromJson(response);
  }

  //Future getProductDetail() {}
}