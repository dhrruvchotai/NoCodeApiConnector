//This is the class that contains configuration of the individual requests.
import 'dart:convert';

//general data type for all http methods
enum HttpMethod{
  get,
  post,
  put,
  patch,
  delete
}

class RequestConfig{
  //Type of http method
  final HttpMethod method;
  //this path is the endpoint path which will be appended to the base url
  final String path;
  //query parameters
  final Map<String,dynamic>? queryParams;
  //only the specific headers for this request
  final Map<String,String>? headers;

  //request body
  final dynamic body;
  //select whether to use auth for this request or not
  final bool useAuth;

  //constructor
  RequestConfig({
    required this.method,
    required this.path,
    this.queryParams,
    this.headers,
    this.body,
    this.useAuth = true
  });

  //get the http method from string representation
  static methodFromString(String method){
    switch(method.toLowerCase()){
      case 'get' : return HttpMethod.get;
      case 'post' : return HttpMethod.post;
      case 'put' : return HttpMethod.put;
      case 'patch' : return HttpMethod.patch;
      case 'delete' : return HttpMethod.delete;
      default : throw ArgumentError('Invalid Http Method : $method');
    }
  }

  //Set all the values from the given data and set the values to variables
  factory RequestConfig.fromJson(Map<String,dynamic> jsonData){
    return RequestConfig(
        method: methodFromString(jsonData['method']),
        path: jsonData['path'],
        queryParams: jsonData['queryParams'],
        headers: jsonData['headers'] != null ? Map<String,String>.from(jsonData['headers']) : null,
        body: jsonData['body'],
        useAuth: jsonData['useAuth'] ?? true,
    );
  }

  //function to convert the data in json format
  Map<String,dynamic> toJson(){
    //return the result in the json format
   final result = <String,dynamic>{
     'method' : method.toString().split('.').last,
     'path' : path,
     'useAuth' : useAuth,
   };
   //add headers,queryParams and body to result if not null
   if(queryParams != null){
     result['queryParams'] = queryParams;
   }
   if(headers != null){
     result['headers'] = headers;
   }
   if(body != null){
     result['body'] = body;
   }
   return result;
  }
}