class CatalogDetailResponse {
  int productDetailId;
  String name;
  String riskCode;
  double price;
  bool isNew;
  int soldProducts;
    
  CatalogDetailResponse.fromJson(Map<String, dynamic> json)
  : productDetailId = json['ProductDetailId'],
    name = json['Name'],
    riskCode = json['RiskCode'],
    price = json['Price'],
    isNew = json['IsNew'],
    soldProducts = json['SoldProducts'];      
}