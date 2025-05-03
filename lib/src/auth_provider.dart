//this is the general class of all the auth provider
//implemented according to the auth type
import 'dart:convert';

//abstract class to generalize all type of auth providers (basic,key-value(auth-api),and bearer)
abstract class AuthProvider{
  //If we want to send the auth details in headers
  Map<String,String> applyToHeaders(Map<String,String> headers);
  //if we want to send the auth details in the query params
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params);
  //convert the data to Json
  Map<String,dynamic> toJson();
}


//sub class of auth provider If the auth is type of api key
class ApiKeyAuthProvider implements AuthProvider{
  //api key name
  final String key;
  //api key value
  final String value;
  //send this api key in headers or query parameters
  final bool inHeader;

  //constructor
  ApiKeyAuthProvider({
    required this.key,
    required this.value,
    this.inHeader = true,
  });

  //function to apply api key in headers
  @override
  Map<String,String> applyToHeaders(Map<String,String> headers){
    if(inHeader){
      return {...headers,key:value};
    }
    return headers;
  }

  //function to apply api in query params
  @override
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params){
    if(!inHeader){
      return {...params,key:value};
    }
    return params;
  }

  //function For returning the data in json format
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

//sub class of auth provider If the auth is type of basic means only username and password is used
class BasicAuthProvider implements AuthProvider{
  //used for auth username and pass
  final String username;
  final String password;

  //constructor
  BasicAuthProvider({
    required this.username,
    required this.password
  });

  //Basic auth is only applied to auth never in query params so here it is
  //function to apply basic auth in headers
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

  //basic auth generally not applied to query params so return as it is
  @override
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params){
    return params;
  }

  //function to convert data in json format
  @override
  Map<String,dynamic> toJson(){
    return {
      'type' : "basic",
      'username' : username,
      'password' : password
    };
  }
}

//sub class of auth provider for the api requests with requires bearer as auth
//this bearer auth method also do not apply to query parameters always sent with the headers
class BearerAuthProvider implements AuthProvider{
  //token required for the bearer type auth
  final String token;

  //constructor
  BearerAuthProvider({ required this.token});

  //function to apply bearer auth to headers
  @override
  Map<String,String> applyToHeaders(Map<String,String> headers){
    return {
      ...headers,
      //this is pre defined format to write the bearer token
      'Authorization': 'Bearer $token',
    };
  }

  //also bearer auth is generally not applied to query params
  //so return query params as it is
  @override
  Map<String,dynamic> applyToQueryParams(Map<String,dynamic> params){
    return params;
  }

  //function to convert the data to json
  @override
  Map<String,dynamic> toJson(){
    return{
      'type' : 'bearer',
      'token' : token
    };
  }
}