//this is the general class of all the auth provider
//implemented according to the auth type
import 'dart:convert';

abstract class AuthProvider{
  //If we want to send the auth details in headers
  Map<String,String> applyToHeaders(Map<String,String> headers);
  //if we want to send the auth details in the query params
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params);
  //convert the data to Json
  Map<String,dynamic> toJson();
}

//If the auth is type of api key
class ApiKeyAuthProvider implements AuthProvider{
  //api key name
  final String key;
  //api key value
  final String value;
  //send this api key in headers or query parameters
  final bool inHeader;

  ApiKeyAuthProvider({
    required this.key,
    required this.value,
    this.inHeader = true,
  });

  @override
  Map<String,String> applyToHeaders(Map<String,String> headers){
    if(inHeader){
      return {...headers,key:value};
    }
    return headers;
  }

  @override
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params){
    if(!inHeader){
      return {...params,key:value};
    }
    return params;
  }

  //For returning the data in json format
  @override
  Map<String,dynamic> toJson(){
    return {
      'type' : 'apiKey',
      'key' : key,
      'value' : value,
      'inHeader' : inHeader
    };
  }
}

//If the auth is type of basic means only username and password is used
class BasicAuthProvider implements AuthProvider{
  final String username;
  final String password;

  BasicAuthProvider({
    required this.username,
    required this.password
  });

  //Basic auth is only applied to auth never in query params so here it is
  @override
  Map<String,String> applyToHeaders(Map<String,String> headers){
    //first we have to convert username pass to string and the utf-8 bytes and convert that bytes in to base64 format
    final credentials = base64Encode(utf8.encode("$username : $password"));
    return {
      ...headers,
      //So this is fixed format and we must have to write in this format for the basic auth
      'Authorization': 'Basic $credentials',
    };
  }

  @override
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params){
    return params;
  }

  @override
  Map<String,dynamic> toJson(){
    return {
      'type' : "basic",
      'username' : username,
      'password' : password
    };
  }
}

//for the api requests with requires bearer as auth
//this bearer auth method also do not apply to query parameters always sent with the headers
class BearerAuthProvider implements AuthProvider{
  final String token;

  BearerAuthProvider({ required this.token});

  @override
  Map<String,String> applyToHeaders(Map<String,String> headers){
    return {
      ...headers,
      //this is pre defined format to write the bearer token
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params){
    return params;
  }

  @override
  Map<String,dynamic> toJson(){
    return{
      'type' : 'bearer',
      'token' : token
    };
  }
}