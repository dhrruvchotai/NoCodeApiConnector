import 'dart:convert';
import 'dart:io';
import 'package:no_code_api_connector/no_code_api_connector.dart';
import 'package:http/http.dart' as http;

//This class is for connecting to api request,sending requests
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
    final uri = _buildUri(requestConfig);
    final headers = _buildHeaders(requestConfig);

    print("Url is : ${uri}");
    try{
      http.Response response;
      switch(requestConfig.method){
        case HttpMethod.get :
          response = await client.get(uri,headers: headers).timeout(config.timeout);
          break;
        case HttpMethod.post:
          response = await client.post(uri,headers: headers,body: _encodeBody(requestConfig, headers)).timeout(config.timeout);
          break;
        case HttpMethod.put:
          response = await client.put(uri, headers: headers, body: _encodeBody(requestConfig, headers)).timeout(config.timeout);
          break;
        case HttpMethod.delete:
          response = await client.delete(uri, headers: headers, body: _encodeBody(requestConfig, headers)).timeout(config.timeout);
          break;
        case HttpMethod.patch:
          response = await client.patch(uri, headers: headers, body: _encodeBody(requestConfig, headers)).timeout(config.timeout);
          break;
      }
      return _handleResponse(response);
    }
    catch(e){
      throw Exception('API request failed : $e');
    }
  }
  //function for building url according to the query params
  Uri _buildUri(RequestConfig requestConfig){
    final url = Uri.parse('${config.baseUrl}${requestConfig.path}');

    Map<String,dynamic> queryParams = requestConfig.queryParams ?? {};

    if (queryParams == null || queryParams.isEmpty) {
      return url;
    }

    if(requestConfig.useAuth && config.authProvider != null){
      queryParams = config.authProvider!.applyToQueryParams(queryParams);
    }

    final stringQueryParams = queryParams.map(
        (key,value) => MapEntry(key, value.toString())
    );

    return url.replace(queryParameters: stringQueryParams);
  }
  //function for building headers according to content type and the auth
  Map<String,String> _buildHeaders(RequestConfig requestConfig) {
    Map<String, String> headers = Map.from(config.defaultHeaders ?? {});

    if (requestConfig.headers != null) {
      headers.addAll(requestConfig.headers!);
    }

    if (requestConfig.useAuth && config.authProvider != null) {
      headers = config.authProvider!.applyToHeaders(headers);
    }

    if (requestConfig.body != null && !headers.containsKey('content-type') && !headers.containsKey('Content-Type')) {
      headers['Content-Type'] = 'application/json';
    }

    return headers;
  }
  //function for encoding body according to headers
  dynamic _encodeBody(RequestConfig requestConfig, Map<String,String> headers){
    if(requestConfig.body == null){
      return null;
    }
    //If with Content-Type is not there the check content-type
    final contentType = headers['Content-Type'] ?? headers['content-type'];
    if(contentType == 'application/json'){
      return jsonEncode(requestConfig.body);
    }
    return requestConfig.body;
  }
  //function for handling http response
  dynamic _handleResponse(http.Response response){
    if(response.statusCode >= 200 && response.statusCode <= 300){
      if(response.body.isEmpty){
        return {'statusCode' : response.statusCode};
      }
      return ResponseHandler.parseResponse(response.body, response.headers['Content-Type']);
    }
    else{
      //Handle the response with error
      throw HttpException("Request failed with status code : ${response.statusCode}",uri: response.request?.url);
    }
  }
  //function to dispose the used resources
  void dispose() {
    client.close();
  }

}