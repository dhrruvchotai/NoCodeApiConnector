import 'auth_provider.dart';

//This is the class that contains all the api information and methods for handling the data.
class ApiConfig{

  //Base url of the api
  final String baseUrl;

  //default headers for all the api requests that you will be sending
  final Map<String,String>? defaultHeaders;

  //authentication provider for your api requests
  final AuthProvider? authProvider;

  //time out duration for the requests
  final Duration timeout;

  ApiConfig({
    required this.baseUrl,
    this.defaultHeaders,
    this.authProvider,
    //by default wait for any request till 60 seconds
    this.timeout = const Duration(seconds: 60),
  });

  factory ApiConfig.fromJson(Map<String,dynamic> jsonData){
    AuthProvider? auth;
    
    if(jsonData.containsKey('auth')){
      final authData = jsonData['auth'] as Map<String,dynamic>;
      final authType = authData['type'] as String;

      switch(authType){
        case 'apiKey' :
          auth = ApiKeyAuthProvider(
              key: authData['key'],
              value: authData['value'],
              inHeader: authData['inHeader'] ?? true
          );
        break;

        case 'basic' :
          auth = BasicAuthProvider(username: authData['username'], password: authData['password']);
        break;

        case 'bearer' :
           auth = BearerAuthProvider(token: authData['token']);
        break;
      }
    }
    
    return ApiConfig(
        baseUrl: jsonData['baseUrl'],
        defaultHeaders: jsonData['defaultHeaders'] != null ? jsonData['defaultHeaders'] : null,
        authProvider : auth,
        timeout: jsonData['timeout'] != null ? Duration(milliseconds: jsonData['timeout']) : const Duration(seconds: 60),
    );
  }

  Map<String,dynamic> toJson() {
    final result = <String,dynamic> {
      'baseUrl' : baseUrl,
      'timeout' : timeout.inMilliseconds,
    };

    if(defaultHeaders != null){
      result['defaultHeaders'] = defaultHeaders;
    }

    if(authProvider != null){
      result['auth'] = authProvider!.toJson();
    }
    return result;
  }
}