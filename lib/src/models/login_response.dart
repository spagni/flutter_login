import 'dataContracts/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LogInResponse extends BaseResponse with _$LogInResponseSerializerMixin {
  //Aca hay un error porque el json devuelve Token dentro de ResponseObject. 
  //En este caso referencio ResponseObject y le paso una funcion para extraer el token
  //Esto NO va a funcionar con clases que tienen mas de una propiedad porque no se puede
  //Referenciar con @JsonKey(name: 'ResponseObject') a mas de una property
  @JsonKey(name: 'ResponseObject', fromJson: _getResponseObject)
  String token;
  
  //Constructor que llama a super con los datos que vienen del json response. Code y Message se usan para 
  //Instanciar BaseResponse
  LogInResponse(int code, String message) : super(code, message);

  factory LogInResponse.fromJson(Map<String, dynamic> json) => _$LogInResponseFromJson(json);
}

String _getResponseObject(Map<String, dynamic> json) {
  //Recibo el responseObject y busco lo que necesito
  return json['Token'];
}