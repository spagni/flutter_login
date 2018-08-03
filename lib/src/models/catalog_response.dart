import 'dataContracts/base_response.dart';
import 'catalog_detail_response.dart';
class CatalogResponse extends BaseResponse {
  List<CatalogDetailResponse> catalogList;
    
  //Paso "Code" y "Message" a BaseResponse
  CatalogResponse.fromJson(Map<String, dynamic> json) : super(json['Code'], json['Message']) {
    catalogList = _buildList(json['ResponseObject']['ListItems'] as List);
  }

  //Function que recorre el array y va creando los CatalogDetailResponse
  List<CatalogDetailResponse> _buildList(List json) {
    List<CatalogDetailResponse> list;
    list = json.map((i) => CatalogDetailResponse.fromJson(i)).toList();
    return list;
  }
}