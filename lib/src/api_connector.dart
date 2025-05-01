import 'package:no_code_api_connector/no_code_api_connector.dart';
import 'package:http/http.dart' as http;

class ApiConnector{
  final ApiConfig config;
  final http.Client client;

  //For My Knowledge :
  //This is constructor with initializer list means you can initialize the final and const variable before the constructor body runs!
  //It Means doing like this :
  //ApiConnector(this.config) : client = http.Client() {
  // print("Api Connector created");
  // };
  ApiConnector(this.config) : client = http.Client();

  Future<dynamic> sendRequest(RequestConfig requestConfig) async{

  }

}