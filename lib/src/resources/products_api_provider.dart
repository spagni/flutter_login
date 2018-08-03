import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import '../utils/shared_preferences.dart';
import '../models/dataContracts/base_parameter.dart';
import '../models/catalog_response.dart';

//FALT CLASE HELPER QUE MANEJE TODAS LAS HTTP REQUEST
class ProductApiProvider {
  Client _httpClient = new Client();
  final String _serverUri = 'http://oficina.kimn.com.ar:21000/CautusNew/ProductManager.svc/';

  Future<CatalogResponse> getProducts() async {
    BaseParameter parameter = BaseParameter(token: await Preferences.getStringValue('Token'));
    final response = await _httpClient.post('${_serverUri}GetCatalog',
                                            body: json.encode(parameter.toMap()),
                                            headers: {HttpHeaders.CONTENT_TYPE: 'application/json'});
    final jsonResponse = json.decode(response.body);
    
    return CatalogResponse.fromJson(jsonResponse);
  }
}