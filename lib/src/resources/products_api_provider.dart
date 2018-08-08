import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../utils/shared_preferences.dart';
import '../models/dataContracts/base_parameter.dart';
import '../models/catalog_response.dart';
import '../models/product_detail.dart';
import '../utils/http_requests_helper.dart';

class ProductApiProvider {
  final String _serverUri = 'http://oficina.kimn.com.ar:21000/CautusNew/ProductManager.svc/';

  Future<CatalogResponse> getProducts() async {
    BaseParameter _parameter = BaseParameter(token: await Preferences.getStringValue('Token'));
    final response = await HttpRequest.postAsync('${_serverUri}GetCatalog', json.encode(_parameter.toMap()));
    
    return CatalogResponse.fromJson(response);
  }

  Future<ProductDetail> getProductDetail(int id) async{
    String _token = await Preferences.getStringValue('Token');
    String _body = "{\"Token\":\"$_token\",\"Language\":\"en\",\"RequestObject\":{\"Id\":\"$id\"}}";
    final response = await HttpRequest.postAsync('${_serverUri}GetProductDetail', _body);

    //NO USO BASERESPONSE Y VALIDO EL CODIGO ACA
    if (response['Code'] == HttpStatus.OK) {
      return ProductDetail.fromJson(response['ResponseObject']);
    }
    return null;
  }
}